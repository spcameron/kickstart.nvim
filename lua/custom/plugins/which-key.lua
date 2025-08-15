-- show available keybindings as you type

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {},
    },
    spec = {
      { '<leader>s', group = '[s]earch' },
      { '<leader>t', group = '[t]oggle' },
      { '<leader>h', group = 'git [h]unk', mode = { 'n', 'v', 'o', 'x' } },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
