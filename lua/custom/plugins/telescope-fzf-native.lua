-- command line fuzzy finder (c port)

return {
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'make',
  cond = function()
    return vim.fn.executable 'make' == 1
  end,
}

-- vim: ts=2 sts=2 sw=2 et
