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

  -- Claude Code AI
  require("plugins.claude-code").spec,

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

  -- Augment Code AI
  { "augmentcode/augment.vim" },

  -- Firefox Debug Adapter
  require("plugins.firefox-debug"),

  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",
      "microsoft/vscode-js-debug",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()

      -- Automatically open dap UI when debug starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Node.js / JavaScript / TypeScript setup
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "/opt/homebrew/bin/node",  -- Full path to Node.js
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapDebugServer.js",
            "${port}"
          },
        }
      }

      -- Chrome/Firefox setup
      dap.adapters.chrome = dap.adapters["pwa-node"]
      dap.adapters.firefox = {
        type = "executable",
        command = "/opt/homebrew/bin/node",  -- Full path to Node.js
        args = {
          require("mason-registry").get_package("firefox-debug-adapter"):get_install_path() .. "/dist/adapter.bundle.js"
        },
        options = {
          env = {
            RUST_BACKTRACE = "1",  -- More detailed error messages
            RUST_LOG = "debug"      -- Debug level logging
          }
        }
      }

      -- JavaScript/TypeScript configurations
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Node.js Program",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "chrome",
          request = "launch",
          name = "Launch Chrome",
          url = "http://localhost:5173",
          webRoot = "${workspaceFolder}",
          userDataDir = false,
          sourceMaps = true,
        },
        {
          type = "firefox",
          request = "attach",
          name = "Debug with Firefox/Zen",
          url = "http://localhost:5173",
          webRoot = "${workspaceFolder}",
          firefoxExecutable = "/Applications/Zen Browser.app/Contents/MacOS/zen",
          port = 9222,
          reAttach = true,
          timeout = 60000,  -- 60 second timeout
          pathMappings = {
            {
              url = "webpack:///",
              path = "${workspaceFolder}/"
            }
          },
          sourceMap = true,
          sourceMaps = true,
          host = "localhost",
          log = {
            fileName = "${workspaceFolder}/firefox-adapter.log",
            fileLevel = {
              default = "Debug"
            }
          }
        }
      }

      -- Copy JavaScript configurations to TypeScript
      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript

      -- Python setup
      require('dap-python').setup('python')

      -- Add configurations for Python Django and Flask
      table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = '${workspaceFolder}/manage.py',
        args = {'runserver', '--noreload'},
        console = 'integratedTerminal',
      })
    end,
    keys = {
      { "<leader>db", function() require('dap').toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require('dap').continue() end, desc = "Continue" },
      { "<leader>do", function() require('dap').step_over() end, desc = "Step over" },
      { "<leader>di", function() require('dap').step_into() end, desc = "Step into" },
      { "<leader>du", function() require('dapui').toggle() end, desc = "Toggle UI" },
      { "<leader>dr", function() require('dap').repl.open() end, desc = "Open REPL" },
      { "<leader>dl", function() require('dap').run_last() end, desc = "Run last" },
      { "<leader>dt", function() require('dap').terminate() end, desc = "Terminate" },
      { "<leader>dC", function()
        local has_telescope, telescope = pcall(require, "telescope")
        if has_telescope then
          telescope.load_extension("dap")
          telescope.extensions.dap.configurations{}
        else
          vim.ui.select(
            require('dap').configurations[vim.bo.filetype] or {},
            { prompt = "Select Configuration" },
            function(selected)
              if selected then require('dap').run(selected) end
            end
          )
        end
      end, desc = "Select debug configuration" },

      -- Web Debugging - Launch Zen Browser
      { "<leader>dwl", function()
        -- Use osascript for more reliable launching
        local cmd = string.format([[
          osascript -e 'tell application "Zen Browser" to quit' 2>/dev/null || true
          sleep 1
          open -n -a "/Applications/Zen Browser.app" --args --remote-debugging-port=9222 --no-first-run --no-default-browser-check "http://localhost:5173/login"
        ]])

        -- Run the command in a background process
        vim.fn.jobstart(cmd, {
          on_exit = function(_, code)
            if code == 0 then
              vim.notify(
                "Launched Zen Browser with debugging port at http://localhost:5173/login\n" ..
                "IMPORTANT: Wait for browser to fully load before connecting debugger.\n" ..
                "Then try:\n" ..
                "1. Firefox protocol: <leader>dwa\n" ..
                "2. Chrome protocol: <leader>dwc",
                vim.log.levels.INFO
              )
            else
              vim.notify("Failed to launch Zen Browser", vim.log.levels.ERROR)
            end
          end
        })
      end, desc = "Launch Zen Browser for debugging" },

      -- Web Debugging - Attach to Zen Browser (using Firefox protocol)
      { "<leader>dwa", function()
        -- Check if the port is actually open before attempting to attach
        local function is_port_open(port)
          local handle = io.popen("nc -z localhost " .. port .. " && echo success || echo failure")
          if not handle then return false end

          local result = handle:read("*a")
          handle:close()

          return result:match("success") ~= nil
        end

        if not is_port_open(9222) then
          vim.notify(
            "Debugging port 9222 is not open! Make sure:\n" ..
            "1. Zen Browser is running\n" ..
            "2. It was started with --remote-debugging-port=9222\n" ..
            "Run <leader>dwl to launch the browser properly",
            vim.log.levels.ERROR
          )
          return
        end

        -- Open the debug UI first
        require('dapui').open()

        -- Get all JavaScript configurations
        local configs = require('dap').configurations.javascript or {}

        -- Find the Firefox/Zen configuration
        local firefox_config = nil
        for _, config in ipairs(configs) do
          if config.name == "Debug with Firefox/Zen" then
            firefox_config = config
            break
          end
        end

        if firefox_config then
          -- Explicitly run the Firefox configuration
          vim.notify("Attaching to Zen Browser with Firefox protocol on port 9222...", vim.log.levels.INFO)
          require('dap').run(firefox_config)
        else
          vim.notify("Could not find Firefox/Zen debug configuration", vim.log.levels.ERROR)
        end
      end, desc = "Attach to browser using Firefox protocol" },

      -- Web Debugging - Attach to Zen Browser with Chrome protocol (alternative)
      { "<leader>dwc", function()
        -- Check if the port is actually open before attempting to attach
        local function is_port_open(port)
          local handle = io.popen("nc -z localhost " .. port .. " && echo success || echo failure")
          if not handle then return false end

          local result = handle:read("*a")
          handle:close()

          return result:match("success") ~= nil
        end

        if not is_port_open(9222) then
          vim.notify(
            "Debugging port 9222 is not open! Make sure:\n" ..
            "1. Zen Browser is running\n" ..
            "2. It was started with --remote-debugging-port=9222\n" ..
            "Run <leader>dwl to launch the browser properly",
            vim.log.levels.ERROR
          )
          return
        end

        -- Open the debug UI first
        require('dapui').open()

        -- Get Chrome configuration
        local chrome_config = {
          type = "chrome",
          request = "attach",
          name = "Attach to Chrome",
          host = "localhost",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true
        }

        -- Explicitly run Chrome configuration
        vim.notify("Attaching to browser with Chrome protocol...", vim.log.levels.INFO)
        require('dap').run(chrome_config)
      end, desc = "Attach to browser using Chrome protocol" },

      -- Web Debugging - Set a breakpoint with clear instructions
      { "<leader>dwb", function()
        -- Get the current buffer's file path and line number
        local current_file = vim.fn.expand("%:p")
        local line_nr = vim.api.nvim_win_get_cursor(0)[1]

        -- Toggle a breakpoint at the current line
        require('dap').toggle_breakpoint()

        -- Log to help with debugging
        vim.notify(string.format("Toggled breakpoint at %s:%d", current_file, line_nr), vim.log.levels.INFO)

        -- Check if we're in a JavaScript/TypeScript file
        local ft = vim.bo.filetype
        if ft == "javascript" or ft == "typescript" or ft == "javascriptreact" or ft == "typescriptreact" then
          vim.notify("Breakpoint set for web debugging. Make sure to:\n" ..
                      "1. Launch browser with <leader>dwl\n" ..
                      "2. Wait for browser to fully load\n" ..
                      "3. Try attaching with Firefox protocol: <leader>dwa\n" ..
                      "4. If that fails, try Chrome protocol: <leader>dwc",
                      vim.log.levels.INFO)
        end
      end, desc = "Set web breakpoint with instructions" },

      -- Add a key binding to run your specific project debug tasks
      { "<leader>dA", function()
        -- Create a terminal for the API
        vim.cmd("ToggleTerm direction=horizontal size=15")
        local term_id = vim.api.nvim_get_current_buf()
        vim.api.nvim_chan_send(vim.b[term_id].terminal, "cd " .. vim.fn.getcwd() .. " && make api\n")

        -- Create a split for the dashboard
        vim.cmd("vsplit")
        vim.cmd("ToggleTerm direction=vertical")
        local term_id2 = vim.api.nvim_get_current_buf()
        vim.api.nvim_chan_send(vim.b[term_id2].terminal, "cd " .. vim.fn.getcwd() .. " && make dashboard\n")

        -- Return to the main window
        vim.cmd("wincmd p")

        -- Let user know
        vim.notify("Started API and Dashboard services", vim.log.levels.INFO)
      end, desc = "Start API and Dashboard" },

      -- Web Debugging - Kill and restart Zen Browser
      { "<leader>dwr", function()
        -- Use osascript for more reliable restarting
        local cmd = string.format([[
          osascript -e 'tell application "Zen Browser" to quit' 2>/dev/null || true
          sleep 1
          open -n -a "/Applications/Zen Browser.app" --args --remote-debugging-port=9222 --no-first-run --no-default-browser-check "http://localhost:5173/login"
        ]])

        -- Run the command in a background process
        vim.fn.jobstart(cmd, {
          on_exit = function(_, code)
            if code == 0 then
              vim.notify(
                "Restarted Zen Browser with debugging port at http://localhost:5173/login\n" ..
                "IMPORTANT: Wait for browser to fully load before connecting debugger.\n" ..
                "Then use <leader>dwa to attach debugger.",
                vim.log.levels.INFO
              )
            else
              vim.notify("Failed to restart Zen Browser", vim.log.levels.ERROR)
            end
          end
        })
      end, desc = "Restart Zen Browser for debugging" },

      -- Web Debugging - Verify browser debugging is working
      { "<leader>dwv", function()
        -- Create a temporary script file
        local script_path = "/tmp/check_browser_debug.js"
        local script_content = [[
const http = require('http');

// Try to connect to the Chrome DevTools Protocol
http.get('http://localhost:9222/json/version', (res) => {
  let data = '';

  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    console.log('SUCCESS: Browser debugging port is open!');
    console.log('Response:');
    console.log(data);
    process.exit(0);
  });
}).on('error', (err) => {
  console.error('ERROR: Failed to connect to browser debugging port');
  console.error(err.message);
  process.exit(1);
});
]]

        -- Write script to file
        local file = io.open(script_path, "w")
        if file then
          file:write(script_content)
          file:close()
        else
          vim.notify("Failed to create debug test script", vim.log.levels.ERROR)
          return
        end

        -- Create terminal for test
        vim.cmd("ToggleTerm direction=float")
        local term_id = vim.api.nvim_get_current_buf()

        -- Run the test
        vim.api.nvim_chan_send(vim.b[term_id].terminal, "node " .. script_path .. "\n")

        -- Let the user know
        vim.notify("Running browser debug connection test...", vim.log.levels.INFO)
      end, desc = "Verify browser debug connection" },
    },
  },

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

  -- Setup Mason first
  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })

  -- Ensure debug adapters are installed
  local ensure_installed = {
    -- LSP servers are handled by mason-lspconfig
    -- Debug adapters
    "js-debug-adapter",
    "firefox-debug-adapter",
  }

  -- Install tools
  for _, tool in ipairs(ensure_installed) do
    local pkg = require("mason-registry").get_package(tool)
    if not pkg:is_installed() then
      pkg:install()
    end
  end

  -- Setup LSP
  mason_lspconfig.setup({
    ensure_installed = require('config.mason_list'),
    automatic_installation = true,
  })

  -- Enhanced capabilities for completion and snippets
  local capabilities = cmp_nvim_lsp.default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Common LSP on_attach function
  local on_attach = function(client, bufnr)
    -- Customize autocomplete and LSP behavior
    if client.name == "typescript-language-server" or client.name == "ts_ls" then
      -- Disable formatting from tsserver in favor of eslint
      client.server_capabilities.documentFormattingProvider = false
    end

    -- Enable inlay hints for supported servers
    if client.server_capabilities.inlayHintProvider then
      if vim.fn.has('nvim-0.10') == 1 then
        -- For Neovim 0.10+
        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
      else
        -- For older versions
        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
      end
    end
  end

  -- Server-specific configurations
  local servers = {
    pyright = {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          }
        }
      }
    },
    ts_ls = {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      }
    },
    eslint = {
      -- ESLint will be applied for JavaScript and TypeScript
      -- and validate various types of files like .jsx, .tsx, etc.
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
      },
      settings = {
        workingDirectory = { mode = "auto" },
        format = { enable = true },
      }
    },
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" } -- Recognize 'vim' global in Neovim config
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        }
      }
    },
    tailwindcss = {
      filetypes = {
        "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact"
      }
    }
  }

  -- Setup each server
  for server_name, server_settings in pairs(servers) do
    local config = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }

    -- Merge settings if provided
    if server_settings then
      for key, value in pairs(server_settings) do
        config[key] = value
      end
    end

    lspconfig[server_name].setup(config)
  end

  -- Setup the rest of the servers with default configuration
  local additional_servers = { "cssls", "html" }
  for _, lsp in ipairs(additional_servers) do
    lspconfig[lsp].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end

  -- Create format command
  vim.api.nvim_create_user_command("Format", function()
    vim.lsp.buf.format({ async = true })
  end, {})
end

-- Completion setup
local function setup_completion()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  -- Load friendly snippets if available
  pcall(require, "luasnip/loaders/from_vscode")

  -- Better handling of tab completion with snippets
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  -- Define completion icons
  local kind_icons = {
    Text = "",
    Method = "",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = function(entry, vim_item)
        -- Add icons
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or "", vim_item.kind)

        -- Set max width of abbr (item name)
        local abbr_max = 50
        if vim_item.abbr:len() > abbr_max then
          vim_item.abbr = vim_item.abbr:sub(1, abbr_max) .. "..."
        end

        -- Show source
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]

        return vim_item
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
        elseif has_words_before() then
          cmp.complete()
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
    sources = cmp.config.sources({
      { name = 'nvim_lsp', priority = 1000 },
      { name = 'luasnip', priority = 750 },
      { name = 'path', priority = 500 },
      { name = 'buffer', priority = 250, max_item_count = 5 },
    }),
    experimental = {
      ghost_text = true,  -- Show ghost text preview of completion
    },
  })

  -- Filetype-specific configurations
  cmp.setup.filetype('python', {
    sources = cmp.config.sources({
      { name = 'nvim_lsp', priority = 1000 },
      { name = 'luasnip', priority = 750 },
      { name = 'path', priority = 500 },
    }, {
      { name = 'buffer', priority = 250, max_item_count = 5 },
    })
  })

  cmp.setup.filetype({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }, {
    sources = cmp.config.sources({
      { name = 'nvim_lsp', priority = 1000 },
      { name = 'luasnip', priority = 750 },
      { name = 'path', priority = 500 },
    }, {
      { name = 'buffer', priority = 250, max_item_count = 5 },
    })
  })

  -- Set up enhanced cmdline completion
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up enhanced search completion
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
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

  -- Terminal toggles (ensure ToggleTerm is loaded)
  test_keymap('n', '<C-[>', ':bprevious<CR>')
  test_keymap('n', '<C-]>', ':bnext<CR>')
  test_keymap('n', 'H', ':bprevious<CR>')  -- Alternative buffer navigation
  test_keymap('n', 'L', ':bnext<CR>')

  -- Cursor AI integration
  test_keymap('n', '<leader>cc', ':!cursor %<CR>')  -- Open current file in Cursor
  test_keymap('n', '<leader>cd', ':!cursor .<CR>')  -- Open current directory in Cursor
  test_keymap('n', '<leader>cp', ':!cursor ' .. vim.fn.getcwd() .. '<CR>')  -- Open project root in Cursor
  test_keymap('n', '<leader>cs', function()  -- Open selected files in Cursor
    local visual_selection = vim.fn.getregion("v")
    if visual_selection and #visual_selection > 0 then
      local selection_content = table.concat(visual_selection, "\n")
      vim.cmd("!cursor " .. selection_content)
    end
  end)

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
  test_keymap('n', '<leader>sc', ':close<CR>')  -- Close the current split

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
