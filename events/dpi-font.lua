local wezterm = require('wezterm')

local M = {}

M.setup = function()
   wezterm.on('window-config-reloaded', function(window, _)
      local overrides = window:get_config_overrides() or {}

      local dims = window:get_dimensions()
      local dpi = dims.dpi or 96

      local font_size = 10.0
      if dpi >= 192 then
         font_size = 10.0
      elseif dpi >= 144 then
      elseif dpi >= 120 then
         font_size = 12.5
         font_size = 12.5
      else
         font_size = 14
      end

      overrides.font_size = font_size
      window:set_config_overrides(overrides)
   end)
end

return M
