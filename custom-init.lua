require 'custom.core.options'
require 'custom.core.keymaps'

-- [[ install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blobl:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

-- [[ configure and install plugins ]]

require('lazy').setup {
  { import = 'custom.plugins' },
  -- colorscheme.lua
}

-- modeline
-- vim: ts=2 sts=2 sw=2 et
