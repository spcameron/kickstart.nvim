-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true, -- use Treesitter to avoid pairing in strings/comments
    disable_filetype = { 'TelescopePrompt', 'neo-tree', 'alpha', 'lazy', 'mason' },
    fast_wrap = {}, -- optional: <M-e> to wrap the next thing you type
  },
}

-- vim: ts=2 sts=2 sw=2 et
