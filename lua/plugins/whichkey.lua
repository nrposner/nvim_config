return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300, 
    plugins = {
      presets = {
        operators = false,  -- ✅ disable operator key interception like `d`, `y`, `c`
      },
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
