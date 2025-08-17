-- mini.nvim ecosystem

return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    -- smarter textobjects with Treesitter awareness
    require('mini.ai').setup { n_lines = 500 }

    -- add/delete/replace/find/highlight surrounding
    require('mini.surround').setup()

    -- move any selection in any direction
    require('mini.move').setup()

    -- delete a buffer without closing the window
    require('mini.bufremove').setup()

    vim.keymap.set('n', '<leader>bd', function()
      require('mini.bufremove').delete(0, false)
    end, { desc = '[b]uffer [d]elete (keep window)' })

    vim.keymap.set('n', '<leader>bD', function()
      require('mini.bufremove').delete(0, true)
    end, { desc = '[b]uffer [D]elete (force close)' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
