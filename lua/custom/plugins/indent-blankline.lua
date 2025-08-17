-- add indentation guides (even on blank lines)

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    scope = { enabled = true },
    exclude = {
      filetypes = { 'alpha', 'neo-tree', 'trouble', 'lazy', 'mason', 'help', 'gitcommit' },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
