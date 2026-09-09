local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')
local colors = require('colors.campbell')
local backdrops = require('utils.backdrops')

return {
  front_end = 'WebGpu', -- WebGpu,OpenGL
  webgpu_preferred_adapter = gpu_adapters:pick_best(),
  webgpu_power_preference = 'HighPerformance',

  animation_fps = 30,
  cursor_blink_rate = 0,

  -- color scheme
  colors = colors,

  -- background: 壁纸层 + 半透明深色遮罩,定义复用 utils/backdrops.layers
  -- (backdrops 目录为空时 layers() 只返回纯色遮罩,不再引用 nil 文件)
  background = backdrops.layers(wezterm.GLOBAL.background),

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
  window_close_confirmation = 'AlwaysPrompt',
  -- window_decorations = 'RESIZE',
  window_frame = {
    active_titlebar_bg = '#0037DA',
    inactive_titlebar_bg = '#1A1F26',
  },
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.65,
  },
}
