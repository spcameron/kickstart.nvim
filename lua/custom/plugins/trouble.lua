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
      function()
        -- If loclist is empty, populate it from diagnostics for the current window
        local size = vim.fn.getloclist(0, { size = 0 }).size or 0
        if size == 0 then
          vim.diagnostic.setloclist { open = false }
        end
        vim.cmd 'Trouble loclist toggle'
      end,
      desc = 'trouble: [L]ocation list (smart)',
    },
    {
      '<leader>xQ',
      function()
        -- If quickfix is empty, populate it from diagnostics (workspace-wide)
        local size = vim.fn.getqflist({ size = 0 }).size or 0
        if size == 0 then
          vim.diagnostic.setqflist { open = false }
        end
        vim.cmd 'Trouble qflist toggle'
      end,
      desc = 'trouble: [Q]uickfix list (smart)',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
