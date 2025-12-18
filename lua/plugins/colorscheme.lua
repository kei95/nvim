return {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			color_overrides = {
				mocha = {
					base = "#1d1f21", -- Tomorrow Night background
					mantle = "#1d1f21",
					crust = "#1d1f21",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
