return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      require('lspconfig').gleam.setup{}
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup({
        ensure_installed = { "ty", "clangd", "wgsl_analyzer" },
        -- ensure_installed = { "rust_analyzer", "ty", "clangd", "wgsl_analyzer" },
        automatic_installation = true,
        handlers = {
          -- rust_analyzer = function() end,
          ty = function()
            lspconfig.ty.setup({
              cmd       = { "ty", "lsp" },
              filetypes = { "python" },
              single_file_support = true,
              -- settings  = { pyrefly = { typeCheckingMode = "strict" } },
            })
          end,
        },
      })
    end,
  },
}
