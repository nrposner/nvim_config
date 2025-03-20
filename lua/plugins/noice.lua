return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "15%",  -- near the top; adjust as needed
          col = "50%",  -- horizontally centered
        },
        size = {
          width = 50,
          height = 1,--"auto",
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
