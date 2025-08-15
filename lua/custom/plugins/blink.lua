-- completion plugin with support for LSPs, cmdline, signature help and snippets

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    { 'folke/lazydev.nvim' },
    -- snippet engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = 'make install_jsregexp',
      dependencies = {
        -- snippet library
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
  },
  opts = {
    keymap = {
      preset = 'default',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
