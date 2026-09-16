return {
  -- behaviours
  automatically_reload_config = true,
  exit_behavior = 'CloseOnCleanExit',  -- if the shell program exited with a successful status
  exit_behavior_messaging = 'Verbose',
  status_update_interval = 1000,

  scrollback_lines = 5000,

  hyperlink_rules = {
    -- Matches: a URL in parens: (URL)
    {
      regex = '\\((\\w+://\\S+)\\)',
      format = '$1',
      highlight = 1,
    },
    -- Matches: a URL in brackets: [URL]
    {
      regex = '\\[(\\w+://\\S+)\\]',
      format = '$1',
      highlight = 1,
    },
    -- Matches: a URL in curly braces: {URL}
    {
      regex = '\\{(\\w+://\\S+)\\}',
      format = '$1',
      highlight = 1,
    },
    -- Matches: a URL in angle brackets: <URL>
    {
      regex = '<(\\w+://\\S+)>',
      format = '$1',
      highlight = 1,
    },
    -- Then handle URLs not wrapped in brackets that
    -- 1) contain a balanced trailing parenthesis, e.g.
    --    https://en.wikipedia.org/wiki/Foo_(bar)
    {
      regex = '\\b\\w+://[^\\s()]*\\(\\S*\\)(?=\\s|$|[^_/a-zA-Z0-9-])',
      format = '$0',
    },
    -- 2) end on a URL-safe character, never on punctuation.
    --    NOTE: WezTerm ranks candidate matches by length (longest wins), not by
    --    rule order. The old greedy class `[)/a-zA-Z0-9-]` allowed a trailing
    --    ")" and so beat the "(URL)" rule above, leaking the ")" into the link.
    {
      regex = '\\b\\w+://\\S+[_/a-zA-Z0-9-]',
      format = '$0',
    },
    -- implicit mailto link
    {
      regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
      format = 'mailto:$0',
    },
  },
}
