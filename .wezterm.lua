local wezterm = require 'wezterm'

return {
  color_scheme = 'Catppuccin Mocha',
  enable_tab_bar = false,
  font_size = 16.0,

  -- Use the custom Nerd Font
  font = wezterm.font('BerkeleyMonoVariable Nerd Font Mono', {
    weight = 'Regular',  -- 'Regular' or 'Italic' depending on your preference
  }),

  macos_window_background_blur = 30,
  window_background_opacity = 1.0,
  window_decorations = 'RESIZE',

  -- Mouse bindings
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
    -- Right-click to copy the selection to the clipboard
    {
      event = { Up = { streak = 1, button = 'Right' } },
      mods = 'NONE',
      action = wezterm.action.CopyTo 'Clipboard',
    },
  },
	mouse_bindings = {
	  -- Ctrl-click will open the link under the mouse cursor
	  {
	    event = { Up = { streak = 1, button = 'Left' } },
	    mods = 'CTRL',
	    action = wezterm.action.OpenLinkAtMouseCursor,
	  },
	},

	-- Set default split direction
	default_cwd = wezterm.home_dir,
	default_prog = { 'zsh' },
	split_horizontal = { domain = 'CurrentPaneDomain' },
	split_vertical = { domain = 'CurrentPaneDomain' },
}
