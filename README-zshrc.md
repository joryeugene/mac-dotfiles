# Zsh Configuration

This document provides an overview of the custom Zsh configuration, including key features, aliases, functions, and common workflows.

## Table of Contents

1. [Features](#features)
2. [Installation](#installation)
3. [Key Bindings](#key-bindings)
4. [Aliases](#aliases)
5. [Functions](#functions)
6. [Common Workflows](#common-workflows)
7. [Plugin Configurations](#plugin-configurations)
8. [Customization](#customization)

## Features

- Oh My Zsh with Powerlevel10k theme
- Vi-mode for command line editing
- Custom aliases and functions for productivity
- Integration with tools like Git, Docker, Python, and Node.js
- FZF for fuzzy finding
- Syntax highlighting and autosuggestions
- Custom Claude CLI integration

## Installation

1. Ensure you have Zsh installed
2. Install [Oh My Zsh](https://ohmyz.sh/)
3. Clone this repository
4. Symlink the `.zshrc` file to your home directory:
   ```
   ln -s /path/to/repo/.zshrc ~/.zshrc
   ```
5. Install required plugins and tools (see [Plugin Configurations](#plugin-configurations))

## Key Bindings

- `Ctrl+R`: Fuzzy search through command history
- `Ctrl+E`: Edit current command in vim
- `jk`: Escape (in vi-mode)
- `Ctrl+Space`: Complete suggestion

## Aliases

### Navigation
- `..`, `...`, `....`, `.....`: Go up 1-4 directories
- `~`: Go to home directory
- `cdprev`: Go to previous directory

### Git
- `g`: git
- `gs`: git status
- `ga`: git add
- `gc`: git commit
- `gp`: git push
- `gl`: git pull
- (see `.zshrc` for full list)

### Docker
- `d`: docker
- `dc`: docker-compose
- `dps`: docker ps
- `di`: docker images

### Python
- `py`: python3
- `pip`: pip3
- `venv`: Create virtual environment
- `activate`: Activate virtual environment

### Node.js
- `ns`: npm start
- `nt`: npm test
- `ni`: npm install
- (see `.zshrc` for full list)

### Neovim
- `vim`, `vi`, `v`, `nv`: neovim
- `nvf`: Open file with neovim using fzf

## Functions

- `mkcd`: Create directory and cd into it
- `extract`: Extract various archive formats
- `search_and_edit`: Search for file and open in editor
- `nvt`: Open Neovim with Telescope file finder
- `nvg`: Open Neovim with Telescope grep
- `mkvenv`: Create and activate Python virtual environment
- `cdp`: Change to project directory using fzf
- `update_all`: Update all package managers
- `new_project`: Create new project directory with git init

## Common Workflows

### Python Development
1. Create new project: `new_project myproject`
2. Set up virtual environment: `mkvenv`
3. Install dependencies: `pip install <packages>`
4. Open project in Neovim: `nvt`

### Git Workflow
1. Check status: `gs`
2. Stage changes: `ga` or `gaa`
3. Commit changes: `gcm "Commit message"`
4. Pull latest changes: `gl`
5. Push changes: `gp`

### Docker Workflow
1. Build containers: `dcb`
2. Start services: `dcu`
3. View logs: `dcl`
4. Stop services: `dcd`

### Node.js Development
1. Initialize project: `npm init`
2. Install dependencies: `ni <packages>`
3. Start development server: `ns`
4. Run tests: `nt`

## Plugin Configurations

- Powerlevel10k: Fast and customizable Zsh theme
- zsh-autosuggestions: Suggests commands as you type
- zsh-syntax-highlighting: Syntax highlighting for Zsh
- fzf: Fuzzy finder for command-line
- z: Jump to frequently used directories

For more detailed information on specific features or workflows, refer to the comments in the `.zshrc` file.
