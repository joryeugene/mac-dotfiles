-- VSCode Neovim Integration Configuration
local M = {}

-- Plugin configuration for VSCode
M.plugins = {
  { "tpope/vim-surround" },     -- Surround text objects
  { "tpope/vim-commentary" },   -- Comments
  { "tpope/vim-repeat" },       -- Better repeat with .
}

-- Basic settings that don't overlap with VSCode
vim.opt.clipboard = "unnamedplus"   -- Use system clipboard
vim.opt.ignorecase = true          -- Ignore case in search
vim.opt.smartcase = true           -- Smart case in search

-- Disable UI elements that VSCode handles
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.cursorline = false
vim.opt.signcolumn = "no"
vim.opt.foldenable = false

-- Only essential autocommands
vim.cmd[[
  augroup vscode_neovim
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e  " Trim trailing whitespace
  augroup END
]]

return M
