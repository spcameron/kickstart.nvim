-- fancy notifications

return {
  'rcarriga/nvim-notify',
  opts = {},
  init = function()
    vim.notify = require 'notify' -- loads at startup
  end,
}

-- vim: ts=2 sts=2 sw=2 et
