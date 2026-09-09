local wezterm = require('wezterm')
local platform = require('utils.platform')()
local colors = require('colors.campbell')

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


--- Return the background layer list for a given wallpaper file.
--- Pure: does not touch `wezterm.GLOBAL`.
--- When `file` is nil (no backdrops available) only the dark overlay is
--- returned, so the config still renders a plain scheme background.
--- Layer order matters: image first (back), tint overlay second (front).
function BackDrops.layers(file)
  local layers = {
    {
      source = { Color = colors.background },
      height = '100%',
      width = '100%',
      opacity = 0.85,
    },
  }
  if file then
    table.insert(layers, 1, {
      source = { File = file },
      horizontal_align = 'Center',
    })
  end
  return layers
end


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
  local dir = wezterm.config_dir .. PATH_SEP .. 'backdrops'
  local ok, files = pcall(wezterm.read_dir, dir)
  self.files = (ok and files) or {}

  if #self.files == 0 then
    wezterm.log_info('backdrops: no images found in ' .. dir)
  end

  wezterm.GLOBAL.background = self.files[1]
  return self
end

function BackDrops:_set_opt(window)
  window:set_config_overrides({
    background = self.layers(wezterm.GLOBAL.background),
  })
end

function BackDrops:choices()
  local choices = {}
  for idx, file in ipairs(self.files) do
    local name = file:match('([^' .. PATH_SEP .. ']+)$')
    table.insert(choices, {
      id = tostring(idx),
      label = name,
    })
  end
  return choices
end

function BackDrops:random(window)
  if #self.files == 0 then
    wezterm.GLOBAL.background = nil
  else
    self.current_idx = math.random(#self.files)
    wezterm.GLOBAL.background = self.files[self.current_idx]
  end

  if window ~= nil then
    self:_set_opt(window)
  end
end

return BackDrops:init()
