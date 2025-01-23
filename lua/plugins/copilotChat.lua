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
			mappings = {
				-- Use tab for completion
				complete = {
					insert = "", -- Use <Tab> for completion
				},
				-- Close the chat
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				-- Reset the chat buffer
				reset = {
					normal = "<C-x>",
					insert = "<C-x>",
				},
				-- Submit the prompt to Copilot
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-CR>",
				},
				-- Accept the diff
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				-- Show help
				show_help = {
					normal = "g?",
				},
			},
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
