-- Claude Code Neovim plugin integration
-- A seamless integration between Claude Code AI assistant and Neovim

local M = {}

-- Plugin specification for lazy.nvim
M.spec = {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    -- Create command to toggle Claude Code
    vim.api.nvim_create_user_command("ClaudeCode", function()
      require("claude-code").toggle()
    end, {})

    -- Set up terminal job exit handling
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "term://*claude*",
      callback = function()
        -- Close the terminal buffer when claude process ends
        vim.cmd("bd!")
      end
    })

    -- Define a function to create buffer-local keymaps when Claude terminal is created
    local function setup_terminal_keymaps()
      -- Define a buffer-local keymap for the terminal
      local opts = { noremap = true, silent = true, buffer = 0 }
      -- Map Escape key to get out of terminal mode
      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
      -- Map Ctrl+Space to toggle the terminal
      vim.keymap.set('t', '<C-Space>', [[<C-\><C-n>:ClaudeCode<CR>]], opts)
      -- Add navigation keymaps while in terminal mode
      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    end

    -- Create autocmd for when entering Claude terminal
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*claude*",
      callback = function()
        setup_terminal_keymaps()
        -- Other terminal setup can go here
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"

        -- Auto-enter insert mode for terminal
        vim.cmd("startinsert")
      end
    })

    require("claude-code").setup({
      -- Terminal window settings
      window = {
        height_ratio = 0.4,     -- Percentage of screen height for the terminal window
        position = "botright",  -- Position of the window: "botright", "topleft", etc.
        enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
        hide_numbers = true,    -- Hide line numbers in the terminal window
        hide_signcolumn = true, -- Hide the sign column in the terminal window
      },
      -- File refresh settings
      refresh = {
        enable = true,           -- Enable file change detection
        updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
        timer_interval = 1000,   -- How often to check for file changes (milliseconds)
        show_notifications = true, -- Show notification when files are reloaded
      },
      -- Git project settings
      git = {
        use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
      },
      -- Command settings
      command = "claude",        -- Command used to launch Claude Code
      -- Keymaps for normal mode only - terminal keymaps are handled by autocmd
      keymaps = {
        toggle = {
          normal = "<C-Space>",   -- Normal mode keymap for toggling Claude Code
          terminal = false,       -- Disable default terminal keymap - we handle it with autocmd
        },
        window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
        scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
      }
    })
  end,
  keys = {
    { "<C-Space>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code (Ctrl+Space)" },
  }
}

return M
