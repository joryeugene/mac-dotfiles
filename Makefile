SHELL := /usr/bin/env zsh

.PHONY: all install discover brew casks cli configs set_permissions backup_configs help manual_installs update check_dependencies compare_cursor_profiles sync_cursor_profiles

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

backup_configs:
	@echo "Backing up configuration files..."
	@mkdir -p $(DOTFILES_DIR)
	@mkdir -p $(DOTFILES_DIR)/.obsidian
	@mkdir -p $(DOTFILES_DIR)/zellij/themes
	@mkdir -p $(DOTFILES_DIR)/cursor_profiles

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

	# Rest of existing backup operations
	@cp -f $(HOME)/.zshrc $(DOTFILES_DIR)/.zshrc || true
	@cp -f $(HOME)/.wezterm.lua $(DOTFILES_DIR)/.wezterm.lua || true
	@cp -f $(HOME)/.zsh_functions $(DOTFILES_DIR)/.zsh_functions || true
	@cp -f $(HOME)/.zsh_aliases $(DOTFILES_DIR)/.zsh_aliases || true
	@cp -f $(HOME)/.config/starship.toml $(DOTFILES_DIR)/starship.toml || true
	@cp -f $(HOME)/.config/nvim/init.lua $(DOTFILES_DIR)/init.lua || true
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

	# Restore all Cursor profiles
	@find $(DOTFILES_DIR)/cursor_profiles -type f \( -name "keybindings.json" -o -name "settings.json" \) -exec bash -c '\
		source_file="{}"; \
		profile_name=$$(basename $$(dirname "{}")) ; \
		if [ "$$profile_name" = "default" ]; then \
			target_dir="$(HOME)/Library/Application Support/Cursor/User"; \
		else \
			target_dir="$(HOME)/Library/Application Support/Cursor/User/profiles/$$profile_name"; \
		fi; \
		mkdir -p "$$target_dir"; \
		cp -f "$$source_file" "$$target_dir/" \
	' \;

	# Rest of existing config operations
	@cp -f $(DOTFILES_DIR)/.wezterm.lua $(HOME)/.wezterm.lua || true
	@cp -f $(DOTFILES_DIR)/.zshrc $(HOME)/.zshrc || true
	@cp -f $(DOTFILES_DIR)/.zsh_functions $(HOME)/.zsh_functions || true
	@cp -f $(DOTFILES_DIR)/.zsh_aliases $(HOME)/.zsh_aliases || true
	@mkdir -p $(HOME)/.config
	@cp -f $(DOTFILES_DIR)/starship.toml $(HOME)/.config/starship.toml || true
	@mkdir -p $(HOME)/.config/nvim
	@cp -f $(DOTFILES_DIR)/init.lua $(HOME)/.config/nvim/init.lua || true
	@mkdir -p $(HOME)/.config/zellij/themes
	@cp -f $(DOTFILES_DIR)/zellij/config.kdl $(HOME)/.config/zellij/config.kdl || true
	@cp -f $(DOTFILES_DIR)/zellij/themes/* $(HOME)/.config/zellij/themes/ || true
	@mkdir -p "$(HOME)/Documents/calmhive/.obsidian"
	@cp -f $(DOTFILES_DIR)/.obsidian.vimrc "$(HOME)/Documents/calmhive/.obsidian.vimrc" || true
	@cp -f $(DOTFILES_DIR)/.obsidian/app.json "$(HOME)/Documents/calmhive/.obsidian/app.json" || true
	@cp -f $(DOTFILES_DIR)/.obsidian/appearance.json "$(HOME)/Documents/calmhive/.obsidian/appearance.json" || true
	@cp -f $(DOTFILES_DIR)/.obsidian/community-plugins.json "$(HOME)/Documents/calmhive/.obsidian/community-plugins.json" || true
	@cp -f $(DOTFILES_DIR)/.obsidian/hotkeys.json "$(HOME)/Documents/calmhive/.obsidian/hotkeys.json" || true
	@mkdir -p $(HOME)/.config/karabiner
	@cp -f $(DOTFILES_DIR)/karabiner.json $(HOME)/.config/karabiner/karabiner.json || true

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
