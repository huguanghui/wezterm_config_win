local wezterm = require('wezterm')

local M = {}

M.setup = function()
   wezterm.on('window-config-reloaded', function(window, _)
      local overrides = window:get_config_overrides() or {}

      local dims = window:get_dimensions()
      local dpi = dims.dpi or 96

      local font_size = 10.0
      if dpi == 192 then
         font_size = 11.0
      elseif dpi > 192 then
         font_size = 10.0
      elseif dpi >= 120 then
         font_size = 11.0
      elseif dpi == 96 then
         font_size = 16.0
      else
         font_size = 14.0
      end

      -- 主字体大小
      overrides.font_size = font_size

      -- 窗口标签（Tab Bar）字体大小
      local frame = overrides.window_frame or {}
      overrides.window_frame = frame
      frame.font_size = font_size

      window:set_config_overrides(overrides)
   end)
end

return M
