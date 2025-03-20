SHELL := /usr/bin/env zsh

.PHONY: all install discover brew casks cli configs set_permissions backup_configs help manual_installs update check_dependencies compare_cursor_profiles sync_cursor_profiles check_outdated clean health_check list_installed update_npm node_check new_computer

DOTFILES_DIR := $(HOME)/dotfiles
BREW := brew
PIPX := pipx
NPM := npm
RUSTUP := rustup
GO := go
VIM := vim
NVIM := nvim

.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "  make help              - Show this help message"
	@echo "  make all               - Run the entire installation process"
	@echo "  make check_outdated    - Check for outdated packages"
	@echo "  make clean             - Clean up system caches"
	@echo "  make health_check      - Check system health"
	@echo "  make list_installed    - List all installed packages"
	@echo "  make install           - Install everything (brew, casks, cli tools, and configs)"
	@echo "  make discover          - Discover system state (CLI tools, apps, and Brew packages)"
	@echo "  make brew              - Install Homebrew formulae"
	@echo "  make casks             - Install cask applications"
	@echo "  make cli               - Install CLI tools"
	@echo "  make configs           - Set up configuration files"
	@echo "  make backup_configs    - Backup current configuration files"
	@echo "  make set_permissions   - Set correct permissions for discovery scripts"
	@echo "  make manual_installs   - Show applications that may need manual installation"
	@echo "  make update            - Update system packages and tools"
	@echo "  make check_dependencies - Check if all required tools are installed"
	@echo "  make compare_cursor_profiles - Show differences between Cursor profiles"
	@echo "  make sync_cursor_profiles - Sync default profile settings to other profiles"
	@echo "  make update_npm        - Update global NPM packages"
	@echo "  make node_check        - Check Node.js environment"
	@echo "  make new_computer      - Set up configs on a new computer (without backup)"

all: set_permissions check_dependencies install manual_installs update

install: brew casks cli configs

check_dependencies:
	@command -v $(BREW) >/dev/null 2>&1 || (echo "Homebrew is not installed. Please install it first." && exit 1)
	@command -v git >/dev/null 2>&1 || (echo "Git is not installed. Please install it first." && exit 1)
	@command -v make >/dev/null 2>&1 || (echo "Make is not installed. Please install it first." && exit 1)

set_permissions:
	@echo "Setting correct permissions..."
	@chmod +x app_discovery.sh brew_discovery.sh cli_tools_discovery.sh

discover: set_permissions backup_configs
	@echo "Discovering system state...and backing up configs"
	@./cli_tools_discovery.sh
	@./app_discovery.sh
	@./brew_discovery.sh

brew:
	@echo "Installing Homebrew formulae..."
	@cat user_installed_formulae.txt | while read formula; do \
		if ! $(BREW) list --formula | grep -q "^$$formula$$"; then \
			echo "Installing $$formula..."; \
			$(BREW) install $$formula; \
		else \
			echo "$$formula is already installed. Skipping."; \
		fi; \
	done

casks:
	@echo "Installing cask applications..."
	@cat user_installed_casks.txt | while read cask; do \
		if ! $(BREW) list --cask | grep -q "^$$cask$$"; then \
			echo "Installing $$cask..."; \
			$(BREW) install --cask $$cask; \
		else \
			echo "$$cask is already installed. Skipping."; \
		fi; \
	done

cli:
	@echo "Installing CLI tools..."
	@cat essential_cli_tools.txt | while read tool; do \
		if ! $(BREW) list --formula | grep -q "^$$tool$$"; then \
			echo "Installing $$tool..."; \
			$(BREW) install $$tool || true; \
		else \
			echo "$$tool is already installed. Skipping."; \
		fi; \
	done
	@if ! command -v zinit >/dev/null 2>&1; then \
		echo "Installing zinit..."; \
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/main/scripts/install.sh)"; \
		echo "Zinit installed successfully"; \
	fi
	@if ! command -v zoxide >/dev/null 2>&1; then \
		echo "Installing zoxide..."; \
		$(BREW) install zoxide; \
		echo "Zoxide installed successfully"; \
	fi

backup_configs:
	@echo "Backing up configuration files..."
	@mkdir -p $(DOTFILES_DIR)
	@mkdir -p $(DOTFILES_DIR)/.obsidian
	@mkdir -p $(DOTFILES_DIR)/zellij/themes
	@mkdir -p $(DOTFILES_DIR)/cursor_profiles
	@mkdir -p $(DOTFILES_DIR)/lua/config

	# Backup all Cursor profiles
	@find "$(HOME)/Library/Application Support/Cursor/User/profiles" -type f \( -name "keybindings.json" -o -name "settings.json" \) -exec bash -c '\
		profile_dir=$$(dirname "{}"); \
		profile_name=$$(basename $$profile_dir); \
		mkdir -p $(DOTFILES_DIR)/cursor_profiles/$$profile_name; \
		cp -f "{}" $(DOTFILES_DIR)/cursor_profiles/$$profile_name/ \
	' \;

	# Backup default profile settings
	@mkdir -p $(DOTFILES_DIR)/cursor_profiles/default
	@cp -f "$(HOME)/Library/Application Support/Cursor/User/keybindings.json" $(DOTFILES_DIR)/cursor_profiles/default/keybindings.json || true
	@cp -f "$(HOME)/Library/Application Support/Cursor/User/settings.json" $(DOTFILES_DIR)/cursor_profiles/default/settings.json || true

	# Backup Neovim configurations
	@mkdir -p $(DOTFILES_DIR)/lua/config
	@cp -f $(HOME)/.config/nvim/init.lua $(DOTFILES_DIR)/init.lua || true
	@cp -f $(HOME)/.config/nvim/lua/config/core.lua $(DOTFILES_DIR)/lua/config/core.lua || true
	@cp -f $(HOME)/.config/nvim/lua/config/nvim.lua $(DOTFILES_DIR)/lua/config/nvim.lua || true
	@cp -f $(HOME)/.config/nvim/lua/config/vscode.lua $(DOTFILES_DIR)/lua/config/vscode.lua || true

	# Rest of existing backup operations
	@cp -f $(HOME)/.zshrc $(DOTFILES_DIR)/.zshrc || true
	@cp -f $(HOME)/.wezterm.lua $(DOTFILES_DIR)/.wezterm.lua || true
	@cp -f $(HOME)/.zsh_functions $(DOTFILES_DIR)/.zsh_functions || true
	@cp -f $(HOME)/.zsh_aliases $(DOTFILES_DIR)/.zsh_aliases || true
	@cp -f $(HOME)/.config/starship.toml $(DOTFILES_DIR)/starship.toml || true
	@cp -f $(HOME)/.config/zellij/config.kdl $(DOTFILES_DIR)/zellij/config.kdl || true
	@cp -f $(HOME)/.config/zellij/themes/* $(DOTFILES_DIR)/zellij/themes/ || true
	@cp -f "$(HOME)/Documents/calmhive/.obsidian.vimrc" $(DOTFILES_DIR)/.obsidian.vimrc || true
	@cp -f "$(HOME)/Documents/calmhive/.obsidian/app.json" $(DOTFILES_DIR)/.obsidian/app.json || true
	@cp -f "$(HOME)/Documents/calmhive/.obsidian/appearance.json" $(DOTFILES_DIR)/.obsidian/appearance.json || true
	@cp -f "$(HOME)/Documents/calmhive/.obsidian/community-plugins.json" $(DOTFILES_DIR)/.obsidian/community-plugins.json || true
	@cp -f "$(HOME)/Documents/calmhive/.obsidian/hotkeys.json" $(DOTFILES_DIR)/.obsidian/hotkeys.json || true
	@cp -f $(HOME)/.config/karabiner/karabiner.json $(DOTFILES_DIR)/karabiner.json || true
	@echo "Backup complete. Files saved in $(DOTFILES_DIR)"

configs:
	@echo "Setting up configurations..."
	@if [ ! -d "$(DOTFILES_DIR)" ]; then \
		echo "Dotfiles directory not found. Please run 'make backup_configs' first or ensure your dotfiles repo is cloned to $(DOTFILES_DIR)"; \
		exit 1; \
	fi

	# Restore all Cursor profiles with better error handling
	@echo "Setting up Cursor profiles..."
	@mkdir -p "$(HOME)/Library/Application Support/Cursor/User/profiles"
	@if [ -f "cursor_profiles/default/settings.json" ]; then \
		echo "Found Cursor settings.json, copying..."; \
		cp -f "cursor_profiles/default/settings.json" "$(HOME)/Library/Application Support/Cursor/User/settings.json"; \
		echo "Successfully copied Cursor settings.json"; \
	else \
		echo "Warning: cursor_profiles/default/settings.json not found"; \
	fi
	@if [ -f "cursor_profiles/default/keybindings.json" ]; then \
		echo "Found Cursor keybindings.json, copying..."; \
		cp -f "cursor_profiles/default/keybindings.json" "$(HOME)/Library/Application Support/Cursor/User/keybindings.json"; \
		echo "Successfully copied Cursor keybindings.json"; \
	else \
		echo "Warning: cursor_profiles/default/keybindings.json not found"; \
	fi

	# Basic shell config files with better error handling
	@echo "Setting up shell config files..."
	@if [ -f ".zshrc" ]; then \
		cp -f ".zshrc" "$(HOME)/"; \
		echo "Copied .zshrc"; \
	else \
		echo "Warning: .zshrc not found"; \
	fi
	@if [ -f ".zsh_aliases" ]; then \
		cp -f ".zsh_aliases" "$(HOME)/"; \
		echo "Copied .zsh_aliases"; \
	else \
		echo "Warning: .zsh_aliases not found"; \
	fi
	@if [ -f ".zsh_functions" ]; then \
		cp -f ".zsh_functions" "$(HOME)/"; \
		echo "Copied .zsh_functions"; \
	else \
		echo "Warning: .zsh_functions not found"; \
	fi
	@if [ -f ".wezterm.lua" ]; then \
		cp -f ".wezterm.lua" "$(HOME)/"; \
		echo "Copied .wezterm.lua"; \
	else \
		echo "Warning: .wezterm.lua not found"; \
	fi

	# Add source commands to .zshrc if not present
	@echo "Checking .zshrc for required source commands..."
	@if ! grep -q "source ~/.zsh_aliases" "$(HOME)/.zshrc"; then \
		echo "Adding source commands to .zshrc..."; \
		echo "\n# Source aliases and functions" >> "$(HOME)/.zshrc"; \
		echo "source ~/.zsh_aliases" >> "$(HOME)/.zshrc"; \
		echo "source ~/.zsh_functions" >> "$(HOME)/.zshrc"; \
		echo "Added source commands to .zshrc"; \
	fi
	@if ! grep -q "zoxide init zsh" "$(HOME)/.zshrc"; then \
		echo "Adding zoxide initialization to .zshrc..."; \
		echo "\n# Initialize zoxide" >> "$(HOME)/.zshrc"; \
		echo 'eval "$(zoxide init zsh)"' >> "$(HOME)/.zshrc"; \
		echo "Added zoxide initialization to .zshrc"; \
	fi

	# Application configs
	@echo "Setting up application configs..."
	@mkdir -p "$(HOME)/.config"
	@cp -f starship.toml "$(HOME)/.config/" 2>/dev/null || true

	@mkdir -p "$(HOME)/.config/zellij/themes"
	@if [ -d "zellij" ]; then \
		cp -rf "zellij/"* "$(HOME)/.config/zellij/" 2>/dev/null || true; \
		echo "Copied zellij configs"; \
	fi

	@mkdir -p "$(HOME)/Documents/calmhive/.obsidian"
	@cp -f .obsidian.vimrc "$(HOME)/Documents/calmhive/" 2>/dev/null || true
	@if [ -d ".obsidian" ]; then \
		cp -rf ".obsidian/"* "$(HOME)/Documents/calmhive/.obsidian/" 2>/dev/null || true; \
		echo "Copied Obsidian configs"; \
	fi

	@mkdir -p "$(HOME)/.config/karabiner"
	@cp -f karabiner.json "$(HOME)/.config/karabiner/" 2>/dev/null || true
	@echo "Copied karabiner config"

	@echo "Configuration setup complete."
	@echo "NOTE: To make shell changes take effect immediately, run: source ~/.zshrc"
	@echo "NOTE: Please restart Cursor and Wezterm for their configurations to take effect."

# New target specifically for setting up a new computer
new_computer:
	@echo "Setting up new computer with dotfiles from $(DOTFILES_DIR)"
	@if [ ! -d "$(DOTFILES_DIR)" ]; then \
		echo "Error: Dotfiles directory not found at $(DOTFILES_DIR)"; \
		echo "Please clone your dotfiles repository first:"; \
		echo "  git clone <your-dotfiles-repo-url> $(DOTFILES_DIR)"; \
		exit 1; \
	fi
	@echo "Checking for dotfiles in $(DOTFILES_DIR)..."
	@ls -la $(DOTFILES_DIR)
	@echo "Creating necessary directories..."
	@mkdir -p $(HOME)/.config/nvim/lua/config
	@mkdir -p $(HOME)/.config/zellij/themes
	@mkdir -p "$(HOME)/Documents/calmhive/.obsidian"
	@mkdir -p $(HOME)/.config/karabiner
	@mkdir -p "$(HOME)/Library/Application Support/Cursor/User/profiles"

	@echo "Installing required tools..."
	@if ! command -v zinit >/dev/null 2>&1; then \
		echo "Installing zinit..."; \
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/main/scripts/install.sh)"; \
	fi
	@if ! command -v pyenv >/dev/null 2>&1; then \
		echo "Installing pyenv..."; \
		brew install pyenv; \
	fi

	@echo "Setting up zsh configurations..."
	@cp -f .zshrc "$(HOME)/" 2>/dev/null || true
	@cp -f .zsh_aliases "$(HOME)/" 2>/dev/null || true
	@cp -f .zsh_functions "$(HOME)/" 2>/dev/null || true

	@echo "Adding source commands to .zshrc..."
	@if ! grep -q "source ~/.zsh_aliases" "$(HOME)/.zshrc"; then \
		echo "\n# Source aliases and functions" >> "$(HOME)/.zshrc"; \
		echo "source ~/.zsh_aliases" >> "$(HOME)/.zshrc"; \
		echo "source ~/.zsh_functions" >> "$(HOME)/.zshrc"; \
		echo "Added source commands to .zshrc"; \
	fi

	@echo "Installing configurations from your dotfiles repository..."
	@$(MAKE) configs
	@echo "New computer setup complete!"
	@echo "To make shell changes take effect immediately, run: source ~/.zshrc"
	@echo "Please restart Cursor and Wezterm for their configurations to take effect."

manual_installs:
	@echo "\nApplications that may need manual installation:"
	@sort user_apps.txt > /tmp/sorted_user_apps.txt
	@sort user_installed_casks.txt > /tmp/sorted_user_installed_casks.txt
	@comm -23 /tmp/sorted_user_apps.txt /tmp/sorted_user_installed_casks.txt | while read app; do \
		echo "$$app"; \
		case "$$app" in \
			"Rectangle Pro") echo "  Download from: https://rectangleapp.com/pro" ;; \
			"Superhuman") echo "  Download from: https://superhuman.com/download" ;; \
			"Zen Browser") echo "  Download from: https://www.zen-browser.app/" ;; \
			*) echo "  Please search and download manually" ;; \
		esac; \
	done
	@rm /tmp/sorted_user_apps.txt /tmp/sorted_user_installed_casks.txt

update:
	@echo "Updating system packages and tools..."
	-@$(BREW) update
	-@$(BREW) upgrade
	-@$(BREW) cleanup
	-@$(BREW) doctor || true
	@echo "Homebrew update complete."
	@if command -v $(PIPX) >/dev/null 2>&1; then \
		echo "Updating pipx packages..."; \
		$(PIPX) upgrade-all; \
	else \
		echo "pipx not found, skipping"; \
	fi
	@if command -v $(NPM) >/dev/null 2>&1; then \
		echo "Updating npm packages..."; \
		$(NPM) update -g; \
	else \
		echo "npm not found, skipping"; \
	fi
	@if command -v $(VIM) >/dev/null 2>&1; then \
		echo "Updating Vim plugins..."; \
		$(VIM) +PlugUpdate +qall; \
	else \
		echo "vim not found, skipping"; \
	fi
	@if command -v $(NVIM) >/dev/null 2>&1; then \
		echo "Updating Neovim plugins..."; \
		$(NVIM) +PlugUpdate +qall; \
	else \
		echo "nvim not found, skipping"; \
	fi
	@echo "System update complete."

compare_cursor_profiles:
	@echo "Comparing Cursor profiles..."
	@profile_dir="$$(find "$(HOME)/Library/Application Support/Cursor/User/profiles" -type d -mindepth 1 -maxdepth 1 | head -n 1)"; \
	for file in keybindings.json settings.json; do \
		echo "\n=== Comparing $$file ==="; \
		if [ -f "$(HOME)/Library/Application Support/Cursor/User/$$file" ] && [ -f "$$profile_dir/$$file" ]; then \
			diff -u --color "$(HOME)/Library/Application Support/Cursor/User/$$file" "$$profile_dir/$$file" || true; \
		else \
			echo "Could not find both profile files to compare"; \
		fi; \
	done

sync_cursor_profiles:
	@echo "Syncing default profile settings to other profiles..."
	@profile_dir="$$(find "$(HOME)/Library/Application Support/Cursor/User/profiles" -type d -mindepth 1 -maxdepth 1 | head -n 1)"; \
	if [ -n "$$profile_dir" ]; then \
		cp -v "$(HOME)/Library/Application Support/Cursor/User/keybindings.json" "$$profile_dir/keybindings.json"; \
		cp -v "$(HOME)/Library/Application Support/Cursor/User/settings.json" "$$profile_dir/settings.json"; \
		echo "Sync complete."; \
	else \
		echo "No profile directory found to sync to."; \
	fi

check_outdated: check_dependencies
	@echo "Checking for outdated packages..."
	@$(BREW) outdated
	@$(PIPX) list --outdated 2>/dev/null || true
	@$(NPM) outdated -g 2>/dev/null || true

clean: check_dependencies
	@echo "Cleaning up system..."
	@$(BREW) cleanup --prune=7 # Only remove files older than 7 days
	-@$(BREW) autoremove 2>/dev/null || true
	@echo "Cleaned up old Homebrew files"

health_check: check_dependencies
	@echo "Checking system health..."
	@$(BREW) missing 2>/dev/null || echo "Some Homebrew dependencies missing"
	@command -v node >/dev/null 2>&1 || echo "Node.js not installed"
	@command -v python3 >/dev/null 2>&1 || echo "Python not installed"
	@echo "Health check complete."

list_installed: check_dependencies
	@echo "Listing all installed packages..."
	@echo "\nHomebrew Formulae:"
	@$(BREW) list --formula
	@echo "\nHomebrew Casks:"
	@$(BREW) list --cask
	@echo "\nNPM Global Packages:"
	@$(NPM) list -g --depth=0 2>/dev/null || echo "npm not installed"
	@echo "\nPipx Packages:"
	@$(PIPX) list 2>/dev/null || echo "pipx not installed"

update_npm: check_dependencies
	@echo "Updating NPM packages..."
	@$(NPM) install -g npm@10.8.2 # Pin to a compatible version
	@$(NPM) install -g bash-language-server@latest
	@$(NPM) install -g create-next-app@latest
	@$(NPM) install -g pyright@latest
	@$(NPM) install -g typescript@latest
	@echo "NPM packages updated."

node_check: check_dependencies
	@echo "Checking Node.js environment..."
	@node --version
	@npm --version
	@echo "\nGlobal NPM packages:"
	@npm list -g --depth=0
	@echo "\nNode.js environment check complete."
