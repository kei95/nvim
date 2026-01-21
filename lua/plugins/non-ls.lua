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

			-- Condition: only run eslint_d when eslint config exists
			local eslint_condition = function(utils)
				return utils.root_has_file({
					".eslintrc",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.json",
					".eslintrc.yml",
					".eslintrc.yaml",
					"eslint.config.js",
					"eslint.config.mjs",
					"eslint.config.cjs",
				})
			end

			-- Configure sources
			local sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				require("none-ls.formatting.eslint_d").with({
					condition = eslint_condition,
				}),
				require("none-ls.diagnostics.eslint_d").with({
					condition = eslint_condition,
				}),
			}

			null_ls.setup({
				sources = sources,
			})

			-- Enhanced format function that respects EditorConfig priority
			vim.keymap.set("n", "<leader>gf", function()
				-- Check if EditorConfig is present
				if has_editorconfig() then
					-- When EditorConfig is present, try null-ls first
					local success, _ = pcall(function()
						vim.lsp.buf.format({
							async = true,
							filter = function(client)
								-- Prefer null-ls when EditorConfig is present
								return client.name == "null-ls"
							end,
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
