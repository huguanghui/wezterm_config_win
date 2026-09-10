local wezterm = require('wezterm')
local left = require('events.left-status')
local right = require('events.right-status')

local M = {}

--- 统一的状态栏事件入口。
--- 替代已废弃的 `update-left-status` / `update-right-status`:
--- 一次 `update-status` 派发内同时刷新左右两侧,避免两次事件开销。
M.setup = function()
---@diagnostic disable-next-line: unused-local
  wezterm.on('update-status', function(window, _pane)
    window:set_left_status(left.render(window))
    window:set_right_status(right.render(window))
  end)
end

return M
