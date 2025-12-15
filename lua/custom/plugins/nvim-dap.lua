-- debugger configuration

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- UI
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',

    -- Adapter installer
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Language helpers
    'leoluz/nvim-dap-go', -- Go
    'mfussenegger/nvim-dap-python', -- Python
    'jbyuki/one-small-step-for-vimkind', -- Lua

    -- Quality of life
    'theHamsta/nvim-dap-virtual-text', -- inline values
    { 'nvim-telescope/telescope-dap.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } },
  },

  keys = {
    -- core stepping (F-keys + leader equivalents)
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = '[d]ebug: Start/Continue',
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = '[d]ebug: Start/[c]ontinue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = '[d]ebug: Step Into',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = '[d]ebug: Step [i]nto',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = '[d]ebug: Step Over',
    },
    {
      '<leader>dn',
      function()
        require('dap').step_over()
      end,
      desc = '[d]ebug: Step [n]ext (over)',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = '[d]ebug: Step Out',
    },
    {
      '<leader>do',
      function()
        require('dap').step_out()
      end,
      desc = '[d]ebug: Step [o]ut',
    },

    -- breakpoints
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = '[d]ebug: Toggle [b]reakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = '[d]ebug: Set Conditional [B]reakpoint',
    },

    -- UI
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = '[d]ebug: Toggle UI',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = '[d]ebug: Toggle [u]I',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.toggle()
      end,
      desc = '[d]ebug: [r]EPL',
    },

    -- Telescope pickers
    {
      '<leader>df',
      function()
        require('telescope').extensions.dap.frames()
      end,
      desc = '[d]AP: [f]rames',
    },
    {
      '<leader>dC',
      function()
        require('telescope').extensions.dap.commands()
      end,
      desc = '[d]AP: [C]ommands',
    },
    {
      '<leader>dl',
      function()
        require('telescope').extensions.dap.list_breakpoints()
      end,
      desc = '[d]AP: [l]ist breakpoints',
    },
    {
      '<leader>dv',
      function()
        require('telescope').extensions.dap.variables()
      end,
      desc = '[d]AP: [v]ariables',
    },

    -- Go helpers
    {
      '<leader>dt',
      function()
        require('dap-go').debug_test()
      end,
      desc = '[d]ebug: Go [t]est (closest)',
    },
    {
      '<leader>dT',
      function()
        local dap = require 'dap'
        local configs = dap.configurations.go or {}

        -- Prefer the package-aware config if it exists (added by dap-go / common setups).
        for _, cfg in ipairs(configs) do
          if cfg.name == 'Debug test (go.mod)' then
            dap.run(cfg)
            return
          end
        end

        -- Fallback: if any Go test config exists, run the first one name like a test.
        for _, cfg in ipair(configs) do
          if type(cfg.name) == 'string' and cfg.name:lower():find('debug test', 1, true) then
            dap.run(cfg)
            return
          end
        end

        -- Last resort: force the selection UI.
        dap.continue()
      end,
      desc = '[d]ebug: Go [T]ests (package)',
    },

    -- Lua (OSV) helpers
    {
      '<leader>dL',
      function()
        require('osv').launch { port = 8086 }
      end,
      desc = 'Lua [d]AP: [L]aunch server',
    },
    {
      '<leader>dR',
      function()
        require('osv').run_this()
      end,
      desc = 'Lua [d]AP: [R]un this chunk',
    },
  },

  config = function()
    local dap, dapui = require 'dap', require 'dapui'

    -- Consisten platform check
    local is_win = vim.fn.has 'win32' == 1

    -- 1) Install/ensure adapters via Mason
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {
        'delve', -- Go
        'debugpy', -- Python
      },
      handlers = {},
    }

    -- 2) DAP UI
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open {}
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close {}
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close {}
    end

    -- 3) Inline values
    require('nvim-dap-virtual-text').setup { commented = true }

    -- 4) Telescope integration
    pcall(function()
      require('telescope').load_extension 'dap'
    end)

    -- 5) Go (dlv)
    require('dap-go').setup {
      delve = { detached = not is_win },
    }

    -- 6) Python (debugpy via Mason)
    do
      -- Mason installs debugpy into a venv at a stable path:
      local mason = vim.fn.stdpath 'data' .. '/mason/packages'
      local python_path = is_win and (mason .. '/debugpy/venv/Scripts/python.exe') or (mason .. '/debugpy/venv/bin/python')
      require('dap-python').setup(python_path)
      -- optional: pytest helper mappings could go here later
    end

    -- 7) Lua (OSV) — attach to a running Neovim/Lua program
    dap.adapters.nlua = function(callback, config)
      callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
    end
    dap.configurations.lua = {
      {
        type = 'nlua',
        request = 'attach',
        name = 'Attach to running Neovim instance',
        host = function()
          return '127.0.0.1'
        end,
        port = function()
          local port = tonumber(vim.fn.input('Port: ', '8086'))
          assert(port, 'Please provide a port number')
          return port
        end,
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
