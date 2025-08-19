# Neovim Keymap Ledger

A running list of **custom** keymaps defined in your config. We’ll fill this as we review files, flag overlaps, and produce a clean export at the end.

## Conventions
- **Mode**: n (normal), i (insert), v (visual), x (visual-select), s (select), o (operator), c (cmdline), t (terminal).
- **LHS**: typed keys (use `<leader>` / `<localleader>` where relevant).
- **RHS**: command or Lua function.
- **File**: where it’s defined.
- **Conflict**: note duplicates or shadowing.

## Global
- Leader: `<space>`
- LocalLeader: `<space>`

## Keymaps
| Mode | LHS | RHS | Description | File | Notes | Conflict |
|------|-----|-----|-------------|------|-------|----------|
| n | <Esc> | <cmd>nohlsearch<CR> | Clear search highlight | custom/core/keymaps.lua | Normal-mode only | — |
| n | <leader>q | vim.diagnostic.setloclist | Open diagnostic **location** list | custom/core/keymaps.lua | Consider setqflist if you prefer quickfix | — |
| t | <Esc><Esc> | <C-\><C-n> | Exit terminal mode | custom/core/keymaps.lua | — | — |
| n | <left> | :echo "Use h to move!!" | Disable left arrow (normal) | custom/core/keymaps.lua | Echoes a message | — |
| n | <right> | :echo "Use l to move!!" | Disable right arrow (normal) | custom/core/keymaps.lua | Echoes a message | — |
| n | <up> | :echo "Use k to move!!" | Disable up arrow (normal) | custom/core/keymaps.lua | Echoes a message | — |
| n | <down> | :echo "Use j to move!!" | Disable down arrow (normal) | custom/core/keymaps.lua | Echoes a message | — |
| n | <C-h> | <C-w><C-h> | Focus left window | custom/core/keymaps.lua | — | Shadows default CTRL-H motion |
| n | <C-l> | <C-w><C-l> | Focus right window | custom/core/keymaps.lua | Consider losing default <C-l> redraw | Shadows default CTRL-L redraw |
| n | <C-j> | <C-w><C-j> | Focus lower window | custom/core/keymaps.lua | — | Shadows default CTRL-J motion |
| n | <C-k> | <C-w><C-k> | Focus upper window | custom/core/keymaps.lua | — | Shadows default CTRL-K motion |
| n | <leader>= | <C-w>= | Equalize windows in current tab | custom/core/keymaps.lua | — | — |
| n | <leader>sh | :Telescope help_tags | [s]earch [h]elp | custom/plugins/telescope.lua | builtin.help_tags | — |
| n | <leader>sk | :Telescope keymaps | [s]earch [k]eymaps | custom/plugins/telescope.lua | builtin.keymaps | — |
| n | <leader>sf | :Telescope find_files | [s]earch [f]iles | custom/plugins/telescope.lua | respects ignore + hidden | — |
| n | <leader>ss | :Telescope builtin | [s]earch [s]elect telescope | custom/plugins/telescope.lua | — | — |
| n | <leader>sw | :Telescope grep_string | [s]earch current [w]ord | custom/plugins/telescope.lua | — | — |
| n | <leader>sg | :Telescope live_grep | [s]earch by [g]rep | custom/plugins/telescope.lua | hidden enabled | — |
| n | <leader>sd | :Telescope diagnostics | [s]earch [d]iagnostics | custom/plugins/telescope.lua | — | — |
| n | <leader>sr | :Telescope resume | [s]earch [r]esume | custom/plugins/telescope.lua | — | — |
| n | <leader>s. | :Telescope oldfiles | [s]earch recent files ("." for repeat) | custom/plugins/telescope.lua | — | — |
| n | <leader><leader> | :Telescope buffers | find existing buffers | custom/plugins/telescope.lua | consider sort_mru=true | — |
| n | <leader>/ | current_buffer_fuzzy_find (dropdown) | [/] fuzzy search in current buffer | custom/plugins/telescope.lua | previewer=false, winblend=10 | — |
| n | <leader>s/ | live_grep (open files) | [s]earch [/] in open files | custom/plugins/telescope.lua | grep_open_files=true | — |
| n | <leader>sn | find_files (config dir) | [s]earch [n]eovim files | custom/plugins/telescope.lua | cwd=stdpath('config') | — |
| n | grn | vim.lsp.buf.rename | LSP: [r]e[n]ame | custom/plugins/nvim-lspconfig.lua | Buffer-local | — |
| n,x | gra | vim.lsp.buf.code_action | LSP: goto code [a]ction | custom/plugins/nvim-lspconfig.lua | Uses range in visual mode | — |
| n | grr | :Telescope lsp_references | LSP: goto [r]eferences | custom/plugins/nvim-lspconfig.lua | builtin.lsp_references | — |
| n | gri | :Telescope lsp_implementations | LSP: goto [i]mplementation | custom/plugins/nvim-lspconfig.lua | builtin.lsp_implementations | — |
| n | grd | :Telescope lsp_definitions | LSP: goto [d]efinition | custom/plugins/nvim-lspconfig.lua | builtin.lsp_definitions | — |
| n | grD | vim.lsp.buf.declaration | LSP: goto [D]eclaration | custom/plugins/nvim-lspconfig.lua | — | — |
| n | gO | :Telescope lsp_document_symbols | open d[O]cument symbols | custom/plugins/nvim-lspconfig.lua | builtin.lsp_document_symbols | — |
| n | gW | :Telescope lsp_dynamic_workspace_symbols | open [W]orkspace symbols | custom/plugins/nvim-lspconfig.lua | builtin.lsp_dynamic_workspace_symbols | — |
| n | grt | :Telescope lsp_type_definitions | LSP: goto [t]ype definition | custom/plugins/nvim-lspconfig.lua | builtin.lsp_type_definitions | — |
| n | <leader>th | Toggle Inlay Hints | [t]oggle inlay [h]ints | custom/plugins/nvim-lspconfig.lua | Only if server supports | — |
| n | <leader><Tab> | :tabnext | next tab | custom/plugins/bufferline.lua | Works without plugin; native cmd | — |
| n | <leader><S-Tab> | :tabprevious | prev tab | custom/plugins/bufferline.lua | Terminal/GUI dependent | — |
| n | <leader>Tn | :tabnew | [T]ab: [n]ew | custom/plugins/bufferline.lua | — | — |
| n | <leader>Tq | :tabclose | [T]ab: close | custom/plugins/bufferline.lua | — | — |
| n | <leader>T< | :-tabmove | [T]ab: move [<] left | custom/plugins/bufferline.lua | — | — |
| n | <leader>T> | :+tabmove | [T]ab: move [>] right | custom/plugins/bufferline.lua | — | — |
| n | <leader>TT | <C-w>T | [T]ab: move window to new [T]ab | custom/plugins/bufferline.lua | — | — |
| n,v | <leader>f | :lua require('conform').format{ async = true, lsp_format = 'fallback' } | [f]ormat buffer/selection | custom/plugins/conform.lua | On-demand format | — |
| n | ]c | Gitsigns next hunk | jump to next git [c]hange | custom/plugins/gitsigns.lua | Falls back to native in diff | — |
| n | [c | Gitsigns prev hunk | jump to previous git [c]hange | custom/plugins/gitsigns.lua | Falls back to native in diff | — |
| n | <leader>hs | :Gitsigns stage_hunk | git [s]tage hunk | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hu | :Gitsigns stage_hunk | git [u]ndo stage hunk | custom/plugins/gitsigns.lua | Intentional mapping choice | — |
| n | <leader>hr | :Gitsigns reset_hunk | git [r]eset hunk | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hS | :Gitsigns stage_buffer | git [S]tage buffer | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hR | :Gitsigns reset_buffer | git [R]eset buffer | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hp | :Gitsigns preview_hunk | git [p]review hunk | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hi | :Gitsigns preview_hunk_inline | git preview hunk [i]nline | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hb | :Gitsigns blame_line | git [b]lame line | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hB | :Gitsigns blame_line { full = true } | git [B]lame full | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hd | :Gitsigns diffthis | git [d]iff against index | custom/plugins/gitsigns.lua | — | — |
| n | <leader>hD | :Gitsigns diffthis '@' | git [D]iff against last commit | custom/plugins/gitsigns.lua | — | — |
| v | <leader>hs | :Gitsigns stage_hunk (range) | git [s]tage selection | custom/plugins/gitsigns.lua | Uses visual range | — |
| v | <leader>hr | :Gitsigns reset_hunk (range) | git [r]eset selection | custom/plugins/gitsigns.lua | Uses visual range | — |
| n | <leader>tb | :Gitsigns toggle_current_line_blame | [t]oggle current line [b]lame | custom/plugins/gitsigns.lua | — | — |
| n | <leader>tw | :Gitsigns toggle_word_diff | [t]oggle [w]ord diff | custom/plugins/gitsigns.lua | — | — |
| o,x | ih | gitsigns.select_hunk | Text object: inner [h]unk | custom/plugins/gitsigns.lua | — | — |
| n | <leader>bd | :lua require('mini.bufremove').delete(0, false) | [b]uffer [d]elete (keep window) | custom/plugins/mini.lua | — | — |
| n | <leader>bD | :lua require('mini.bufremove').delete(0, true) | [b]uffer [D]elete (force) | custom/plugins/mini.lua | — | — |
| n | \ | :Neotree reveal | Neo-tree: reveal/focus current file | custom/plugins/neo-tree.lua | Global; inside neo-tree, \ closes window | — |
| n (neo-tree) | \ | close_window | Neo-tree: close tree (buffer-local) | custom/plugins/neo-tree.lua | Filesystem window mapping | — |
| n | <F5> | :lua require('dap').continue() | debug: start/continue | custom/plugins/nvim-dap.lua | — | — |
| n | <F1> | :lua require('dap').step_into() | debug: step into | custom/plugins/nvim-dap.lua | — | Shadows default F1 help |
| n | <F2> | :lua require('dap').step_over() | debug: step over | custom/plugins/nvim-dap.lua | — | — |
| n | <F3> | :lua require('dap').step_out() | debug: step out | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>db | :lua require('dap').toggle_breakpoint() | debug: toggle [b]reakpoint | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>dB | :lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) | debug: conditional [B]reakpoint | custom/plugins/nvim-dap.lua | — | — |
| n | <F7> | :lua require('dapui').toggle() | debug UI: toggle | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>dr | :lua require('dap').repl.toggle() | debug: [r]EPL | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>df | :Telescope dap frames | DAP: [f]rames | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>dc | :Telescope dap commands | DAP: [c]ommands | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>dl | :Telescope dap list_breakpoints | DAP: [l]ist breakpoints | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>dv | :Telescope dap variables | DAP: [v]ariables | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>dL | :lua require('osv').launch{ port = 8086 } | Lua DAP: [L]aunch server | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>dR | :lua require('osv').run_this() | Lua DAP: [R]un this chunk | custom/plugins/nvim-dap.lua | — | — |
| n | <leader>tc | :TSContextToggle | [t]oggle treesitter [c]ontext | custom/plugins/nvim-treesitter-context.lua | Under <leader>t group | — |
| n | ]t | :lua require('todo-comments').jump_next() | Next TODO comment | custom/plugins/todo-comments.lua | — | — |
| n | [t | :lua require('todo-comments').jump_prev() | Prev TODO comment | custom/plugins/todo-comments.lua | — | — |
| n | <leader>xx | :Trouble diagnostics toggle | trouble: [x] diagnostics | custom/plugins/trouble.lua | Workspace diagnostics | — |
| n | <leader>xX | :Trouble diagnostics toggle filter.buf=0 | trouble: [X] buffer diagnostics | custom/plugins/trouble.lua | Current buffer only | — |
| n | <leader>xs | :Trouble symbols toggle focus=false | trouble: [s]ymbols | custom/plugins/trouble.lua | Do not autofocus list | — |
| n | <leader>xr | :Trouble lsp toggle focus=false win.position=right | trouble: [r]eferences/definitions | custom/plugins/trouble.lua | LSP: defs/refs/etc. | — |
| n | <leader>xL | populate loclist from diagnostics (if empty) + Trouble loclist toggle | trouble: [L]ocation list (smart) | custom/plugins/trouble.lua | Populates on demand; won’t clobber non-empty loclist | — |
| n | <leader>xQ | populate quickfix from diagnostics (if empty) + Trouble qflist toggle | trouble: [Q]uickfix list (smart) | custom/plugins/trouble.lua | Populates on demand; won’t overwrite existing qflist | — |

