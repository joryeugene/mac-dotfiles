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
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope commands<CR>", desc = "Commands" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
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
        }
      })

      -- Simple safe wrapper for document symbols
      local builtin = require('telescope.builtin')
      -- Override the fs keybinding to use a safe version of symbols
      vim.keymap.set('n', '<leader>fs', function()
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        local has_symbol_support = false

        for _, client in ipairs(clients) do
          if client.server_capabilities.documentSymbolProvider then
            has_symbol_support = true
            break
          end
        end

        if not has_symbol_support then
          vim.notify("LSP server does not support document symbols", vim.log.levels.WARN)
          return
        end

        pcall(builtin.lsp_document_symbols, {})
      end, { desc = "Document symbols (safe)" })
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

  -- Dashboard for better start screen
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local dashboard = require("alpha.themes.dashboard")

      -- Custom header
      dashboard.section.header.val = {
        "",
        "",
        "   ██████╗ █████╗ ██╗     ███╗   ███╗██╗  ██╗██╗██╗   ██╗███████╗",
        "  ██╔════╝██╔══██╗██║     ████╗ ████║██║  ██║██║██║   ██║██╔════╝",
        "  ██║     ███████║██║     ██╔████╔██║███████║██║██║   ██║█████╗  ",
        "  ██║     ██╔══██║██║     ██║╚██╔╝██║██╔══██║██║╚██╗ ██╔╝██╔══╝  ",
        "  ╚██████╗██║  ██║███████╗██║ ╚═╝ ██║██║  ██║██║ ╚████╔╝ ███████╗",
        "   ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝  ╚══════╝",
        "",
        "",
      }

      -- Menu items
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "  Find word", ":Telescope live_grep <CR>"),
        dashboard.button("n", "  New file", ":enew <CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/lua/config/nvim.lua <CR>"),
        dashboard.button("l", "  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- Footer
      dashboard.section.footer.val = function()
        local stats = require("lazy").stats()
        return "⚡ Neovim loaded " .. stats.count .. " plugins in " .. stats.startuptime .. "ms"
      end

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Keyword"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true

      require("alpha").setup(dashboard.opts)

      -- Auto start Alpha when no more buffers
      vim.api.nvim_create_autocmd("User", {
        pattern = "BDeletePost*",
        callback = function(event)
          local remaining_bufs = vim.tbl_filter(function(buf)
            return vim.api.nvim_buf_is_valid(buf)
                and vim.bo[buf].buflisted
                and vim.api.nvim_buf_get_name(buf) ~= ""
          end, vim.api.nvim_list_bufs())

          if #remaining_bufs == 0 then
            vim.cmd("Alpha")
          end
        end,
      })
    end,
  },

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
          },
          position = "left",
          auto_resize = false, -- Prevent auto-resizing
        },
        buffers = {
          follow_current_file = true,
        },
      })
    end,
  },
}

-- Additional settings for regular Neovim
local function setup_options()
  -- Augment Code Configuration with minimal workspace folders
  -- Just include the current directory by default
  vim.g.augment_workspace_folders = { vim.fn.getcwd() }

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
    ensure_installed = { "pyright", "ts_ls", "lua_ls" },
    automatic_installation = true,
  })

  local capabilities = cmp_nvim_lsp.default_capabilities()
  local servers = { "pyright", "ts_ls", "lua_ls" }

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

  -- Create a function to launch lazygit with proper terminal handling
  local function open_lazygit()
    local term = require("toggleterm.terminal").Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "curved",
      },
      on_open = function(term)
        -- Setup special keybindings for lazygit
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<C-\\><C-n>:lua _G.exit_lazygit()<CR>", {noremap = true, silent = true})
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<ESC>", "<ESC>", {noremap = true, silent = true}) -- Allow ESC to pass through
        vim.cmd("startinsert!")
      end,
    })
    _G.exit_lazygit = function()
      -- Send q key to lazygit then close the terminal
      vim.api.nvim_feedkeys("q", "t", false)
      vim.defer_fn(function() term:close() end, 100)
    end
    term:toggle()
  end

  -- Custom buffer close function that prevents Neo-tree from taking over
  local function smart_buffer_close()
    local buffers = vim.tbl_filter(function(buf)
      return vim.api.nvim_buf_is_valid(buf)
          and vim.bo[buf].buflisted
          and vim.api.nvim_buf_get_name(buf) ~= ""
          and vim.bo[buf].filetype ~= "neo-tree"
    end, vim.api.nvim_list_bufs())

    -- Get current buffer
    local current_buf = vim.api.nvim_get_current_buf()

    -- If there's only one buffer left or no other listed buffers
    if #buffers <= 1 then
      -- Create an empty buffer to switch to before closing
      vim.cmd("enew")
      vim.bo.buflisted = true
      vim.bo.bufhidden = ""

      -- Close the original buffer
      vim.cmd("bdelete " .. current_buf)
    else
      -- Find next buffer to switch to
      local next_buf = nil
      for i, buf in ipairs(buffers) do
        if buf == current_buf and i < #buffers then
          next_buf = buffers[i + 1]
          break
        elseif buf == current_buf then
          next_buf = buffers[i - 1]
          break
        end
      end

      -- Switch to next buffer and close current one
      if next_buf then
        vim.cmd("buffer " .. next_buf)
        vim.cmd("bdelete " .. current_buf)
      else
        vim.cmd("bdelete")
      end
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
  test_keymap('n', '<leader>e', function()
    local neotree_win = nil

    -- Find if Neo-tree window is already open
    for _, win in pairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match("neo%-tree filesystem") then
        neotree_win = win
        break
      end
    end

    if neotree_win then
      -- If Neo-tree is open, focus the window
      vim.api.nvim_set_current_win(neotree_win)
    else
      -- Otherwise, open Neo-tree
      vim.cmd("Neotree toggle")
    end
  end)

  -- Quick commands
  test_keymap('n', '<C-p>', '<cmd>Telescope commands<CR>')

  -- File operations
  test_keymap('n', '<leader>w', ':w<CR>')
  test_keymap('n', '<leader>q', function() smart_buffer_close() end)
  test_keymap('n', '<leader>x', function() vim.cmd('w') smart_buffer_close() end)
  test_keymap('n', 'QQ', ':qa!<CR>')  -- Close all buffers and windows at once
  test_keymap('n', 'WW', ':w!<CR>')
  test_keymap('n', '<leader>nf', ':enew<CR>') -- Create a new file buffer

  -- Split management (not in core.lua)
  test_keymap('n', '<leader>sv', ':vsplit<CR>')
  test_keymap('n', '<leader>sh', ':split<CR>')

  -- Terminal splits
  test_keymap('n', '<C-\\>', ':ToggleTerm<CR>')
  test_keymap('t', '<C-\\>', '<C-\\><C-n>')  -- Terminal escape
  test_keymap('n', '<leader>tg', function() open_lazygit() end)  -- Open lazygit in floating terminal

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
  test_keymap('n', '<leader>ax', ':AugmentClearWorkspaces<CR>')
  test_keymap('n', '<leader>ad', ':AugmentAddCurrentDir<CR>')

  -- Config management
  test_keymap('n', '<leader>l', ':Lazy<CR>')
  test_keymap('n', '<leader>yr', ':source $MYVIMRC<CR>')
  test_keymap('n', '<leader>yc', ':e $MYVIMRC<CR>')
  test_keymap('n', '<leader>yk', ':e ~/.config/nvim/lua/config/nvim.lua<CR>')  -- Quick access to nvim.lua for keymaps
  test_keymap('n', '<leader>h', ':Alpha<CR>')  -- Return to dashboard
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

  -- Terminal settings with Lua API instead of Vimscript
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function() vim.cmd("startinsert") end,
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    callback = function() vim.cmd("startinsert") end,
  })

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

    -- List of directories to explicitly include
    local include_dirs = {
      -- Documentation and notes
      "~/Documents/working_docs",
      "~/Documents/calmhive",

      -- Specific project directories
      "~/Documents/GitHub/monohelix/",
    }

    -- Add explicitly included directories
    for _, dir in ipairs(include_dirs) do
      add_if_exists(folders, dir)
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

  -- Add command to clear workspace folders
  vim.api.nvim_create_user_command("AugmentClearWorkspaces", function()
    -- Reset to just the current directory
    vim.g.augment_workspace_folders = { vim.fn.getcwd() }

    print("Augment workspace folders cleared! Now only using current directory:")
    print("  - " .. vim.fn.getcwd())

    vim.api.nvim_echo({{"\nWorkspace folders have been cleared. Now only using current directory.", "Normal"}}, true, {})
  end, {})

  -- Add command to add the current directory to workspace folders
  vim.api.nvim_create_user_command("AugmentAddCurrentDir", function()
    local cwd = vim.fn.getcwd()

    -- Check if directory is already in the list
    local found = false
    for _, folder in ipairs(vim.g.augment_workspace_folders or {}) do
      if folder == cwd then
        found = true
        break
      end
    end

    -- Add it if not found
    if not found then
      vim.g.augment_workspace_folders = vim.g.augment_workspace_folders or {}
      table.insert(vim.g.augment_workspace_folders, cwd)
      print("Added current directory to Augment workspace folders: " .. cwd)
    else
      print("Current directory already in workspace folders: " .. cwd)
    end
  end, {})

  -- Add command to delete buffer using our custom function
  vim.api.nvim_create_user_command("BDelete", function()
    smart_buffer_close()
  end, {})

  -- Create a command abbreviation for 'bd' to use our custom function
  vim.cmd([[cabbrev bd BDelete]])
  vim.cmd([[cabbrev BD BDelete]])
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
