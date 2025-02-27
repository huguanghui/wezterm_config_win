return {
  -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
  ssh_domains = {},

  -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
  unix_domains = {},

  -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
  wsl_domains = {},

  -- ref: https://wezfurlong.org/wezterm/config/lua/config/serial_ports.html
  serial_ports = {
    {
      name = "s5",
      port = 'COM5',
      baud = 115200,
    }
  },
}
