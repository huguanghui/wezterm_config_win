local wezterm = require('wezterm')
local platform = require('utils.platform')()
local env = require('utils.env')
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
   { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
   { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
   { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
   {
      key = 'F4',
      mods = 'NONE',
      action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }),
   },
   { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
   {
      key = 'f',
      mods = mod.SUPER,
      action = act.Search({ CaseInSensitiveString = '' }),
   },

   -- cursor movement --
   { key = 'LeftArrow', mods = mod.SUPER, action = act.SendString('\x1bOH') },
   { key = 'RightArrow', mods = mod.SUPER, action = act.SendString('\x1bOF') },
   { key = 'Backspace', mods = mod.SUPER, action = act.SendString('\x15') },

   -- copy/paste --
   { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
   { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },

   -- scroll --
   { key = 'PageUp', mods = 'CTRL|SHIFT', action = act.ScrollByPage(-1) },
   { key = 'PageDown', mods = 'CTRL|SHIFT', action = act.ScrollByPage(1) },
   { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },
   { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },

   -- quick select --
   { key = 'Space', mods = 'CTRL|SHIFT', action = act.QuickSelect },

   -- tabs --
   { key = 't', mods = mod.SUPER, action = act.SpawnTab('DefaultDomain') },
   { key = 'w', mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

   -- tabs: navigation
   { key = '`', mods = mod.SUPER, action = act.ActivateLastTab },
   { key = '[', mods = mod.SUPER, action = act.ActivateTabRelative(-1) },
   { key = ']', mods = mod.SUPER, action = act.ActivateTabRelative(1) },
   { key = '[', mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
   { key = ']', mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

   -- window --
   -- spawn windows
   { key = 'n', mods = mod.SUPER, action = act.SpawnWindow },

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
   { key = 'Enter', mods = mod.SUPER, action = act.TogglePaneZoomState },
   -- { key = 'w', mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

   -- panes: navigation
   { key = 'k', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
   { key = 'j', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
   { key = 'h', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
   { key = 'l', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },
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
         timeout_miliseconds = 1000,
      }),
   },
   -- resize panes
   {
      key = 'p',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
         name = 'resize_pane',
         one_shot = false,
         timeout_miliseconds = 1000,
      }),
   },
   {
      key = 'r',
      mods = 'LEADER',
      ---@diagnostic disable-next-line: unused-local
      action = wezterm.action_callback(function(window, _pane)
         require('utils.backdrops'):random(window)
      end),
   },
   {
      key = 'R',
      mods = 'LEADER',
      action = act.ReloadConfiguration,
   },
   {
      key = 'b',
      mods = 'LEADER',
      action = act.InputSelector({
         title = '常用命令 (Button Bar)',
         choices = {
            { label = '查看日志', id = 'tail -f /var/log/syslog' },
            { label = 'ax615_bm2_pwd', id = env:get('ax615_bm2_pwd') },
         },
         ---@diagnostic disable-next-line: unused-local
         action = wezterm.action_callback(function(_window, pane, id, _label)
            if id then
               pane:send_text(id .. '\n')
            end
         end),
      }),
   },
}

for i = 1, 9 do
   -- Alt+Ctrl+1~9 跳转 Tab
   table.insert(keys, {
      key = tostring(i),
      mods = mod.SUPER_REV,
      action = act.ActivateTab(i - 1),
   })
   -- Alt+1~9 跳转 Tab
   table.insert(keys, {
      key = tostring(i),
      mods = mod.SUPER,
      action = act.ActivateTab(i - 1),
   })
end

-- stylua: ignore
local key_tables = {
  resize_font = {
    { key = 'k',      action = act.IncreaseFontSize },
    { key = 'j',      action = act.DecreaseFontSize },
    { key = '0',      action = act.ResetFontSize },
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
   leader = { key = 'Space', mods = mod.SUPER_REV, timeout_miliseconds = 1000 },
   keys = keys,
   key_tables = key_tables,
   mouse_bindings = mouse_bindings,
}
