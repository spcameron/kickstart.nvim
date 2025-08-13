--  [[ keymaps ]]
--  see `:help vim.keymap.set()`

-- set <space> as the leader key
-- see `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- clear highlights on search when pressing <Esc> in normal modde
-- see `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
