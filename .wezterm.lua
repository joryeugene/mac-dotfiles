local wezterm = require 'wezterm'
local act = wezterm.action

return {
  color_scheme = 'Catppuccin Mocha',
  enable_tab_bar = false,
  font_size = 16.0,

  -- Use the custom Nerd Font
  font = wezterm.font('BerkeleyMonoVariable Nerd Font Mono', {
    weight = 'Regular',
  }),

  macos_window_background_blur = 30,
  window_background_opacity = 1.0,
  window_decorations = 'RESIZE',

  -- Mouse bindings
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
    -- Right-click to copy the selection to the clipboard
    {
      event = { Up = { streak = 1, button = 'Right' } },
      mods = 'NONE',
      action = act.CopyTo 'Clipboard',
    },
  },
  -- Enable ligatures
  harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },

  -- Set cursor style
  default_cursor_style = 'SteadyBlock',

  -- Enable scrollback
  scrollback_lines = 10000,

  -- Set working directory to home
  default_cwd = wezterm.home_dir,

  -- Enable native macOS full screen
  native_macos_fullscreen_mode = true,

  -- Custom color overrides
  -- colors = {
  --   cursor_bg = '#ff9e64',
  --   cursor_border = '#ff9e64',
  --   selection_fg = 'black',
  --   selection_bg = '#fffacd',
  -- },
}
