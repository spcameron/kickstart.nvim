-- highlight, edit, and navigate code
-- see `:help nvim-treesitter`

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'clojure',
      'commonlisp',
      'css',
      'csv',
      'diff',
      'dockerfile',
      'go',
      'graphql',
      'html',
      'http',
      'java',
      'javadoc',
      'javascript',
      'json',
      'json5',
      'kotlin',
      'latex',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'racket',
      'regex',
      'rust',
      'scheme',
      'sql',
      'typescript',
      'query',
      'vim',
      'vimdoc',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { ' ruby' },
    },
    indent = {
      enable = true,
      disable = { 'ruby' },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
