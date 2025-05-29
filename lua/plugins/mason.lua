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
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer", "pyrefly", "gopls", "clangd", "eslint"},
        automatic_installation = true,
        handlers = {
          -- override default handler for rust_analyzer to do nothing
          rust_analyzer = function() end,
        },
      })
    end,
  },
}
