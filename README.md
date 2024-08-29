# Mac Dotfiles

This repository contains my personal dotfiles and setup scripts for quickly reproducing my development environment on a new macOS machine or backing up my current setup.

## Purpose

- Quickly set up a new Mac with your preferred development environment
- Easily backup your current Mac setup
- Streamline the process of installing and updating tools and applications

## Prerequisites

Before you begin, ensure you have the following installed:

1. Xcode Command Line Tools:
   ```
   xcode-select --install
   ```

2. Homebrew:
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. Git (if not already installed):
   ```
   brew install git
   ```

4. Make (if not already installed):
   ```
   brew install make
   ```

## Getting Started

1. Clone this repository:
   ```
   git clone https://github.com/joryeugene/mac-dotfiles
   cd mac-dotfiles
   ```

2. Review and customize the following files:
   - `user_installed_formulae.txt`: List of Homebrew formulae to install
   - `user_installed_casks.txt`: List of Homebrew casks to install
   - `essential_cli_tools.txt`: List of CLI tools to install

3. Update the `backup_configs` and `configs` targets in the Makefile to match your desired configuration files and paths.

## Usage

- `make help`: Show all available commands
- `make all`: Run the entire installation process
- `make install`: Install everything (brew, casks, cli tools, and configs)
- `make discover`: Discover current system state
- `make update`: Update system packages and tools
- `make backup_configs`: Backup current configuration files

## Customization

You may want to update the following areas in the Makefile:

1. Configuration paths:
   - Update paths in the `backup_configs` and `configs` targets to match your setup
   - Current paths include configurations for:
     - zsh
     - starship
     - neovim
     - Cursor (VS Code fork)
     - karabiner
   - Add or remove paths as needed for your specific applications

2. Manual installs:
   - Update the `manual_installs` target to include your preferred applications that require manual installation

3. Update process:
   - Modify the `update` target to include or exclude specific tools based on your needs

## Use Cases

1. **New Mac Setup**: Run `make all` to install and configure your development environment on a new Mac.
2. **Backup Current Setup**: Use `make backup_configs` to create a backup of your current configuration files.
3. **Sync Across Machines**: Keep your dotfiles repository updated and use it to sync your development environment across multiple Macs.
4. **Quick Tool Installation**: Use `make cli` to quickly install your essential CLI tools on any Mac.
5. **System Update**: Run `make update` periodically to keep your system and tools up to date.

