-- Init.lua: Calmhive's Comprehensive Neovim Configuration
--
-- Note: Remember to run :Mason to install language servers
-- and external tools: npm i -g prettier eslint, pip install black flake8

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

-- Leader key
vim.g.mapleader = " "

-- Plugin configuration
require("lazy").setup({
  -- Theme options
  { "Mofiqul/dracula.nvim" },
  { "folke/tokyonight.nvim" },
  { "tanvirtin/monokai.nvim" },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "html", "css", "markdown", "yaml", "json", "dockerfile" },
        highlight = { enable = true },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Linting and formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Commentary plugin
  { "tpope/vim-commentary" },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Status line
{
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
},

  -- Which-key for keybinding help
  { "folke/which-key.nvim" },

  -- Git integration
  { "lewis6991/gitsigns.nvim" },

  -- Terminal management
  { "akinsho/toggleterm.nvim", version = "*" },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Tailwind CSS support
  { "williamboman/mason.nvim" },

  -- Database plugins
  {
    'tpope/vim-dadbod',
    dependencies = {
      'kristijanhusak/vim-dadbod-ui',
      'kristijanhusak/vim-dadbod-completion',
    },
    opts = {
      db_completion = function()
        require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      end,
    },
    config = function(_, opts)
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
      vim.g.db_ui_use_nerd_fonts = 1

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"sql", "mysql", "plsql"},
        callback = function()
          vim.schedule(opts.db_completion)
        end,
      })

      -- Set up database connections
      vim.g.dbs = {
        { name = 'localhost', url = 'postgresql:///workhelix' }, -- Uses the `localhost` entry from pgpass
      }

      -- Use .pgpass file for authentication
      vim.g.db_ui_use_pgpass = 1
    end,
    cmd = {
      'DB',
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
    },
  },
})

-- General settings
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.showmode = false

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
  -- eol = "¶",
  precedes = "«",
  extends = "»"
}

-- Color scheme
vim.cmd[[colorscheme monokai]] -- _pro

-- Key mappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Buffer navigation
keymap("n", "H", ":bprevious<CR>", opts)
keymap("n", "L", ":bnext<CR>", opts)

-- Move selected lines up/down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Redo
keymap("n", "U", "<C-R>", opts)

-- Quick edit and reload of init.lua
keymap("n", "<leader>ve", ":e ~/.config/nvim/init.lua<CR>", opts)
keymap("n", "<leader>vr", ":source ~/.config/nvim/init.lua<CR>", opts)

-- Replace entire buffer with system clipboard contents
keymap("n", "<leader>sp", "ggVG\"+p", opts)

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
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- Folding
keymap("n", "<leader>fo", ":foldopen<CR>", opts)
keymap("n", "<leader>fc", ":foldclose<CR>", opts)
keymap("n", "<leader>fu", ":foldopen!<CR>", opts)
keymap("n", "<leader>fa", ":foldclose!<CR>", opts)

-- Commentary
keymap("n", "<leader>/", ":Commentary<CR>", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":noh<CR>", opts)

-- Toggle options
keymap("n", "<leader>z", ":ZenMode<CR>", opts)
keymap("n", "<leader>\\", ":set wrap!<CR>", opts)

-- Additional useful mappings
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bn", ":enew<CR>", opts)
keymap("n", "<leader>o", ":only<CR>", opts)

-- Markdown preview
keymap("n", "<leader>mp", ":MarkdownPreview<CR>", opts)

-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- NvimTree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {})

-- Toggleterm
vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', {})

-- LSP keybindings
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- LSP setup
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "pyright",
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "dockerls",
    "marksman",
  },
  automatic_installation = true,
})

-- Configure LSP servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = { "pyright", "tsserver", "html", "cssls", "tailwindcss", "dockerls", "marksman" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Autocompletion setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
})

-- Linting and formatting setup
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.flake8,
  },
})

-- Additional plugin configurations
require('gitsigns').setup()
require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
}
require('nvim-tree').setup()
require('telescope').setup()
require('which-key').setup()
require('toggleterm').setup()

-- Markdown preview setup
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1

-- Autocommands
vim.cmd[[
  augroup custom_filetypes
    autocmd!
    autocmd FileType lua,yaml,json setlocal tabstop=2 shiftwidth=2
    autocmd FileType python,javascript,typescript,html,css setlocal tabstop=4 shiftwidth=4
    autocmd FileType markdown setlocal wrap linebreak
  augroup END

  augroup trim_whitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END
]]

-- Font settings
vim.opt.guifont = "Berkeley Mono:h14"
vim.opt.linespace = 0
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.termguicolors = true


