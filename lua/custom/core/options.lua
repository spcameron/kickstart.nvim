-- [[ setting options ]]
-- see `:help vim.o` and `:help option-list`

-- Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- make line numbers default
vim.o.number = true

-- display relative line numbers
vim.o.relativenumber = true

-- enable mouse mode
vim.o.mouse = 'a'

-- do not show mode, already in the status line
vim.o.showmode = false

-- wrap long lines, but don't split words, and maintain indent
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true

-- case-insensitive search, use \C to override
vim.o.ignorecase = true
vim.o.smartcase = true

-- always show the sign column
vim.o.signcolumn = 'yes'

-- default split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- preview substitutions live
vim.o.inccommand = 'split'

-- whitespace character options
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- highlight line with cursor
vim.o.cursorline = true

-- minimum screen line padding
vim.o.scrolloff = 10

-- sync OS and Neovim clipboards
-- see `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- decrease update time
vim.o.updatetime = 250

-- mapped sequence wait time
vim.o.timeoutlen = 500

-- raise 'saved changes' dialog before action that would fail with unsaved changes (:q, :e)
-- see `:help 'confirm'`
vim.o.confirm = true

-- disable swap files
vim.o.swapfile = false

-- disable backups
vim.o.backup = false
vim.o.writebackup = false

-- save undo history
vim.o.undofile = true

-- vim: ts=2 sts=2 sw=2 et
