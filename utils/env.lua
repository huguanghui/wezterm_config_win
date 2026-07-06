local wezterm = require('wezterm')

---@class Env
---@field private _vars table<string, string>
local Env = {}
Env.__index = Env

local PATH_SEP = package.config:sub(1, 1)
local ENV_FILE = wezterm.config_dir .. PATH_SEP .. '.env'

---Parse a single line from .env file
---@param line string
---@return string|nil key
---@return string|nil value
local function _parse_line(line)
  -- Strip leading/trailing whitespace
  line = line:match('^%s*(.-)%s*$')
  -- Skip empty lines and comments
  if #line == 0 or line:sub(1, 1) == '#' then
    return nil, nil
  end
  -- Match KEY=VALUE (value may be quoted)
  local key, value = line:match('^([%w_]+)%s*=%s*(.+)$')
  if key then
    -- Strip optional quotes
    value = value:match('^"(.*)"$') or value:match("^'(.*)'$") or value
    return key, value
  end
  return nil, nil
end

---Initialize env parser and load .env file
---@return Env
function Env:init()
  local env = setmetatable({ _vars = {} }, self)
  env:_load()
  return env
end

---(Re)load variables from .env file
---@private
function Env:_load()
  self._vars = {}
  local f, err = io.open(ENV_FILE, 'r')
  if not f then
    wezterm.log_info('env: could not open .env file: ' .. (err or 'unknown error'))
    return
  end

  for line in f:lines() do
    local key, value = _parse_line(line)
    if key then
      self._vars[key] = value
    end
  end
  f:close()
end

---Get a single variable by key
---@param key string
---@param default string|nil fallback value if key not found
---@return string|nil
function Env:get(key, default)
  local val = self._vars[key]
  if val ~= nil then
    return val
  end
  return default
end

---Get all loaded variables as a table
---@return table<string, string>
function Env:all()
  return self._vars
end

return Env:init()
