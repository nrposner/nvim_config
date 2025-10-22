return {
  {
    dir = "~/.config/nvim/lua/local/lazyjj.nvim",
    -- Add this keys table
    keys = {
      {
        "<leader>lj", -- The key sequence to press
        function()
          require("lazyjj").open()
        end,
        desc = "Open lazyjj (Jujutsu TUI)", -- Description for which-key, etc.
      },
    },
  },
}
