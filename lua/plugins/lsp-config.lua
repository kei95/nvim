return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Uncomment lines below if you every need vue for unfortunate reason
			-- local mason_registry = require("mason-registry")
			-- local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
			-- 	.. "/node_modules/@vue/language-server"
			-- lspconfig.ts_ls.setup({
			-- 	capabilities = capabilities,
			-- 	init_options = {
			-- 		plugins = {
			-- 			{
			-- 				name = "@vue/typescript-plugin",
			-- 				location = vue_language_server_path,
			-- 				languages = { "vue" },
			-- 			},
			-- 		},
			-- 	},
			-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			-- })
			-- lspconfig.volar.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			-- 	init_options = {
			-- 		vue = {
			-- 			hybridMode = true,
			-- 		},
			-- 		typescript = {
			-- 			tsdk = "/Users/keisuke.yamashite/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib/",
			-- 		},
			-- 	},
			-- })
			-- -- ============================================================

      -- Freaking annoying, but when workig on non-Vue project, I need to comment out ts_ls and uncomment the Volar 			
      lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			-- Language server setups
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})

			-- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol (LSP)" })
			vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, { desc = "Peek LSP Error" })
			vim.keymap.set("n", "n[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "n]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
		end,
	},
}
