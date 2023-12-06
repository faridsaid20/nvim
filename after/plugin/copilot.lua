require('copilot').setup({
  panel = {
    enabled = false,
    auto_refresh = false,
    keymap = {
      jump_prev = "arrow_up",
      jump_next = "arrow_down",
      accept = "<CR>",
      refresh = "gr",
      open = "<C-p>a"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<Tab>",
      accept_word = false,
      accept_line = false,
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<C-e>",
    },
  },
  filetypes = {
    yaml = true,
    markdown = true,
    help = false,
    gitcommit = true,
    gitrebase = true,
    hgcommit = true,
  },

  copilot_node_command = "/home/ubuntu/.nvm/versions/node/v18.16.1/bin/node", -- Node.js version must be > 18.x
  server_opts_overrides = {},
})
