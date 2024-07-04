local wezterm = require('wezterm')
local platform = require('utils.platform')()
local backdrops = require('utils.backdrops')
local act = wezterm.action

local mod = {}

if platform.is_mac then
  mod.SUPER = 'SUPER'
  mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
  mod.SUPER = 'ALT'
  mod.SUPER_REV = 'ALT|CTRL'
end

local keys = {
  { key = 'F11', mods = 'NONE',        action = act.ToggleFullScreen },

  -- tabs --
  { key = 'w',   mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },
}

-- local c = {}
-- -- 取消所有默认的热键
-- c.disable_default_key_bindings = true
-- local act = wezterm.action
-- c.keys = {
--   -- Ctrl+Shift+Tab 遍历 tab
--   { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
--   -- F11 切换全屏
--   { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
--   -- Ctrl+Shift++ 字体增大
--   { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
--   -- Ctrl+Shift+- 字体减小
--   { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
--   -- Ctrl+Shift+C 复制选中区域
--   { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
--   -- Ctrl+Shift+N 新窗口
--   { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
--   -- Ctrl+Shift+T 新 tab
--   { key = 'T', mods = 'SHIFT|CTRL', action = act.ShowLauncher },
--   -- Ctrl+Shift+Enter 显示启动菜单
--   { key = 'Enter', mods = 'SHIFT|CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } },
--   -- Ctrl+Shift+V 粘贴剪切板的内容
--   { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
--   -- Ctrl+Shift+W 关闭 tab 且不进行确认
--   { key = 'W', mods = 'SHIFT|CTRL', action = act.CloseCurrentTab{ confirm = false } },
--   -- Ctrl+Shift+PageUp 向上滚动一页
--   { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.ScrollByPage(-1) },
--   -- Ctrl+Shift+PageDown 向下滚动一页
--   { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.ScrollByPage(1) },
--   -- Ctrl+Shift+UpArrow 向上滚动一行
--   { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(-1) },
--   -- Ctrl+Shift+DownArrow 向下滚动一行
--   { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(1) },
-- }

-- return c

return {
  disable_default_key_bindings = true,
  leader = { key = 'Space', mods = mod.SUPER_REV },
  keys = keys,
}
