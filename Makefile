.PHONY: all install discover brew casks cli configs set_permissions backup_configs

DOTFILES_DIR := $(HOME)/dotfiles

all: install

set_permissions:
	@echo "Setting correct permissions..."
	@chmod +x app_discovery.sh brew_discovery.sh cli_tools_discovery.sh

discover: set_permissions
	@echo "Discovering system state..."
	@./cli_tools_discovery.sh
	@./app_discovery.sh
	@./brew_discovery.sh

install: brew casks cli configs

brew:
	@echo "Installing Homebrew formulae..."
	@xargs brew install < user_installed_formulae.txt

casks:
	@echo "Installing cask applications..."
	@xargs brew install --cask < user_installed_casks.txt

cli:
	@echo "Installing CLI tools..."
	@cat essential_cli_tools.txt | xargs -I {} brew install {} || true

backup_configs:
	@echo "Backing up configuration files..."
	@mkdir -p $(DOTFILES_DIR)
	@cp -f $(HOME)/.zshrc $(DOTFILES_DIR)/.zshrc || true
	@cp -f $(HOME)/.config/starship.toml $(DOTFILES_DIR)/starship.toml || true
	@cp -f $(HOME)/.config/nvim/init.lua $(DOTFILES_DIR)/init.lua || true
	@cp -f "$(HOME)/Library/Application Support/Cursor/User/profiles/48fc2b27/keybindings.json" $(DOTFILES_DIR)/keybindings.json || true
	@cp -f "$(HOME)/Library/Application Support/Cursor/User/profiles/48fc2b27/settings.json" $(DOTFILES_DIR)/settings.json || true
	@cp -f $(HOME)/.config/karabiner/karabiner.json $(DOTFILES_DIR)/karabiner.json || true
	@echo "Backup complete. Files saved in $(DOTFILES_DIR)"

configs: backup_configs
	@echo "Setting up configurations..."
	@cp -f $(DOTFILES_DIR)/.zshrc $(HOME)/.zshrc || true
	@mkdir -p $(HOME)/.config
	@cp -f $(DOTFILES_DIR)/starship.toml $(HOME)/.config/starship.toml || true
	@mkdir -p $(HOME)/.config/nvim
	@cp -f $(DOTFILES_DIR)/init.lua $(HOME)/.config/nvim/init.lua || true
	@mkdir -p "$(HOME)/Library/Application Support/Cursor/User/profiles/48fc2b27"
	@cp -f $(DOTFILES_DIR)/keybindings.json "$(HOME)/Library/Application Support/Cursor/User/profiles/48fc2b27/keybindings.json" || true
	@cp -f $(DOTFILES_DIR)/settings.json "$(HOME)/Library/Application Support/Cursor/User/profiles/48fc2b27/settings.json" || true
	@mkdir -p $(HOME)/.config/karabiner
	@cp -f $(DOTFILES_DIR)/karabiner.json $(HOME)/.config/karabiner/karabiner.json || true

	# TODO:
	# @echo "Setting up environment variables..."
	# @./setup_env.sh

manual_installs:
	@echo "The following applications may need manual installation:"
	@comm -23 <(sort user_apps.txt) <(sort user_installed_casks.txt)
