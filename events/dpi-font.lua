local wezterm = require('wezterm')

local M = {}

M.setup = function()
   wezterm.on('window-config-reloaded', function(window, _)
      local overrides = window:get_config_overrides() or {}

      local dims = window:get_dimensions()
      local dpi = dims.dpi or 96
      -- wezterm.log_info('dpi-font: window-config-reloaded triggered', 'dpi=', dpi, 'dims=', dims)

      local font_size = 10.0
      if dpi >= 192 then
         font_size = 10.0
      elseif dpi >= 120 then
         font_size = 11.0
      else
         font_size = 14.0
      end

      -- wezterm.log_info('dpi-font: setting override font_size =', font_size)
      overrides.font_size = font_size
      window:set_config_overrides(overrides)
   end)
end

return M
