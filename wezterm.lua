local Config = require('config')

require('utils.backdrops'):set_files():random()

return Config:init()
  :append(require('config.appearance'))
  :append(require('config.bindings'))
  :append(require('config.fonts'))
  :append(require('config.launch')).options

