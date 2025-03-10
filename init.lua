-- Optimized Neovim Configuration
-- Detects and loads appropriate configuration based on environment

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key configuration (set this before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core settings that apply to both VSCode and regular Neovim
require('config.core')

-- Determine which plugins to load
local plugins
if vim.g.vscode then
  -- plugins = require('config.vscode').plugins
else
  local nvim_config = require('config.nvim')
  plugins = nvim_config.plugins
end

-- Initialize lazy.nvim with the appropriate plugins
require("lazy").setup(plugins, {
  defaults = {
    lazy = false,
  },
  install = {
    colorscheme = { "catppuccin" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Setup non-VSCode configurations immediately
if not vim.g.vscode then
  require('config.nvim').setup()

  -- Also set up an additional check after lazy is done
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      require('config.nvim').setup()
    end,
  })
end

