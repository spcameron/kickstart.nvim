-- show the context of the currently visible buffer contents

return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'VeryLazy',
  opts = {
    max_lines = 3,
  },
  keys = {
    { '<leader>tc', '<cmd>TSContextToggle<cr>', desc = '[t]oggle treesitter [c]ontext' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
