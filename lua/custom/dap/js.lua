-- JS / TS debuggin support
-- deactivated in config by default

local M = {}

function M.setup()
  local dap = require 'dap'

  -- Path where Mason install js-debug-adapter
  local mason_root = vim.fn.stdpath 'data' .. '/mason/packages'
  local debugger_path = mason_root .. '/js-debug-apater/js-debug'

  require('dap-vscode-js').setup {
    debugger_path = debugger_path,
    adapters = {
      'pwa-node',
      'node-terminal',
      'pwa-chrome',
      'pwa-extensionHost',
    },
  }

  -- Shared configs for JS/TS
  local configs = {
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
  }

  for _, lang in ipairs {
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
  } do
    dap.configurations[lang] = configs
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
