return {
  "neovim/nvim-lspconfig",
  opts = {
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = {
      volar = {
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },
    },
  },
}
