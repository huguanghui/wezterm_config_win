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
  { key = 'F1',         mods = 'NONE',        action = 'ActivateCopyMode' },
  { key = 'F2',         mods = 'NONE',        action = act.ActivateCommandPalette },
  { key = 'F3',         mods = 'NONE',        action = act.ShowLauncher },
  { key = 'F4',         mods = 'NONE',        action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
  { key = 'F11',        mods = 'NONE',        action = act.ToggleFullScreen },
  { key = 'f',          mods = mod.SUPER,     action = act.Search({ CaseInSensitiveString = '' }) },

  -- cursor movement --
  { key = 'LeftArrow',  mods = mod.SUPER,     action = act.SendString '\x1bOH' },
  { key = 'RightArrow', mods = mod.SUPER,     action = act.SendString '\x1bOF' },
  { key = 'Backspace',  mods = mod.SUPER,     action = act.SendString '\x15' },

  -- copy/paste --
  { key = 'c',          mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
  { key = 'v',          mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },

  -- tabs --
  { key = 't',          mods = mod.SUPER,     action = act.SpawnTab('DefaultDomain') },
  { key = 'w',          mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

  -- tabs: navigation
  { key = '[',          mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
  { key = ']',          mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
  { key = '[',          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
  { key = ']',          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

  -- window --
  -- spawn windows
  { key = 'n',          mods = mod.SUPER,     action = act.SpawnWindow },

  -- panes --
  -- panes: split panes
  {
    key = [[\]],
    mods = mod.SUPER,
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = [[\]],
    mods = mod.SUPER_REV,
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },

  -- panes: zoom+close pane
  { key = 'Enter', mods = mod.SUPER,     action = act.TogglePaneZoomState },
  { key = 'w',     mods = mod.SUPER,     action = act.CloseCurrentPane({ confirm = false }) },

  -- panes: navigation
  { key = 'k',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
  { key = 'j',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
  { key = 'h',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
  { key = 'l',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },
  {
    key = 'p',
    mods = mod.SUPER_REV,
    action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
  },

  -- key-tables --
  -- resizes fonts
  {
    key = 'f',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'resize_font',
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
  -- resize panes
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'resize_pane',
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
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

-- stylua: ignore
local key_tables = {
  resize_font = {
    { key = 'k',      action = act.IncreaseFontSize },
    { key = 'j',      action = act.DecreaseFontSize },
    { key = 'r',      action = act.ResetFontSize },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
}

local mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

return {
  disable_default_key_bindings = true,
  disable_default_mouse_bindings = true,
  leader = { key = 'Space', mods = mod.SUPER_REV },
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}
