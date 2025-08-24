return {
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				view = {
					default = {
						layout = "diff2_horizontal",
					},
					merge_tool = {
						layout = "diff3_horizontal",
					},
				},
			})

			vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
			vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Close Diffview" })
			vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>", { desc = "File History" })
			vim.keymap.set("n", "<leader>df", ":DiffviewFileHistory %<CR>", { desc = "Current File History" })
		end,
	},
}
