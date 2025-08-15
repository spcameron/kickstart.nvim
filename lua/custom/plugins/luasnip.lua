-- snippet engine

return {
  'L3MON4D3/LuaSnip',
  version = '2.*',
  build = (function()
    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      return
    end
    return 'make install_jsregexp'
  end)(),
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
  },
  opts = {},
}

-- vim: ts=2 sts=2 sw=2 et
