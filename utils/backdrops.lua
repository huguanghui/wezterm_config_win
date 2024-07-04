local wezterm = require('wezterm')
local platform = require('utils.platform')()
local colors = require('colors.custom')

-- Seeding random numbers before generating for use
-- Known issue with lua math library
-- see: https://stackoverflow.com/questions/20154991/generating-uniform-random-numbers-in-lua
math.randomseed(os.time())
math.random()
math.random()
math.random()

local PATH_SEP = platform.is_win and '\\' or '/'

---@class BackDrops
---@field current_idx number index of current image
---@field files string[] background images
local BackDrops = {}
BackDrops.__index = BackDrops


--- Initialise backdrop controller
---@private
function BackDrops:init()
  local inital = {
    current_idx = 1,
    files = {},
  }
  local backdrops = setmetatable(inital, self)
  wezterm.GLOBAL.background = nil
  return backdrops
end

--- MUST BE RUN BEFORE ALL OTHER `BackDrops` functions
--- Sets the `files` after instanntiating `BackDrops`.
---
--- INFO:
---   During the initial load of the config, this function can only invoked in `wezterm.lua`.
---   WezTerm's fs unility `read_dir` (used in this function) works by running on a spawned child process.
---   This throws a coroutine error if the function is invoked in outside of `wezterm.lua` in the -
---   initial load of the Terminal config.
function BackDrops:set_files()
  self.files = wezterm.read_dir(wezterm.config_dir .. PATH_SEP .. 'backdrops')
  wezterm.GLOBAL.background = self.files[1]
  return self
end

function BackDrops:_set_opt(window)
  local opts = {
    background = {
      {
        source = { File = wezterm.GLOBAL.background },
        horizontal_align = 'Center',
      },
      {
        source = { Color = colors.background },
        height = '100%',
        width = '100%',
        opacity = 0.96,
      },
    },
  }
  window:set_config_overrides(opts)
end

function BackDrops:choices()
  local choices = {}
  for idx, file in ipairs(self.files) do
    local name = file:match('([^' .. PATH_SEP .. '] +)$')
    table.insert(choices, {
      id = tostring(idx),
      label = name,
    })
  end
  return choices
end

function BackDrops:random(window)
  self.current_idx = math.random(#self.files)
  wezterm.GLOBAL.background = self.files[self.current_idx]

  if window ~= nil then
    self:_set_opt(window)
  end
end

return BackDrops:init()
