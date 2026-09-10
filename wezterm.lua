local Config = require('config')

-- pick(true): 首次加载随机选一张;配置重载(保存文件 / Leader R)时保持当前壁纸
require('utils.backdrops'):set_files():pick(true)

require('events.status').setup()
require('events.tab-title').setup()
require('events.new-tab-button').setup()
require('events.dpi-font').setup()

return Config:init()
    :append(require('config.appearance'))
    :append(require('config.bindings'))
    :append(require('config.domains'))
    :append(require('config.fonts'))
    :append(require('config.general'))
    :append(require('config.launch')).options
