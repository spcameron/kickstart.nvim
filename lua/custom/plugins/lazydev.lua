-- configure LuaLS for Neovim config, runtime, and plugins

return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
