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

			-- Helper function to check if EditorConfig is present
			local function has_editorconfig()
				return vim.fn.findfile(".editorconfig", ".;") ~= ""
			end

			-- Configure sources based on EditorConfig presence
			local sources = {}
			
			if has_editorconfig() then
				-- When EditorConfig is present, use it as primary formatter
				-- Add other formatters as fallbacks only
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					require("none-ls.formatting.eslint_d"),
					require("none-ls.diagnostics.eslint_d"),
				}
				vim.schedule(function()
					vim.notify("📝 EditorConfig detected - using as primary formatter", vim.log.levels.INFO)
				end)
			else
				-- When no EditorConfig, use standard formatters
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					require("none-ls.formatting.eslint_d"),
					require("none-ls.diagnostics.eslint_d"),
				}
			end

			null_ls.setup({
				sources = sources,
			})

			-- Enhanced format function that respects EditorConfig priority
			vim.keymap.set("n", "<leader>gf", function()
				-- Check if EditorConfig is present
				if has_editorconfig() then
					-- When EditorConfig is present, try null-ls first
					local success, err = pcall(function()
						vim.lsp.buf.format({ 
							async = true,
							filter = function(client)
								-- Prefer null-ls when EditorConfig is present
								return client.name == "null-ls"
							end
						})
					end)
					
					if success then
						vim.schedule(function()
							vim.notify("📝 Formatting with EditorConfig via null-ls", vim.log.levels.INFO)
						end)
					else
						-- Fallback to any available formatter
						vim.lsp.buf.format({ async = true })
						vim.schedule(function()
							vim.notify("📝 Formatting with EditorConfig (fallback)", vim.log.levels.INFO)
						end)
					end
				else
					-- Standard LSP formatting when no EditorConfig
					vim.lsp.buf.format({ async = true })
				end
			end, { desc = "Format document (EditorConfig priority)" })
		end,
	},
}
