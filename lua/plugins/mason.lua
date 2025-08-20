return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer", "pyrefly", "clangd", "wgsl_analyzer" },
        automatic_installation = true,
        handlers = {
          rust_analyzer = function() end,
          pyrefly = function()
            lspconfig.pyrefly.setup({
              cmd       = { "pyrefly", "lsp" },
              filetypes = { "python" },
              single_file_support = true,
              settings  = { pyrefly = { typeCheckingMode = "strict" } },
            })
          end,
        },
      })
    end,
  },
}
