-- buffer line with tabpage integration

return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = {
    options = {
      mode = 'tabs',
      themable = true,
      numbers = 'none',
      indicator = { style = 'none' },
      color_icons = true,
      show_close_icon = false,
      show_buffer_close_icons = false,
      tab_size = 20,
      enforce_regular_tabs = true,
      separator_style = 'thin',
      always_show_bufferline = true,
      diagnostics = false,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Explorer',
          highlight = 'Directory',
          separator = true,
        },
        {
          filetype = 'trouble',
          text = 'Trouble',
          highlight = 'Directory',
          separator = true,
        },
      },
    },
  },
  keys = {
    { '<leader><Tab>', '<cmd>tabnext<cr>', desc = 'next tab' },
    { '<leader><S-Tab>', '<cmd>tabprevious<cr>', desc = 'prev tab' },
    { '<leader>Tn', '<cmd>tabnew<cr>', desc = '[T]ab: [n]ew' },
    { '<leader>Tq', '<cmd>tabclose<cr>', desc = '[T]ab: close' },
    { '<leader>T<', '<cmd>-tabmove<cr>', desc = '[T]ab: move [<] left' },
    { '<leader>T>', '<cmd>+tabmove<cr>', desc = '[T]ab: move [>] right' },
    { '<leader>TT', '<C-w>T', desc = '[T]ab: move window to new [T]ab' },
  },
}

-- vim: ts=2 sts=2 sw=2 et
