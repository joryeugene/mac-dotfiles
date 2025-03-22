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
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
      { "<leader>o", "<cmd>Telescope buffers<CR>", desc = "Quick open buffers" },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
    end,
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
    cmd = "ToggleTerm",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Terminal in tab" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Floating terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Vertical terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-.>", "<C-\\><C-n><cmd>ToggleTerm<CR>", { noremap = true, silent = true })
      end,
      shade_terminals = false,
      direction = 'float',
      float_opts = {
        border = "curved",
      },
    },
  },

  -- AI assistance
  { "github/copilot.vim", event = "InsertEnter" },

  -- Augment Code AI
  { "augmentcode/augment.vim" },

  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<C-e>", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
    },
    config = function()
      -- Disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("neo-tree").setup({
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = true,
          use_libuv_file_watcher = true,
        },
        window = {
          width = 30,
          mappings = {
            ["<C-e>"] = "close_window",
          }
        },
      })
    end,
  },
}

-- Additional settings for regular Neovim
local function setup_options()
  -- Augment Code Configuration with dynamic workspace folders
  local function get_workspace_folders()
    -- Start with some default folders
    local folders = {}

    -- Add the current working directory
    table.insert(folders, vim.fn.getcwd())

    -- Try to detect git root of current directory
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
    if git_root and git_root ~= "" and not vim.tbl_contains(folders, git_root) then
      table.insert(folders, git_root)
    end

    -- Add common project directories if they exist
    local common_project_dirs = {
      vim.fn.expand("~/Documents/GitHub/monohelix/projects"),
      vim.fn.expand("~/Documents/GitHub/monohelix/projects"),
      vim.fn.expand("~/Documents/working_docs"),
      vim.fn.expand("~/dotfiles"),
      vim.fn.expand("~/.config/nvim") -- Include Neovim config as a workspace
    }

    for _, dir in ipairs(common_project_dirs) do
      if vim.fn.isdirectory(dir) == 1 and not vim.tbl_contains(folders, dir) then
        table.insert(folders, dir)
      end
    end

    return folders
  end

  vim.g.augment_workspace_folders = get_workspace_folders()

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
  local opts = { noremap = true, silent = true, desc = "" }

  local function test_keymap(mode, lhs, rhs)
    if type(mode) == 'string' then
      keymap(mode, lhs, rhs, opts)
    else
      keymap('n', mode, lhs, opts)
    end
  end

  -- VSCode style mappings
  -- Terminal toggles (ensure ToggleTerm is loaded)
  test_keymap('n', '<C-[>', ':bprevious<CR>')
  test_keymap('n', '<C-]>', ':bnext<CR>')
  test_keymap('n', 'H', ':bprevious<CR>')  -- Alternative buffer navigation
  test_keymap('n', 'L', ':bnext<CR>')

  -- Explorer and sidebar
  test_keymap('n', '<C-e>', ':Neotree toggle<CR>')
  test_keymap('n', '<leader>e', ':Neotree toggle<CR>')

  -- Quick commands
  test_keymap('n', '<C-p>', '<cmd>Telescope commands<CR>')

  -- File operations
  test_keymap('n', '<leader>w', ':w<CR>')
  test_keymap('n', '<leader>q', ':q<CR>')
  test_keymap('n', '<leader>x', ':x<CR>')
  test_keymap('n', 'QQ', ':q!<CR>')
  test_keymap('n', 'WW', ':w!<CR>')

  -- Split management (not in core.lua)
  test_keymap('n', '<leader>sv', ':vsplit<CR>')
  test_keymap('n', '<leader>sh', ':split<CR>')

  -- Terminal splits
  test_keymap('n', '<C-\\>', ':ToggleTerm<CR>')
  test_keymap('t', '<C-\\>', '<C-\\><C-n>')  -- Terminal escape

  -- Window navigation
  test_keymap('n', '<C-h>', '<C-w>h')
  test_keymap('n', '<C-j>', '<C-w>j')
  test_keymap('n', '<C-k>', '<C-w>k')
  test_keymap('n', '<C-l>', '<C-w>l')

  -- Terminal window navigation
  test_keymap('t', '<C-h>', '<C-\\><C-n><C-w>h')
  test_keymap('t', '<C-j>', '<C-\\><C-n><C-w>j')
  test_keymap('t', '<C-k>', '<C-\\><C-n><C-w>k')
  test_keymap('t', '<C-l>', '<C-\\><C-n><C-w>l')

  -- Commentary
  test_keymap('n', '<leader>/', ':Commentary<CR>')
  test_keymap('v', '<leader>/', ':Commentary<CR>')

  -- LSP
  test_keymap('n', 'gD', vim.lsp.buf.declaration)
  test_keymap('n', 'gd', vim.lsp.buf.definition)
  test_keymap('n', 'K', vim.lsp.buf.hover)
  test_keymap('n', 'gi', vim.lsp.buf.implementation)
  test_keymap('n', 'gr', vim.lsp.buf.references)

  -- Augment Code
  test_keymap('n', '<leader>as', ':Augment signin<CR>')
  test_keymap('n', '<leader>ac', ':Augment chat<CR>')
  test_keymap('v', '<leader>ac', ':Augment chat<CR>')
  test_keymap('n', '<leader>an', ':Augment chat-new<CR>')
  test_keymap('n', '<leader>at', ':Augment chat-toggle<CR>')
  test_keymap('n', '<leader>aw', ':AugmentRefreshWorkspaces<CR>')

  -- Config management
  test_keymap('n', '<leader>l', ':Lazy<CR>')
  test_keymap('n', '<leader>yr', ':source $MYVIMRC<CR>')
  test_keymap('n', '<leader>yc', ':e $MYVIMRC<CR>')
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

  -- Add command to refresh Augment workspace folders
  vim.api.nvim_create_user_command("AugmentRefreshWorkspaces", function()
    -- Helper function to add folder if it exists and is unique
    local function add_if_exists(folders, path)
      local expanded_path = vim.fn.expand(path)
      if vim.fn.isdirectory(expanded_path) == 1 and not vim.tbl_contains(folders, expanded_path) then
        table.insert(folders, expanded_path)
      end
    end

    -- Build workspace folders list
    local folders = {}

    -- Add current working directory
    add_if_exists(folders, vim.fn.getcwd())

    -- Add git root if available
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
    if git_root and git_root ~= "" then
      add_if_exists(folders, git_root)
    end

    -- Common development directories
    local dev_dirs = {
      -- Personal projects and configurations
      -- "~/Documents/GitHub",
      -- "~/Projects",
      "~/dotfiles",
      -- "~/.config/nvim",

      -- Documentation and notes
      "~/Documents/working_docs",
      "~/Documents/calmhive",

      -- Specific project directories
      "~/Documents/GitHub/monohelix/",

      -- Configuration directories
      "~/.config",
    }

    -- Add all existing directories
    for _, dir in ipairs(dev_dirs) do
      add_if_exists(folders, dir)
    end

    -- Search for additional git repositories in home directory (limited depth to avoid performance issues)
    local git_repos = vim.fn.systemlist("find ~ -maxdepth 3 -name .git -type d -prune 2>/dev/null")
    for _, repo in ipairs(git_repos) do
      local repo_root = vim.fn.fnamemodify(repo, ':h')
      add_if_exists(folders, repo_root)
    end

    -- Update Augment workspace folders
    vim.g.augment_workspace_folders = folders

    -- Print each folder on a new line
    print("Augment workspace folders refreshed! Current folders:")
    for _, folder in ipairs(vim.g.augment_workspace_folders) do
      print("  - " .. folder)
    end

    -- Also print to messages to ensure visibility
    vim.api.nvim_echo({{"\nWorkspace folders have been refreshed. Use :messages to see the full list.", "Normal"}}, true, {})
  end, {})

  -- Automatically refresh workspace folders when changing directories
  vim.api.nvim_create_autocmd({"DirChanged"}, {
    callback = function()
      -- Use the same function as the command to avoid duplication
      vim.cmd("AugmentRefreshWorkspaces")
    end,
  })
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
