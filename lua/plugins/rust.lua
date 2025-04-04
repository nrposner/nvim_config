return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },
  config = function()
    local mason_registry = require("mason-registry")
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- or .so/.dll based on OS

    require("rust-tools").setup({
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
      tools = {
        executor = require("rust-tools.executors").termopen,
        reload_workspace_from_cargo_toml = true,
      },
      server = {
        on_attach = function(_, bufnr)
          -- optional: set keymaps for debugging, hover actions, etc.
        end,
      },
    })
  end,
}
