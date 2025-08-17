-- greeter and dashboard

return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  opts = function()
    local dashboard = require 'alpha.themes.dashboard'

    local header = [=[
 ____ ____ ____ ____ ____ _________ ____ ____ ____ 
||T |||I |||P |||P |||Y |||       |||T |||A |||P ||
||__|||__|||__|||__|||__|||_______|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|

      ]=]

    dashboard.section.header.val = vim.split(header, '\n', { plain = true, trimempty = true })

    local btn = dashboard.button
    dashboard.section.buttons.val = {
      btn('n', '  New file', ':ene | startinsert<CR>'),
      btn('f', '  Find files', ':Telescope find_files<CR>'),
      btn('r', '  Recent files', ':Telescope oldfiles<CR>'),
      btn('g', '  Live grep', ':Telescope live_grep<CR>'),
      btn('c', '  Config files', function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
      end),
      btn('q', '  Quit', ':qa<CR>'),
    }

    dashboard.section.footer.val = function()
      local ok, lazy = pcall(require, 'lazy')
      if not ok then
        return ''
      end
      local stats = lazy.stats()
      return (' %d plugins loaded in %.1f ms'):format(stats.count, stats.startuptime)
    end

    dashboard.section.header.opts.hl = 'Title'
    dashboard.section.header.opts.position = 'center'

    dashboard.section.buttons.opts.hl = 'Keyword'
    dashboard.section.buttons.opts.position = 'center'

    dashboard.section.footer.opts.hl = 'Comment'
    dashboard.section.footer.opts.position = 'center'

    dashboard.opts.layout = {
      { type = 'padding', val = 20 },
      dashboard.section.header,
      { type = 'padding', val = 1 },
      dashboard.section.buttons,
      { type = 'padding', val = 1 },
      dashboard.section.footer,
    }

    if vim.fn.argc(-1) > 0 or vim.fn.line2byte '$' ~= -1 then
      return { enabled = false }
    end

    return dashboard.opts
  end,

  config = function(_, opts)
    if opts.enabled == false then
      return
    end

    require('alpha').setup(opts)

    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        pcall(require('alpha').redraw)
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'AlphaReady',
      callback = function()
        local laststatus, showtabline = vim.o.laststatus, vim.o.showtabline

        vim.o.laststatus = 0
        vim.o.showtabline = 0

        vim.b.lualine_disable = true

        pcall(function()
          require('ibl').setup_buffer(0, { enabled = false })
        end)
        vim.b.ibl_disable = true

        vim.api.nvim_create_autocmd('BufUnload', {
          buffer = 0,
          once = true,
          callback = function()
            vim.o.laststatus = laststatus
            vim.o.showtabline = showtabline
          end,
        })
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
