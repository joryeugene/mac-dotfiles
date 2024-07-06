# Neovim Configuration

This is a comprehensive Neovim configuration designed for efficient coding and text editing, particularly tailored for full-stack web development. It includes various plugins and custom keybindings to enhance productivity.

## Features

- Modern UI with Dracula theme and Airline status bar
- File navigation with NERDTree and Telescope
- Git integration with Fugitive and GitGutter
- Code completion and linting with CoC (Conquer of Completion)
- Markdown preview and editing enhancements
- Easy motion for quick navigation
- REPL integration with Iron.nvim
- Terminal integration
- Text object manipulation with Surround
- And much more!

## Prerequisites

- Neovim (0.5 or later recommended)
- Git
- Node.js (for CoC and some Markdown plugins)
- Python 3 (for some plugins)
- A Nerd Font (for icons)
- Ripgrep (for Telescope live grep)
- fd (optional but recommended for Telescope)

### Installing Prerequisites on macOS

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Neovim**:
   ```bash
   brew install neovim
   ```

3. **Install other dependencies**:
   ```bash
   brew install git node python3 ripgrep fd
   ```

4. **Install a Nerd Font**:
   ```bash
   brew tap homebrew/cask-fonts
   brew install --cask font-hack-nerd-font
   ```

## Installation

1. **Backup your existing Neovim configuration** (if you have one):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:

3. **Install vim-plug** (the plugin manager):
   ```bash
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```

4. **Open Neovim and run `:PlugInstall` to install the plugins**.

5. **Install CoC extensions**:
   ```bash
   :CocInstall coc-json coc-tsserver coc-html coc-css coc-python
   ```

## Key Mappings

Here are some of the most important key mappings:

- `<Space>` is the leader key
- `<C-n>` Toggle NERDTree
- `<leader>ff` Search files with Telescope
- `<leader>fg` Live grep with Telescope
- `<leader>/` Comment/uncomment lines
- `gd` Go to definition (CoC)
- `gr` Find references (CoC)
- `<leader>rn` Rename symbol (CoC)
- `<C-j/k/h/l>` Navigate between splits
- `<leader>vs` Create vertical split
- `<leader>ns` Create horizontal split
- `<leader>w` EasyMotion word motion
- `<leader>f{char}` EasyMotion find character
- `<leader>sl` Send line to REPL (Iron.nvim)
- `<leader>sc` Send selection to REPL (Iron.nvim)

For a full list of mappings and commands, please refer to the `nvim-commands.md` file.

## Workflow Examples

### Backend Development (Python, FastAPI, SQLModel)

1. Open NERDTree: `<C-n>`
2. Navigate to backend directory: `j`, `k`
3. Open main FastAPI file: `o`
4. Edit code: `i` to insert, `<Esc>` to exit insert mode
5. Run server: `:terminal` and type `uvicorn main:app --reload`
6. Switch back to editor: `<C-\><C-n>`, `<C-w>h`
7. Navigate to test file: `<leader>ff`, type test file name, `<CR>`
8. Run tests: `:terminal` and type `pytest`

### Frontend Development (React or SvelteKit)

1. Open NERDTree: `<C-n>`
2. Navigate to frontend directory: `j`, `k`
3. Open main component file: `o`
4. Edit code: `i` to insert, `<Esc>` to exit insert mode
5. Run development server: `:terminal` and type `npm start`
6. Switch back to editor: `<C-\><C-n>`, `<C-w>h`
7. Navigate to another component file: `<leader>ff`, type component file name, `<CR>`
8. Edit and save changes: `i` to insert, `<Esc>` to exit insert mode, `:w`


## Customization

You can customize this configuration by editing the `init.vim` file. Feel free to add or remove plugins, change keybindings, or modify settings to suit your preferences.

## Troubleshooting

If you encounter any issues:

1. Make sure all prerequisites are installed
2. Run `:checkhealth` in Neovim for diagnostics
3. Ensure all plugins are up to date with `:PlugUpdate`
4. Check the Neovim and plugin documentation for any recent changes
