# Zsh Configuration

This README documents the custom configurations, aliases, and functions in the .zshrc file.

## Oh My Zsh Configuration

- Theme: Powerlevel10k
- Plugins: git, zsh-autosuggestions, zsh-syntax-highlighting, z, vi-mode, fzf, history-substring-search, colored-man-pages, docker, kubectl, pyenv, npm, command-not-found, web-search, extract

## Key Bindings

- Vi mode enabled
- `ctrl-e`: Edit command line in vim
- `^[[A` / `^[[B`: Up/down in history search
- `vicmd 'k'` / `vicmd 'j'`: Up/down in history search (vi mode)

## Aliases

### System and Navigation

- `zshconfig`: Edit .zshrc
- `ohmyzsh`: Edit Oh My Zsh configuration
- `nvimconfig`: Edit Neovim configuration
- `sourcezsh`: Reload .zshrc
- `update`: Update Homebrew, npm, and Oh My Zsh
- `c`: Clear terminal
- `..`, `...`, `....`, `.....`: Navigate up directories
- `~`: Go to home directory
- `-`: Go to previous directory

### List Directory Contents

- `ls`, `ll`, `la`, `l`: Various options for listing directory contents

### Git

- `g`: git
- `ga`: git add
- `gaa`: git add --all
- `gs`: git status
- `gc`: git commit -v
- `gco`: git checkout
- `gb`: git branch
- `gd`: git diff
- `gf`: git fetch
- `gp`: git push
- `gl`: git pull
- `glog`: git log with graph

### Vim/Neovim

- `vim`, `vi`, `v`: Open Neovim

### Docker

- `d`: docker
- `dc`: docker-compose
- `dps`: docker ps
- `dimages`: docker images

### Python

- `py`: python3
- `pip`: pip3
- `venv`: Create virtual environment
- `activate`: Activate virtual environment

### Node.js

- `npms`: npm start
- `npmt`: npm test
- `npmr`: npm run
- `npmi`: npm install
- `npmu`: npm update

### Utility

- `dud`: Du with depth 1
- `duf`: Du summary
- `fd`: Find directories
- `ff`: Find files

## Custom Functions

- `mkcd`: Make directory and change into it
- `path`: Pretty print PATH
- `extract`: Extract various archive formats
- `backup`: Create a backup of a file
- `search_and_edit`: Search for a file and open it in the default editor

## Claude CLI Functions

- `claude_project`: Set context, index documents, and query Claude for project analysis
- `claude_clear_index`: Clear the indexed documents
- `claude_query`: Query Claude with context
- `claude_stream`: Start a streaming session with Claude
- `claude_save`: Save Claude's last response
- `claude_role`: Set a role for Claude

## Environment Variables

The configuration loads environment variables from a `.env` file in the home directory.

## Additional Configurations

- NVM (Node Version Manager) configuration
- Pyenv configuration
- FZF configuration
- Syntax highlighting settings
- Custom Oh My Zsh title

## Notes

- Ensure that all required tools (Oh My Zsh, Powerlevel10k, etc.) are installed.
- Some configurations may need to be adjusted based on your specific setup and preferences.
