return {
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = false, -- Ensure it's loaded eagerly
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false, -- Disable CursorHold autocommand
			})
		end,
	},
	{
		-- Ensure commenting functionality works seamlessly
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = function(ctx)
					-- Use ts_context_commentstring for files where it's needed
					if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescriptreact" then
						return require("ts_context_commentstring.internal").calculate_commentstring()
					end
				end,
			})

      -- Override get_option to use ts_context_commentstring's commentstring
			local get_option = vim.filetype.get_option
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end
		end,
	},
}
