return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
  },
  config = function()
    local rt = require("rust-tools")

    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          -- Optional: add keymaps here
        end,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(
          -- Automatically locate codelldb
          -- Use Mason path, fallback if needed
          "codelldb",
          "liblldb"
        ),
      },
    })
  end,
}
