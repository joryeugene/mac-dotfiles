-- Init.lua: Calmhive's Comprehensive Neovim Configuration
--
-- Note: Remember to run :Mason to install language servers
-- and external tools: npm i -g prettier eslint, pip install black flake8
--
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
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
    end,
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

  -- Twilight for focusing on current paragraph
  { "folke/twilight.nvim", config = function() require("twilight").setup {} end },

  -- Transparent for toggling background transparency
  { "xiyaowong/nvim-transparent", config = function() require("transparent").setup {} end },

  -- Noice for enhancing Neovim UI
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        views = {
          notify = {
            backend = "notify",
            fallback = "mini",
            timeout = 3000,
            level = vim.log.levels.INFO,
            format = "notify",
          },
        },
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
      })
    end,
  },

  -- Terminal management
  { "akinsho/toggleterm.nvim", version = "*" },

  -- ZenMode for distraction-free writing
  { "folke/zen-mode.nvim", config = function() require("zen-mode").setup {} end },

-- AI tool
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      -- add any opts here
    },
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end, desc = "avante: ask", mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
      { "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit", mode = "v" },
    },
    config = function()
      require("avante").setup({
        modifiable = true,
        buffer_options = {
          modifiable = true,
        },
        on_buffer_create = function(bufnr)
          vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
          vim.api.nvim_buf_set_option(bufnr, 'buftype', '')
        end,
        -- Other configuration options...
      })
    end,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to setup it properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- AI tools
  {
    'github/copilot.vim',
    event = "InsertEnter",
  },
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
vim.opt.colorcolumn = { "88", "120" }
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
-- vim.cmd[[colorscheme tokyonight]]

-- Key mappings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navigation
keymap("n", "H", ":bprevious<CR>", opts)
keymap("n", "L", ":bnext<CR>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Buffer operations
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bn", ":enew<CR>", opts)
keymap("n", "<leader>bl", ":buffers<CR>", opts)
keymap("n", "<leader>bo", ":BufferOnly<CR>", opts)

-- Editing
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("n", "U", "<C-R>", opts)
keymap("n", "<leader>/", ":Commentary<CR>", opts)
keymap("v", "<leader>/", ":Commentary<CR>", opts)

-- File operations
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- Utility
keymap("n", "<leader>h", ":noh<CR>", opts)
keymap("n", "<leader>z", ":ZenMode<CR>", opts)
keymap("n", "<leader>\\", ":set wrap!<CR>", opts)

keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- Windows and splits
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>sc", ":close<CR>", opts)

-- Quick save and quit
keymap("n", "WW", ":w!<CR>", opts)
keymap("n", "QQ", ":q!<CR>", opts)

-- Easy navigation
keymap("n", "E", "$", opts)
keymap("n", "B", "^", opts)

-- Resize splits
keymap("n", "<C-W>,", ":vertical resize -10<CR>", opts)
keymap("n", "<C-W>.", ":vertical resize +10<CR>", opts)

-- Quick access
keymap("n", "<leader>j", ":e /Users/jory/Documents/calmhive/hub.md<CR>", opts)
keymap("n", "<leader>vr", ":source $MYVIMRC<CR>", opts) -- Refresh Neovim state
keymap("n", "<leader>vc", ":e $MYVIMRC<CR>", opts) -- Open init.lua for editing
keymap("n", "<leader>m", ":Mason<CR>", opts) -- Open Mason
keymap("n", "<leader>l", ":Lazy<CR>", opts) -- Open Lazy plugin manager
keymap("n", "<leader>o", ":Telescope buffers<CR>", opts) -- Open buffer list

-- NvimTree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Toggleterm setup and keybindings
require('toggleterm').setup({
})
-- Keybinding to open ToggleTerm
vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { noremap = true, silent = true })
-- Keybinding to close ToggleTerm from within the terminal
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true })


-- Twilight toggle
keymap('n', '<leader>tw', ':Twilight<CR>', opts)

-- Transparent toggle
keymap('n', '<leader>tr', ':TransparentToggle<CR>', opts)

keymap('n', '<leader>nd', ':Noice dismiss<CR>', opts)

-- Copilot toggle
keymap('n', '<leader>cp', ':Copilot disable<CR>', opts)

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
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '|', right = '|'},
    component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
}
require('nvim-tree').setup({
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
    highlight_git = true,
    highlight_opened_files = "all",
  },
  view = {
    width = 30,
    side = "left",
  },
})

-- Setup for nvim-web-devicons
require('nvim-web-devicons').setup({
  default = true,
  strict = true,
})

require('telescope').setup()
require('which-key').setup()

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
vim.opt.guifont = "Berkeley Mono:h14,Hack Nerd Font Mono:h14"
vim.opt.linespace = 0
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.termguicolors = true

-- Custom function to open markdown links
function _G.open_markdown_link()
    local line = vim.fn.getline('.')
    local link = line:match('%[.-%]%((.-)%)')
    if link then
        if vim.fn.has('mac') == 1 then
            vim.fn.system('open ' .. link)
        elseif vim.fn.has('unix') == 1 then
            vim.fn.system('xdg-open ' .. link)
        elseif vim.fn.has('win32') == 1 then
            vim.fn.system('start ' .. link)
        end
    else
        -- If no markdown link is found, use Neovim's built-in gx functionality
        vim.api.nvim_command('normal! gx')
    end
end

-- Map 'gx' to open markdown links
vim.api.nvim_set_keymap('n', 'gx', ':lua open_markdown_link()<CR>', {noremap = true, silent = true})

-- Placeholder for ChatGPT plugin
-- vim.keymap.set('n', '<leader>g', ':ChatGPT<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "avante",
    callback = function()
        vim.bo.modifiable = true
        vim.bo.buftype = ""
    end,
})

