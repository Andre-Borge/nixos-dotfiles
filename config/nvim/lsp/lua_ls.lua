vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server', '--stdio' },
  filetypes = { 'lua' },

  root_markers = {
    '.luarc.json',
    'init.lua',
  },

  single_file_support = true,

  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
      },
    },
  },
})


