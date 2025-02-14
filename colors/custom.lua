-- A slightly altered version of catppucchin mocha
local mocha = {
  rosewater = '#f34b00',
  flamingo = '#f2cdcd',
  pink = '#f5c2e7',
  mauve = '#cba6f7',
  red = '#f38ba8',
  maroon = '#eba0ac',
  peach = '#fab387',
  yellow = '#f8e2af',
  green = '#a6e3a1',
  teal = '#94e2d5',
  sky = '#89dceb',
  sapphire = '#74c7ec',
  blue = '#89b4fa',
  lavender = '#b4befe',
  text = '#9cc2c3',
  subtext1 = '#bac2de',
  subtext0 = '#a6adc8',
  overlay2 = '#9399b2',
  overlay1 = '#7f849c',
  overlay0 = '#6c7086',
  surface2 = '#003748',
  surface1 = '#45475a',
  surface0 = '#313244',
  base = '#001E27',
  mantle = '#181825',
  crust = '#11111b',
}

local colorscheme = {
  foreground = mocha.text,
  background = mocha.base,
  cursor_bg = mocha.rosewater,
  cursor_border = mocha.rosewater,
  cursor_fg = mocha.crust,
  selection_bg = mocha.surface2,
  selection_fg = mocha.text,
  ansi = {
    '#002831', -- black
    '#d11c24', -- red
    '#6cbe6c', -- green
    '#a57706', -- yellow
    '#2176c7', -- blue
    '#c61c6f', -- magenta/purple
    '#259286', -- cyan
    '#eae3cb', -- white
  },
  brights = {
    '#767676', -- black
    '#E74856', -- red
    '#16c60c', -- green
    '#F9F1A5', -- yellow
    '#3B78FF', -- blue
    '#B4009E', -- magenta/purple
    '#61D6D6', -- cyan
    '#F2F2F2', -- white
  },
  tab_bar = {
    background = 'rgba(0,0,0,0.4)',
    active_tab = {
      bg_color = mocha.surface2,
      fg_color = mocha.text,
    },
    inactive_tab = {
      bg_color = mocha.surface0,
      fg_color = mocha.subtext1,
    },
    inactive_tab_hover = {
      bg_color = mocha.surface0,
      fg_color = mocha.text,
    },
    new_tab = {
      bg_color = mocha.base,
      fg_color = mocha.text,
    },
    new_tab_hover = {
      bg_color = mocha.mantle,
      fg_color = mocha.text,
      italic = true,
    }
  },
  visual_bell = mocha.surface0,
  indexed = {
    [16] = mocha.peach,
    [17] = mocha.rosewater,
  },
  scrollbar_thumb = mocha.surface2,
  split = mocha.overlay0,
  compose_cursor = mocha.flamingo, -- nightbuild only
}

return colorscheme
