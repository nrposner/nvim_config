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
        ensure_installed = { "rust_analyzer", "pyright",},
        automatic_installation = true,
      })
    end,
  },
}
