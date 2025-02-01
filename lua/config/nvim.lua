-- Full Neovim configuration (when not in VSCode)
local M = {}

-- Regular Neovim plugins
M.plugins = {
  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- Essential plugins
  { "tpope/vim-commentary" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "python", "javascript", "typescript", "html", "css", "markdown" },
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

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
    end
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
        },
      })
    end
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    config = function()
      require('which-key').setup()
    end
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
    },
    config = function()
      require("toggleterm").setup({
        size = 20,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  -- AI assistance
  { "github/copilot.vim", event = "InsertEnter" },
}

-- Additional settings for regular Neovim
local function setup_options()
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.signcolumn = "yes"
  vim.opt.cursorline = true
  vim.opt.wrap = false
  vim.opt.colorcolumn = { "88", "120" }
  vim.opt.termguicolors = true
end

-- LSP setup
local function setup_lsp()
  local mason = require('mason')
  local mason_lspconfig = require('mason-lspconfig')
  local lspconfig = require('lspconfig')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')

  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = { "pyright", "tsserver", "lua_ls" },
    automatic_installation = true,
  })

  local capabilities = cmp_nvim_lsp.default_capabilities()
  local servers = { "pyright", "tsserver", "lua_ls" }

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
    })
  end
end

-- Completion setup
local function setup_completion()
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
      ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
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
end

-- Additional keymaps for regular Neovim
local function setup_keymaps()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- Terminal mappings
  keymap('t', '<C-\\>', '<C-\\><C-n>', opts)
  keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
  keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
  keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
  keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)

  -- Telescope
  keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
  keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
  keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)

  -- LSP
  keymap('n', 'gD', vim.lsp.buf.declaration, opts)
  keymap('n', 'gd', vim.lsp.buf.definition, opts)
  keymap('n', 'K', vim.lsp.buf.hover, opts)
  keymap('n', 'gi', vim.lsp.buf.implementation, opts)
  keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
  keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  keymap('n', 'gr', vim.lsp.buf.references, opts)
end

-- Initialize everything
local function setup_autocmds()
  vim.cmd([[
    augroup custom_filetypes
      autocmd!
      autocmd FileType lua,yaml,json setlocal tabstop=2 shiftwidth=2
      autocmd FileType python,javascript,typescript setlocal tabstop=4 shiftwidth=4
      autocmd FileType markdown setlocal wrap linebreak
    augroup END

    augroup trim_whitespace
      autocmd!
      autocmd BufWritePre * :%s/\s\+$//e
    augroup END
  ]])
end

-- Setup function that will be called after plugins are loaded
function M.setup()
  setup_options()
  setup_lsp()
  setup_completion()
  setup_keymaps()
  setup_autocmds()
end

return M
