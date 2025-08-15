-- highlight todo, notes, etc in comments

return {
  'folke/todo-comments.nvim',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
  },
  keys = {
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next TODO comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Prev TODO comment',
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
