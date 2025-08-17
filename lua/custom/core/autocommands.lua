-- [[ basic autocommands ]]
-- see `:help lua-guide-autocommands`

-- Yank highlight (0.11 uses vim.hl.on_yank)
local yank_grp = vim.api.nvim_create_augroup('KickstartHighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_grp,
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Equalize splits when the editor is resized
local resize_grp = vim.api.nvim_create_augroup('EqualizeSplitsOnResize', { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  group = resize_grp,
  desc = 'Equalize window splits on UI resize',
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

-- vim: ts=2 sts=2 sw=2 et
