return {"catppuccin/nvim", lazy = false, name = "catppuccin", priority = 1000, 
	config = function()
		vim.cmd.colorscheme "catppuccin"
	end
}

-- in case I decide to move back to tokyonight
--return {
  --"folke/tokyonight.nvim",
  --lazy = false,
  --priority = 1000,
  --opts = {},
  --config = function()
    --vim.cmd.colorscheme "tokyonight-night"
  --end
--}
