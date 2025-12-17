# nvim

Personal Neovim configuration. Public for reference. Not a distribution.

This setup favors explicit configuration, fast startup, and tools that stay out of the way once learned. Defaults are overridden deliberately; novelty is not a goal.

## Principles

- Explicit over clever
- Lazy-loaded by default
- Minimal global state
- Discoverable keybindings
- LSP and tooling configured directly, not abstracted away

## Plugins

**Core / UX**
- alpha.nvim
- bufferline.nvim
- lualine.nvim
- neo-tree.nvim
- which-key.nvim
- nvim-notify

**Editing**
- mini.nvim
- nvim-autopairs
- guess-indent
- indent-blankline.nvim
- todo-comments.nvim

**Search & Navigation**
- telescope.nvim
- telescope-fzf-native.nvim

**LSP / Completion / Snippets**
- nvim-lspconfig
- mason.nvim
- blink.nvim
- LuaSnip
- friendly-snippets
- lazydev.nvim

**Formatting / Linting**
- conform.nvim
- nvim-lint

**Treesitter**
- nvim-treesitter
- nvim-treesitter-textobjects
- nvim-treesitter-context

**Git**
- gitsigns.nvim

**Diagnostics / Debugging**
- trouble.nvim
- nvim-dap
- fidget.nvim

---

Assumes a working Neovim install and a Unix-like environment. This repo is intentionally undocumented beyond this point.
