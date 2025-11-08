-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font = wezterm.font("MesloLGS Nerd Font Propo", {weight="Bold", stretch="Normal", style="Normal"})
config.font_size = 15


config.color_scheme_dirs = { '~/Documents/tools/iTerm2-Color-Schemes/wezterm' }
config.color_scheme = 'Guezwhoz'

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 0

config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.1,
}

config.keys = {
  {
    key = 'v',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitPane {
      direction = "Right",
      size = { Percent = 50 },
    }
  },
  {
    key = 'h',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitPane {
      direction = "Down",
      size = { Percent = 50 },
    }
  },
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection("Left")
  },
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection("Right")
  },
  {
    key = 'UpArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection("Up")
  },
  {
    key = 'DownArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection("Down")
  },
  {
    key = 'LeftArrow',
    mods = 'ALT|CMD',
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'RightArrow',
    mods = 'ALT|CMD',
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = wezterm.action.SendString("\x1bb")
  },
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = wezterm.action.SendString("\x1bf")
  },
  {
    key = "d",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SendString("tmux detach-client\n")
  },
}

-- my coolnight colorscheme:
--config.colors = {
--	foreground = "#CBE0F0",
--	background = "#011423",
--	cursor_bg = "#47FF9C",
--	cursor_border = "#47FF9C",
--	cursor_fg = "#011423",
--	selection_bg = "#033259",
--	selection_fg = "#CBE0F0",
--	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
--	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
--}

-- Finally, return the configuration to wezterm:
return config
