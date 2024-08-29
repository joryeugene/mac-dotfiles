# Essential CLI Tools Guide

This guide explains the essential CLI tools included in our dotfiles setup, their purposes, and common use cases.

## Version Control

### git
- Purpose: Distributed version control system
- Common uses: Managing code repositories, tracking changes, collaborating with others
- Key commands:
  - `git init`: Initialize a new repository
  - `git clone <url>`: Clone a repository
  - `git add .`: Stage all changes
  - `git commit -m "message"`: Commit staged changes
  - `git push`: Push commits to remote repository

## Text Editors

### neovim (nvim) / vim
- Purpose: Highly configurable text editor
- Common uses: Editing code, configuration files, and text documents
- Key commands:
  - `:w`: Save file
  - `:q`: Quit
  - `/search_term`: Search in file
  - `dd`: Delete line
  - `yy`: Copy line

## Terminal Multiplexer

### zellij
- Purpose: Terminal multiplexer (alternative to tmux)
- Common uses: Managing multiple terminal sessions, split panes, and windows
- Key commands:
  - `Ctrl+t`: Enter tab command mode
  - `Ctrl+t + n`: New pane
  - `Ctrl+t + x`: Close pane
  - `Ctrl+t + h/j/k/l`: Navigate panes

## File Search and Navigation

### fzf
- Purpose: Fuzzy finder for command-line
- Common uses: Quickly searching files, history, and more
- Key commands:
  - `Ctrl+r`: Search command history
  - `Ctrl+t`: Search files and directories

### ripgrep (rg)
- Purpose: Fast text search tool
- Common uses: Searching for text patterns in files
- Key command: `rg "search pattern" /path/to/search`

### fd
- Purpose: Simple, fast alternative to `find`
- Common uses: Locating files and directories
- Key command: `fd pattern /path/to/search`

### zoxide
- Purpose: Smarter cd command with learning capabilities
- Common uses: Quickly navigating to frequently used directories
- Key command: `z directory_name`

## Data Processing

### jq
- Purpose: Command-line JSON processor
- Common uses: Parsing and manipulating JSON data
- Key command: `cat data.json | jq '.key'`

## File and Directory Operations

### tree
- Purpose: Display directory structure
- Common uses: Visualizing file system hierarchy
- Key command: `tree /path/to/directory`

## Network Tools

### wget / curl
- Purpose: Download files and make HTTP requests
- Common uses: Downloading files, testing APIs
- Key commands:
  - `wget https://example.com/file.zip`
  - `curl https://api.example.com/data`

### httpie
- Purpose: User-friendly HTTP client
- Common uses: Testing and debugging HTTP APIs
- Key command: `http GET https://api.example.com/data`

### nmap
- Purpose: Network exploration and security auditing
- Common uses: Scanning networks, finding open ports
- Key command: `nmap example.com`

## System Monitoring

### htop
- Purpose: Interactive process viewer
- Common uses: Monitoring system resources and processes
- Key command: `htop`

## File Viewers

### bat
- Purpose: Cat clone with syntax highlighting
- Common uses: Viewing file contents with improved readability
- Key command: `bat file.txt`

### jless
- Purpose: Command-line JSON viewer
- Common uses: Viewing and navigating JSON data
- Key command: `jless data.json`

## Shell

### zsh
- Purpose: Extended Bourne Shell with many improvements
- Common uses: Interactive command line, scripting
- Key feature: Customizable with frameworks like Oh My Zsh

### starship
- Purpose: Customizable prompt for any shell
- Common uses: Enhancing terminal prompt with useful information
- Key feature: Automatically configured based on your environment

## Package Managers

### brew
- Purpose: Package manager for macOS
- Common uses: Installing and managing software packages
- Key commands:
  - `brew install package_name`
  - `brew update`
  - `brew upgrade`

### pipx
- Purpose: Install and run Python applications in isolated environments
- Common uses: Managing Python CLI tools
- Key command: `pipx install package_name`

### npm / yarn
- Purpose: Package managers for JavaScript
- Common uses: Managing dependencies for Node.js projects
- Key commands:
  - `npm install package_name`
  - `yarn add package_name`

## Programming Languages

### python3
- Purpose: General-purpose programming language
- Common uses: Web development, data analysis, automation
- Key command: `python3 script.py`

### node
- Purpose: JavaScript runtime
- Common uses: Running JavaScript outside the browser, server-side development
- Key command: `node script.js`

### rust / cargo
- Purpose: Systems programming language and its package manager
- Common uses: Building efficient and reliable software
- Key commands:
  - `cargo new project_name`
  - `cargo build`
  - `cargo run`

## Development Tools

### lazygit
- Purpose: Simple terminal UI for git commands
- Common uses: Streamlining git workflows
- Key command: `lazygit`

### lazydocker
- Purpose: Simple terminal UI for docker commands
- Common uses: Managing Docker containers and images
- Key command: `lazydocker`

### docker
- Purpose: Platform for developing, shipping, and running applications in containers
- Common uses: Creating isolated environments for applications
- Key commands:
  - `docker build -t image_name .`
  - `docker run image_name`

### kubectl
- Purpose: Command-line tool for Kubernetes
- Common uses: Managing Kubernetes clusters
- Key command: `kubectl get pods`

### helm
- Purpose: Package manager for Kubernetes
- Common uses: Defining, installing, and upgrading Kubernetes applications
- Key command: `helm install release_name chart_name`

### ansible
- Purpose: Automation tool for IT tasks
- Common uses: Configuration management, application deployment
- Key command: `ansible-playbook playbook.yml`

### awscli
- Purpose: Command-line interface for Amazon Web Services
- Common uses: Managing AWS resources
- Key command: `aws s3 ls`

### az
- Purpose: Command-line interface for Microsoft Azure
- Common uses: Managing Azure resources
- Key command: `az vm list`

### gh
- Purpose: GitHub's official command-line tool
- Common uses: Interacting with GitHub repositories from the terminal
- Key command: `gh repo create`

## Code Quality Tools

### shellcheck
- Purpose: Static analysis tool for shell scripts
- Common uses: Finding and fixing issues in shell scripts
- Key command: `shellcheck script.sh`

## File Transfer

### rsync
- Purpose: Fast, versatile file copying tool
- Common uses: Syncing files between systems, creating backups
- Key command: `rsync -avz source_dir/ destination_dir/`

## Media Processing

### ffmpeg
- Purpose: Multimedia framework for handling audio and video
- Common uses: Converting between media formats, editing audio/video
- Key command: `ffmpeg -i input.mp4 output.avi`

### imagemagick
- Purpose: Image manipulation tool
- Common uses: Resizing, converting, and editing images
- Key command: `convert input.jpg -resize 50% output.jpg`

## Document Conversion

### pandoc
- Purpose: Universal document converter
- Common uses: Converting between document formats (e.g., Markdown to PDF)
- Key command: `pandoc input.md -o output.pdf`

## Terminal Emulator

### iterm2
- Purpose: Feature-rich terminal emulator for macOS
- Common uses: Replaces default Terminal app with more features
- Key feature: Split panes, search, and autocomplete

## Database Clients

### pgcli
- Purpose: PostgreSQL client with auto-completion and syntax highlighting
- Common uses: Interacting with PostgreSQL databases
- Key command: `pgcli database_name`

### mycli
- Purpose: MySQL/MariaDB client with auto-completion and syntax highlighting
- Common uses: Interacting with MySQL/MariaDB databases
- Key command: `mycli database_name`

## Git Tools

### tig
- Purpose: Text-mode interface for Git
- Common uses: Browsing Git repositories and history
- Key command: `tig`

### delta
- Purpose: Syntax-highlighting pager for git, diff, and grep output
- Common uses: Enhancing readability of Git diffs
- Key feature: Automatically used when configured with Git

This guide covers the essential CLI tools included in our dotfiles setup. Each tool is designed to enhance your productivity and streamline your development workflow. Experiment with these tools to find which ones best suit your needs and working style.
