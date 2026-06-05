-- Campbell-inspired color scheme adapted for LazyVim programming
-- Original reference: Windows Terminal Campbell
-- Key improvements for coding:
--   - Lightened blue for readability (directories, git, etc.)
--   - Slightly elevated background to reduce eye strain
--   - Brighter yellow for warnings/hints
--   - Better selection contrast

local palette = {
  -- Base
  background = '#0F1419',
  foreground = '#CCCCCC',

  -- ANSI normal (optimized for shell readability)
  black   = '#0F1419',
  red     = '#C50F1F',
  green   = '#13A10E',
  yellow  = '#D4A017',
  blue    = '#4A8CD9',   -- lightened from #0037DA — now readable on dark bg
  magenta = '#A84DBC',   -- slightly brightened
  cyan    = '#3A96DD',
  white   = '#CCCCCC',

  -- ANSI bright (kept close to original Campbell)
  bright_black   = '#767676',
  bright_red     = '#E74856',
  bright_green   = '#16C60C',
  bright_yellow  = '#F9F1A5',
  bright_blue    = '#3B78FF',
  bright_magenta = '#B4009E',
  bright_cyan    = '#61D6D6',
  bright_white   = '#F2F2F2',

  -- UI
  cursor          = '#F2F2F2',
  selection_bg    = '#2A5A9A',
  selection_fg    = '#F2F2F2',
  visual_bell     = '#1A1F26',
  scrollbar_thumb = '#4A8CD9',
  split           = '#767676',
  compose_cursor  = '#E74856',
}

return {
  foreground = palette.foreground,
  background = palette.background,
  cursor_bg = palette.cursor,
  cursor_border = palette.cursor,
  cursor_fg = palette.background,
  selection_bg = palette.selection_bg,
  selection_fg = palette.selection_fg,

  ansi = {
    palette.black,
    palette.red,
    palette.green,
    palette.yellow,
    palette.blue,
    palette.magenta,
    palette.cyan,
    palette.white,
  },

  brights = {
    palette.bright_black,
    palette.bright_red,
    palette.bright_green,
    palette.bright_yellow,
    palette.bright_blue,
    palette.bright_magenta,
    palette.bright_cyan,
    palette.bright_white,
  },

  tab_bar = {
    background = 'rgba(0,0,0,0.4)',
    active_tab = {
      bg_color = palette.blue,
      fg_color = palette.bright_white,
    },
    inactive_tab = {
      bg_color = '#151C24',
      fg_color = palette.bright_black,
    },
    inactive_tab_hover = {
      bg_color = '#1E2A36',
      fg_color = palette.foreground,
    },
    new_tab = {
      bg_color = palette.background,
      fg_color = palette.foreground,
    },
    new_tab_hover = {
      bg_color = '#151C24',
      fg_color = palette.bright_white,
      italic = true,
    },
  },

  visual_bell = palette.visual_bell,
  indexed = {
    [16] = palette.yellow,
    [17] = palette.red,
  },
  scrollbar_thumb = palette.scrollbar_thumb,
  split = palette.split,
  compose_cursor = palette.compose_cursor,
}
