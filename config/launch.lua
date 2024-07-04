local platform = require('utils.platform')()

local options = {
  default_prog = {},
  launch_menu = {},
}

if platform.is_win then
  options.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe', '-nologo' }
  options.launch_menu = {
    { label = 'PowerShell Core',    args = { 'pwsh' } },
    { label = 'PowerShell Desktop', args = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe', '-nologo' } },
  }
elseif platform.is_mac then
elseif platform.is_linux then
end


return options
