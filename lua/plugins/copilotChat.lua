return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		config = function(_, opts)
			-- Setup the plugin
			require("CopilotChat").setup(opts)

			-- Key mappings
			vim.keymap.set("n", "<leader>gc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" }) -- <leader>gc
		end,
		-- See Commands section for default commands if you want to lazy load on them
	},
}
