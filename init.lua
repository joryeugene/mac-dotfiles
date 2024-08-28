-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = " "

-- Plugin configuration
require("lazy").setup({
  -- Color scheme
  { "Mofiqul/dracula.nvim" },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "python" },
        highlight = { enable = true },
      })
    end,
  },

  -- Commentary plugin
  { "tpope/vim-commentary" },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup{}
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup{}
    end,
  },

  -- Which-key for keybinding help
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup{}
    end,
  },
})

-- General settings
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.showmode = true
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 500
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.colorcolumn = "88,120"
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  space = "·",
  nbsp = "␣",
  trail = "•",
  eol = "¶",
  precedes = "«",
  extends = "»"
}

-- Color scheme
vim.cmd[[colorscheme dracula]]

-- Key mappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to beginning/end of line
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- Move selected lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Redo
keymap("n", "U", "<C-R>", opts)

-- Quick edit and reload of init.lua
keymap("n", "<leader>ve", ":e ~/.config/nvim/init.lua<CR>", opts)
keymap("n", "<leader>vr", ":source ~/.config/nvim/init.lua<CR>", opts)

-- Better escape
keymap("i", "jk", "<Esc>", opts)

-- Replace entire buffer with system clipboard contents
keymap("n", "<leader>sp", "ggVG\"+p", opts)

-- Tabs and buffers
keymap("n", "<leader>]", ":bnext<CR>", opts)
keymap("n", "<leader>[", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Windows and splits
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>sc", ":close<CR>", opts)

-- Move between splits
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Save and quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- Folding
keymap("n", "<leader>fc", ":fold<CR>", opts)
keymap("n", "<leader>fo", ":foldopen<CR>", opts)
keymap("n", "<leader>fC", ":foldclose<CR>", opts)
keymap("n", "<leader>fO", ":foldopen!<CR>", opts)
keymap("n", "<leader>fa", ":foldclose!<CR>", opts)

-- Marks
keymap("n", "<leader>m", ":mark ", opts)
keymap("n", "<leader>'", ":marks<CR>", opts)

-- Quick window switching
keymap("n", "<leader>w", "<C-w>w", opts)

-- Commentary (using vim-commentary plugin)
keymap("n", "<leader>/", ":Commentary<CR>", opts)

-- Terminal
keymap("n", "<leader>t", ":terminal<CR>", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":noh<CR>", opts)

-- Reminder comments
-- zf - create fold
-- zo - open fold
-- zc - close fold
-- zR - open all folds
-- zM - close all folds
-- m{a-zA-Z} - set mark
-- '{a-zA-Z} - jump to mark
-- q{a-z} - record macro
-- @{a-z} - play macro
-- @@ - replay last macro
