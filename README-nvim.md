# Neovim Configuration

This is a comprehensive Neovim configuration designed for efficient coding and text editing. It includes various plugins and custom keybindings to enhance productivity.

## Features

- Modern UI with Dracula theme and Airline status bar
- File navigation with NERDTree and FZF
- Git integration with Fugitive and GitGutter
- Code completion and linting with CoC (Conquer of Completion)
- Markdown preview
- Easy motion for quick navigation
- And much more!

## Prerequisites

- Neovim (0.5 or later recommended)
- Git
- Node.js (for CoC)
- Python 3 (for some plugins)
- A Nerd Font (for icons)

## Installation

1. Backup your existing Neovim configuration if you have one:

``````
mv ~/.config/nvim ~/.config/nvim.backup

``````
2. Clone this repository:

3. Install vim-plug (the plugin manager):

``````
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

``````
4. Open Neovim and run :PlugInstall to install the plugins.

5. Install CoC extensions:
``````
:CocInstall coc-json coc-tsserver coc-html coc-css coc-python
``````
## Key Mappings

Here are some of the most important key mappings:

``````
- <Space> is the leader key
- <C-n> Toggle NERDTree
- <leader>ff Search files with FZF
- <leader>/ Comment/uncomment lines
- gd Go to definition (CoC)
- gr Find references (CoC)
- <leader>rn Rename symbol (CoC)
- <C-j/k/h/l> Navigate between splits
- <leader>vs Create vertical split
- <leader>ns Create horizontal split
``````
For a full list of mappings, please refer to the init.vim file.

## Troubleshooting

If you encounter any issues:

1. Make sure all prerequisites are installed
2. Run :checkhealth in Neovim for diagnostics
3. Ensure all plugins are up to date with :PlugUpdate
4. Check the Neovim and plugin documentation for any recent changes

