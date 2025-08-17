if vim.loader and vim.loader.enable then
  vim.loader.enable()
end

require 'custom.core.options'
require 'custom.core.keymaps'
require 'custom.core.autocommands'

-- [[ install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ configure and install plugins ]]
-- run `:Lazy` to check the current status of plugins
-- run `:Lazy update` to ... update plugins

require('lazy').setup({
  { import = 'custom.plugins' },

  -- [[ all plugins stored in lua/custom/plugins/ ]]
  --
  -- alpha.lua
  -- blink.lua
  -- bufferline.lua
  -- colorscheme.lua
  -- conform.lua
  -- fidget.lua
  -- friendly-snippets.lua
  -- gitsigns.lua
  -- guess-indent.lua
  -- indent-blankline.lua
  -- lazydev.lua
  -- lualine.lua
  -- luasnip.lua
  -- mason.lua
  -- mini.lua
  -- neo-tree.lua
  -- nvim-autopairs.lua
  -- nvim-dap.lua
  -- nvim-lint.lua
  -- nvim-lspconfig.lua
  -- nvim-notify.lua
  -- nvim-treesitter-context.lua
  -- nvim-treesitter.lua
  -- nvim-web-devicons.lua
  -- telescope-fzf-native.lua
  -- telescope.lua
  -- todo-comments.lua
  -- trouble.lua
  -- which-key.lua
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- see `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
