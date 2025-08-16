-- main LSP configuration

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim' },
    { 'mason-org/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'j-hui/fidget.nvim' },
    { 'saghen/blink.cmp' },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local builtin = require 'telescope.builtin'

        -- rename the variable under the cursor
        map('n', 'grn', vim.lsp.buf.rename, '[r]e[n]ame')

        -- execute a code action
        -- usually requires the cursor to be on top of an error/suggestion
        map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, '[g]oto code [a]ction')

        -- find references for the word under the cursor
        map('n', 'grr', builtin.lsp_references, '[g]oto [r]eferences')

        -- jump to the implementation of the word under the cursor
        -- useful for languages that can declare types without an actual implementation
        map('n', 'gri', builtin.lsp_implementations, '[g]oto [i]mplementation')

        -- jump to the definition of the word under the cursor
        -- to jump back, press <C-t>
        map('n', 'grd', builtin.lsp_definitions, '[g]oto [d]efinition')

        -- jump to the declaration
        map('n', 'grD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')

        -- fuzzy find all the symbols in the current document
        -- symbols are variables, functions, types, etc.
        map('n', 'gO', builtin.lsp_document_symbols, '[O]pen document symbols')

        -- fuzzy find all the symbols in the current workspace
        map('n', 'gW', builtin.lsp_dynamic_workspace_symbols, 'open [W]orkspace symbols')

        -- jump to the type of the word under the cursor
        -- useful when you're not sure what type a variable is
        -- shows the definition of its *type*, not where it was *defined*
        map('n', 'grt', builtin.lsp_type_definitions, '[g]oto [t]ype definition')

        -- create groups once (outside or here; clear=false prevents wiping others)
        local hl_grp = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        local det_grp = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = false })

        -- this resolves a difference between versions 0.11 and 0.10
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if
          client
          and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
          and not vim.b[event.buf].lsp_doc_highlight_set
        then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = hl_grp,
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = hl_grp,
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })

          vim.b[event.buf].lsp_doc_highlight_set = true
        end

        -- one detach handler per buffer
        vim.api.nvim_create_autocmd('LspDetach', {
          group = det_grp,
          buffer = event.buf,
          callback = function(ev)
            vim.lsp.buf.clear_references()

            -- keep highlight if another client still supports it
            local keep = false
            for _, c in pairs(vim.lsp.get_clients { bufnr = ev.buf }) do
              if client_supports_method(c, vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf) then
                keep = true
                break
              end
            end

            if not keep then
              vim.api.nvim_clear_autocmds { group = hl_grp, buffer = ev.buf }
              vim.b[ev.buf].lsp_doc_highlight_set = false
            end
          end,
        })

        -- keymapping to toggle inlay hints, if the LSP supports them
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayhint, event.buf) then
          map('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[t]oggle inlay [h]ints')
        end
      end,
    })

    -- diagnostic configs
    -- see `:help vim.diagnostic.Opts`
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- the following filetypes are formatted by conform
    -- `on_attach` mutates the server capabilities for these only

    local no_format_ft = {
      clojure = true,
      css = true,
      go = true,
      html = true,
      javascript = true,
      javascriptreact = true,
      lua = true,
      python = true,
      typescript = true,
      typescriptreact = true,
    }

    local function on_attach(client, bufnr)
      if no_format_ft[vim.bo[bufnr].filetype] then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end

    -- servers
    local servers = {
      -- Bash
      bashls = { on_attach = on_attach },

      -- C / C++
      clangd = { on_attach = on_attach },

      -- Clojure
      clojure_lsp = { on_attach = on_attach },

      -- CSS
      cssls = { on_attach = on_attach },

      -- Dockerfile
      dockerls = { on_attach = on_attach },

      -- Go
      gopls = { on_attach = on_attach },

      -- GraphQL
      graphql = { on_attach = on_attach },

      -- HTML
      html = { on_attach = on_attach },

      -- JSON / JSON5
      jsonls = { on_attach = on_attach },

      -- Kotlin
      kotlin_language_server = { on_attach = on_attach },

      -- LaTeX
      texlab = { on_attach = on_attach },

      -- Lua
      lua_ls = {
        on_attach = on_attach,
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim' } },
          },
        },
      },

      -- Markdown
      marksman = { on_attach = on_attach },

      -- Python
      pyright = { on_attach = on_attach },
      ruff_lsp = { on_attach = on_attach }, -- diagnostics & code actions; Conform formats

      -- Rust
      rust_analyzer = { on_attach = on_attach },

      -- SQL
      sqls = { on_attach = on_attach },

      -- TypeScript / JavaScript
      ts_ls = { on_attach = on_attach }, -- consider 'vtsls' if you want; same on_attach
      eslint = { on_attach = on_attach }, -- diagnostics/actions; Conform runs eslint_d/prettier

      -- Vimscript
      vimls = { on_attach = on_attach },
    }

    local lsp_to_pkg = require('mason-lspconfig.mappings.server').lspconfig_to_package
    local server_pkgs = {}
    for name, _ in pairs(servers) do
      local pkg = lsp_to_pkg[name]
      if not pkg and name == 'ts_ls' then
        pkg = 'typescript-language-server'
      end
      if pkg then
        table.insert(server_pkgs, pkg)
      end
    end

    local tools = {
      'black',
      'clang-format',
      'cljstyle',
      'eslint_d',
      'goimports',
      'prettier',
      'ruff',
      'stylua',
    }

    local ensure_installed = {}
    vim.list_extend(ensure_installed, server_pkgs)
    vim.list_extend(ensure_installed, tools)
    table.sort(ensure_installed)

    local seen = {}
    local uniq = {}
    for _, name in ipairs(ensure_installed) do
      if not seen[name] then
        seen[name] = true
        table.insert(uniq, name)
      end
    end
    ensure_installed = uniq

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
