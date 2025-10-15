local wezterm = require('wezterm')
local platform = require('utils.platform')

local font = 'JetBrainsMonoNFM Nerd Font'
local font_size = platform().is_mac and 12 or 10

return {
  font = wezterm.font(font, { weight = 'Bold', italic = false }),
  font_size = font_size,

  -- 禁用缺失字形的警告
  warn_about_missing_glyphs = false,

  freetype_load_target = 'Normal',
  freetype_render_target = 'Normal',
}
