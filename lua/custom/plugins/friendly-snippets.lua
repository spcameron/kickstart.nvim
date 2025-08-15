-- snippet library

return {
  'rafamadriz/friendly-snippets',
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}

-- vim: ts= 2sts=2 sw=2 et
