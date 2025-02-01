-- VSCode-specific Neovim configuration
local M = {}

-- VSCode-specific plugins
local plugins = {
  -- Commentary plugin (essential for commenting)
  { "tpope/vim-commentary" },

  -- Surround plugin (essential for text objects)
  { "tpope/vim-surround" },

  -- Repeat plugin (for better . command support)
  { "tpope/vim-repeat" },
}

-- VSCode-specific keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Commenting (uses vim-commentary)
keymap('n', 'gcc', ':Commentary<CR>', opts)
keymap('v', 'gc', ':Commentary<CR>', opts)

-- Diagnostics
keymap('n', '[d', "<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>", opts)
keymap('n', ']d', "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>", opts)

return { plugins = plugins }
