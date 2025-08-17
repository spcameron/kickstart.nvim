-- pretty list for showing diagnostics, references,
-- telescope results, quickfixes, and location lists

return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {}, -- defaults are fine
  keys = {
    -- diagnostics
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<CR>',
      desc = 'trouble: [x] diagnostics',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
      desc = 'trouble: [X] buffer diagnostics',
    },

    -- symbols (document)
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle focus=false<CR>',
      desc = 'trouble: [s]ymbols',
    },

    -- lsp: definitions/references/etc. (side panel, don’t steal focus)
    {
      '<leader>xr',
      '<cmd>Trouble lsp toggle focus=false win.position=right<CR>',
      desc = 'trouble: [r]eferences/definitions',
    },

    -- lists
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<CR>',
      desc = 'trouble: [L]ocation list',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<CR>',
      desc = 'trouble: [Q]uickfix list',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
