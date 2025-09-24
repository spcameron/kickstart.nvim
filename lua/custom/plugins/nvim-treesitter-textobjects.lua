-- select, swap, and move to textobjects

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- Functions
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',

            -- Classes / Types
            ['aC'] = '@class.outer',
            ['iC'] = '@class.inner',

            -- Conditionals (if/elif/else in Python, if in Go)
            ['a?'] = '@conditional.outer',
            ['i?'] = '@conditional.inner',

            -- Loops (for/while in Python, for in Go)
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',

            -- Parameters
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = 'Next function start' },
            [']]'] = { query = '@class.outer', desc = 'Next class/type start' },
            [']?'] = { query = '@conditional.outer', desc = 'Next conditional' },
            [']l'] = { query = '@loop.outer', desc = 'Next loop' },
          },
          goto_next_end = {
            [']M'] = { query = '@function.outer', desc = 'Next function end' },
            [']['] = { query = '@class.outer', desc = 'Next class/type end' },
          },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = 'Prev function start' },
            ['[['] = { query = '@class.outer', desc = 'Prev class/type start' },
            ['[?'] = { query = '@conditional.outer', desc = 'Prev conditional' },
            ['[l'] = { query = '@loop.outer', desc = 'Prev loop' },
          },
          goto_previous_end = {
            ['[M'] = { query = '@function.outer', desc = 'Prev function end' },
            ['[]'] = { query = '@class.outer', desc = 'Prev class/type end' },
          },
        },
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
