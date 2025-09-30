return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "eslint_d", "prettier", "stylua" }, -- Install these automatically
				automatic_installation = true, -- Automatically install configured sources
			})

			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					require("none-ls.formatting.eslint_d"),
					require("none-ls.diagnostics.eslint_d"),
				},
			})

			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({ async = true })
			end, {})
		end,
	},
}
