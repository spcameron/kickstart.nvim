return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  opts = {
    flavour = 'mocha',
    float = {
      transparent = false,
      solid = false,
    },
    auto_integrations = true,
  },
  config = function(_, opts)
    local cp = require 'catppuccin'
    cp.setup(opts)
    vim.cmd.colorscheme('catppuccin-' .. (opts.flavour or 'mocha'))
  end,
}

-- vim: ts=2 sts=2 sw=2 et
