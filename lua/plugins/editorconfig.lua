return {
	{
		"editorconfig/editorconfig-vim",
		lazy = false, -- Load immediately to ensure it's available
		config = function()
			-- EditorConfig settings
			vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
			vim.g.EditorConfig_exec_path = "" -- Use system editorconfig if available
			
			-- Ensure EditorConfig is loaded before other formatting plugins
			vim.g.EditorConfig_preserve_formatoptions = 1
			
			-- Set up autocmd to detect .editorconfig files and prioritize formatting
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					-- Check if .editorconfig exists in project root
					local editorconfig_path = vim.fn.findfile(".editorconfig", ".;")
					if editorconfig_path ~= "" then
						-- Notify that EditorConfig is being used
						vim.schedule(function()
							vim.notify("📝 Using EditorConfig for formatting", vim.log.levels.INFO)
						end)
					end
				end,
			})
		end,
	},
}