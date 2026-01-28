local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')
local colors = require('colors.custom')

return {
  front_end = 'WebGpu',
  webgpu_preferred_adapter = gpu_adapters:pick_best(),
  webgpu_power_preference = 'HighPerformance',

  animation_fps = 60,
  cursor_blink_rate = 0,

  -- color scheme
  colors = colors,

  -- background
  background = {
    {
      source = { File = wezterm.GLOBAL.background },
      horizontal_align = 'Center',
    },
    {
      source = { Color = colors.background },
      height = '100%',
      width = '100%',
      opacity = 0.85,
      vertical_align = 'Bottom',
      h_bilinear = true,
    },
  },

  -- scrollbar
  enable_scroll_bar = true,

  -- tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = true,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = true,
  switch_to_last_active_tab_when_closing_tab = true,

  -- window
  window_padding = {
    left = 5,
    right = 10,
    top = 12,
    bottom = 7,
  },
  window_close_confirmation = 'NeverPrompt',
  -- window_decorations = 'RESIZE',
  window_frame = {
    active_titlebar_bg = '#099090',
  },
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.65,
  },
}
