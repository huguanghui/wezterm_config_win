local wezterm = require('wezterm')
local platform = require('utils.platform')

local font = 'JetBrainsMonoNFM Nerd Font'
local font_size = platform().is_mac and 12 or 10

return {
   font = wezterm.font(font, { weight = 'Bold', italic = false }),
   font_size = font_size,

   -- 禁用缺失字形的警告
   warn_about_missing_glyphs = false,

   freetype_render_target = 'Normal',
   freetype_load_target = 'Normal',

   -- 行高和字母间距微调
   line_height = 1.05, -- 1.0 ~ 1.1 之间
   cell_width = 1.0, -- 1.0 ~ 1.05，防止字母太挤
}
