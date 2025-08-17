-- completion plugin with support for LSPs, cmdline, signature help and snippets

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    { 'folke/lazydev.nvim' },
    { 'L3MON4D3/LuaSnip' },
  },
  opts = {
    keymap = {
      preset = 'default',

      -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- ['<C-e>'] = { 'cancel', 'fallback' },
      -- ['<C-y>'] = { 'select_and_accept', 'fallback' },
      --
      -- ['<Up>'] = { 'select_prev', 'fallback' },
      -- ['<Down>'] = { 'select_next', 'fallback' },
      -- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      -- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      --
      -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      --
      -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
      -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      --
      -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      --
      -- see `https://github.com/Saghen/blink.cmp/blob/main/lua/blink/cmp/keymap/presets.lua`
      -- for alternative keymapping options
    },

    appearance = {
      nerd_font_variant = 'normal',
    },

    completion = {
      documentation = {
        auto_show = false,
      },
    },

    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'lazydev',
      },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 50,
        },
      },
    },

    snippets = {
      preset = 'luasnip',
    },

    fuzzy = {
      implementation = 'lua',
    },

    signature = {
      enabled = true,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
