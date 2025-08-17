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
    'leoluz/nvim-dap-go', -- Go (you already had this)
    'mfussenegger/nvim-dap-python', -- Python
    'mxsdev/nvim-dap-vscode-js', -- JS/TS glue (adapter comes from Mason)
    'jbyuki/one-small-step-for-vimkind', -- Lua (OSV)

    -- Quality of life
    'theHamsta/nvim-dap-virtual-text', -- inline values
    { 'nvim-telescope/telescope-dap.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } },
  },

  keys = {
    -- core stepping
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = '[d]ebug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = '[d]ebug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = '[d]ebug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = '[d]ebug: Step Out',
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
      '<leader>dc',
      function()
        require('telescope').extensions.dap.commands()
      end,
      desc = '[d]AP: [c]ommands',
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

    -- 1) Install/ensure adapters via Mason
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {
        'delve', -- Go
        'debugpy', -- Python
        'js-debug-adapter', -- JS/TS (Microsoft js-debug)
      },
      handlers = {},
    }

    -- 2) DAP UI
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
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
      delve = { detached = vim.fn.has 'win32' == 0 },
    }

    -- 6) Python (debugpy via Mason)
    do
      local ok, mason_registry = pcall(require, 'mason-registry')
      local python_path = 'python'
      if ok and mason_registry.has_package 'debugpy' then
        local pkg = mason_registry.get_package 'debugpy'
        local install_path = pkg:get_install_path()
        -- debugpy bundles a venv; point to its Python
        if vim.loop.os_uname().sysname == 'Windows_NT' then
          python_path = install_path .. '\\venv\\Scripts\\python.exe'
        else
          python_path = install_path .. '/venv/bin/python'
        end
      end
      require('dap-python').setup(python_path)
      -- optional: pytest helper mappings could go here later
    end

    -- 7) JavaScript / TypeScript (js-debug via Mason)
    do
      local ok, mason_registry = pcall(require, 'mason-registry')
      local debugger_path
      if ok and mason_registry.has_package 'js-debug-adapter' then
        local pkg = mason_registry.get_package 'js-debug-adapter'
        debugger_path = pkg:get_install_path() .. '/js-debug'
      end
      require('dap-vscode-js').setup {
        debugger_path = debugger_path, -- if nil, plugin tries defaults; Mason path is preferred
        adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal', 'pwa-extensionHost' },
      }

      -- Common Node/TS configs
      for _, language in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' } do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
            runtimeExecutable = 'node',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach (pick process)',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          -- Example Jest test config (enable if you use Jest):
          -- {
          --   type = 'pwa-node',
          --   request = 'launch',
          --   name = 'Jest Current File',
          --   runtimeExecutable = 'node',
          --   runtimeArgs = { './node_modules/jest/bin/jest.js', '${file}', '--runInBand' },
          --   cwd = '${workspaceFolder}',
          --   console = 'integratedTerminal',
          -- }
        }
      end
    end

    -- 8) Lua (OSV) — attach to a running Neovim/Lua program
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

    -- Optional: load vscode-style launch.json if present (maps adapters to filetypes)
    local ok, vscode = pcall(require, 'dap.ext.vscode')
    if ok then
      vscode.load_launchjs(nil, {
        ['pwa-node'] = { 'javascript', 'typescript' },
        ['node'] = { 'javascript', 'typescript' },
        ['pwa-chrome'] = { 'javascript', 'typescript' },
        ['chrome'] = { 'javascript', 'typescript' },
        ['python'] = { 'python' },
        ['codelldb'] = { 'c', 'cpp', 'rust' },
      })
    end
  end,
}

-- vim: ts=2 sts=2 sw=2 et
