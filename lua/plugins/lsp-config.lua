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
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- ============================== Volar set up ==============================
			-- -- Path to the root-level TypeScript installation
			-- local root_tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib"
			--
			-- lspconfig.volar.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			-- 	init_options = {
			-- 		typescript = {
			-- 			tsdk = root_tsdk, -- Set the path to the root TypeScript SDK
			-- 		},
			-- 		vue = {
			-- 			hybridMode = false,
			-- 		},
			-- 	},
			-- })
			-- ============================================================

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
