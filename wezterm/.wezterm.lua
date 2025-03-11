local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- if windows
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { "sh.exe" } -- open git-bash by default
end

config.font = wezterm.font('JetBrainsMonoNL Nerd Font')
config.font_size = 12.0
config.enable_tab_bar = true
config.enable_scroll_bar = false
config.check_for_updates = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.disable_default_key_bindings = true
config.leader = { key = "Space", mods = "CTRL|SHIFT" }
config.keys = {
  {
    key = "\\",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane({ confirm = false }),
  },
}

config.colors = {
  cursor_bg = "#d2d2d2"
}

return config
