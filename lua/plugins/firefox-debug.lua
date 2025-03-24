-- Firefox Debug Adapter
return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      local dap = require('dap')

      -- Try to determine the Firefox/Zen executable path
      local function get_firefox_path()
        -- Common paths for Firefox on macOS
        local potential_paths = {
          "/System/Volumes/Data/Applications/Zen Browser.app/Contents/MacOS/Zen Browser",
          "/System/Volumes/Data/Applications/Zen Browser.app/Contents/MacOS/firefox",
          "/Applications/Firefox.app/Contents/MacOS/firefox",
          "/Applications/Zen.app/Contents/MacOS/Firefox",
          "/Applications/Zen.app/Contents/MacOS/Zen",
          vim.fn.expand("~/Applications/Firefox.app/Contents/MacOS/firefox")
        }

        -- Check if any of these paths exist
        for _, path in ipairs(potential_paths) do
          if vim.fn.filereadable(path) == 1 then
            return path
          end
        end

        -- Default fallback to user's Zen Browser path
        return "/System/Volumes/Data/Applications/Zen Browser.app/Contents/MacOS/Zen Browser"
      end

      -- Firefox Debug Adapter
      dap.adapters.firefox = {
        type = 'executable',
        command = 'node',
        args = {vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'},
      }

      -- Make sure firefox adapter uses an available type
      if not dap.adapters.firefox and dap.adapters.node2 then
        dap.adapters.firefox = dap.adapters.node2
      end

      if not dap.adapters.firefox and dap.adapters["pwa-node"] then
        dap.adapters.firefox = dap.adapters["pwa-node"]
      end

      -- Use the same adapter for pwa-firefox
      dap.adapters["pwa-firefox"] = dap.adapters.firefox

      -- Add Firefox configurations to existing ones
      -- For JavaScript
      table.insert(dap.configurations.javascript or {}, {
        type = "firefox",
        request = "launch",
        name = "Debug with Firefox/Zen",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = "/System/Volumes/Data/Applications/Zen Browser.app/Contents/MacOS/Zen Browser",
        port = 9222,
        reAttach = true,
        sourceMaps = true,
        pathMappings = {
          {
            url = "webpack:///",
            path = "${workspaceFolder}/"
          }
        }
      })

      -- For TypeScript
      table.insert(dap.configurations.typescript or {}, {
        type = "firefox",
        request = "launch",
        name = "Debug TypeScript with Firefox/Zen",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = "/System/Volumes/Data/Applications/Zen Browser.app/Contents/MacOS/Zen Browser",
        port = 9222,
        sourceMaps = true,
        reAttach = true,
        pathMappings = {
          {
            url = "webpack:///",
            path = "${workspaceFolder}/"
          }
        }
      })

      -- For React files specifically
      dap.configurations.typescriptreact = dap.configurations.typescript
      dap.configurations.javascriptreact = dap.configurations.javascript

      print("Firefox/Zen debug adapter configured!")
    end
  }
}
