local wezterm = require('wezterm')
local platform = require('utils.platform')

local font = 'JetBrainsMonoNerdFontCo NF'
local font_size = platform().is_mac and 12 or 12

return {
  font = wezterm.font(font, { weight = 'Bold', italic = true }),
  font_size = font_size,

  freetype_load_target = 'Normal',
  freetype_render_target = 'Normal',
}
