-- catppuccin-mocha colortheme

return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'mocha',
    float = {
      transparent = false,
      solid = false,
    },
    auto_integrations = true,
  },
  config = function(_, opts)
    vim.cmd.colorscheme('catppuccin-' .. (opts.flavour or 'mocha'))
  end,
}

-- vim: ts=2 sts=2 sw=2 et
