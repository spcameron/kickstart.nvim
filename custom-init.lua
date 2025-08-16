require 'custom.core.options'
require 'custom.core.keymaps'
require 'custom.core.autocommands'

-- [[ install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blobl:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ configure and install plugins ]]
-- run `:Lazy` to check the current status of plugins
-- run `:Lazy update` to ... update plugins

require('lazy').setup {
  { import = 'custom.plugins' },
  -- blink.lua
  -- colorscheme.lua
  -- conform.nvim
  -- fidget.lua
  -- friendly-snippets.lua
  -- gitsigns.lua
  -- guess-indent.lua
  -- lazydev.lua
  -- luasnip.lua
  -- mason.lua
  -- nvim-lspconfig.lua
  -- nvim-treesitter.lua
  -- nvim-web-devicons.lua
  -- telescope-fzf-native.lua
  -- telescope.lua
  -- todo-comments.lua
  -- which-key.lua
  --
  -- TODO:
  -- debug
  -- indent_line
  -- lint
  -- autopairs
  -- neo-tree
  -- mini ecosystem

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
}

-- see `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
