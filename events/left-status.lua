local wezterm = require('wezterm')

local nf = wezterm.nerdfonts
local M = {}

local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick
local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick
local GLYPH_KEY_TABLE = nf.md_table_key
local GLYPH_KEY = nf.md_key

local colors = {
  glyph_semi_circle = { bg = 'rgba(0,0,0,0.4)', fg = '#fab387' },
  text = { bg = '#fab387', fg = '#1c1b19' },
}

local __cells__ = {}

local _push = function(text, fg, bg)
  table.insert(__cells__, { Foreground = { Color = fg } })
  table.insert(__cells__, { Background = { Color = bg } })
  table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
  table.insert(__cells__, { Text = text })
end

--- 渲染左侧状态栏(key table / leader 提示)
--- 由 `events.status` 在单个 `update-status` 回调中统一调用
---@param window table
---@return string
M.render = function(window)
  __cells__ = {}

  local name = window:active_key_table()
  if name then
    _push(GLYPH_SEMI_CIRCLE_LEFT, colors.glyph_semi_circle.fg, colors.glyph_semi_circle.bg)
    _push(GLYPH_KEY_TABLE, colors.text.fg, colors.text.bg)
    _push(' ' .. string.upper(name), colors.text.fg, colors.text.bg)
    _push(GLYPH_SEMI_CIRCLE_RIGHT, colors.glyph_semi_circle.fg, colors.glyph_semi_circle.bg)
  end

  if window:leader_is_active() then
    _push(GLYPH_SEMI_CIRCLE_LEFT, colors.glyph_semi_circle.fg, colors.glyph_semi_circle.bg)
    _push(GLYPH_KEY, colors.text.fg, colors.text.bg)
    _push(' ', colors.text.fg, colors.text.bg)
    _push(GLYPH_SEMI_CIRCLE_RIGHT, colors.glyph_semi_circle.fg, colors.glyph_semi_circle.bg)
  end

  return wezterm.format(__cells__)
end

return M
