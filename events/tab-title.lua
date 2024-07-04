local wezterm = require('wezterm')

local nf = wezterm.nerdfonts

local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick
local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick
local GLYPH_CIRCLE = nf.fa_circle
local GLYPH_ADMIN = nf.md_shield_half_full

local M = {}

local __cells__ = {}

local colors = {
  default = { bg = '#45475a', fg = '#1c1b19' },
  is_active = { bg = '#7FB4CA', fg = '#11111b' },
  hover = { bg = '#587d8c', fg = '#1c1b19' },
}

local _set_process_name = function(s)
  local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
  return a:gsub('%.exe$', '')
end

M.setup = function()

end

return M
