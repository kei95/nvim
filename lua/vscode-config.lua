-- 📍 VSCode-specific Neovim config for Cursor
-- This file is only loaded when vim.g.vscode == true

-- Set leader key
vim.g.mapleader = " "

-- Log to confirm it's loaded (optional)
vim.notify("✅ Loaded vscode-config.lua for Cursor")

vim.api.nvim_set_option("clipboard", "unnamed")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 🧭 Window navigation using VS Code commands
local ok, vscode = pcall(require, "vscode")
if ok then
	map("n", "<leader>h", function()
		vscode.action("workbench.action.focusLeftGroup")
	end, opts)
	map("n", "<leader>j", function()
		vscode.action("workbench.action.focusBelowGroup")
	end, opts)
	map("n", "<leader>k", function()
		vscode.action("workbench.action.focusAboveGroup")
	end, opts)
	map("n", "<leader>l", function()
		vscode.action("workbench.action.focusRightGroup")
	end, opts)
else
	vim.notify("❌ Failed to load 'vscode' module", vim.log.levels.ERROR)
end

-- 🔍 Quick open (Command Palette alternative)
map("n", "<C-f>", function()
	vscode.action("workbench.action.quickOpen")
end, opts)

-- 🔍 File search with Ctrl+P (like Cmd+P)
map("n", "<C-p>", function()
	vscode.action("workbench.action.quickOpen")
end, opts)

-- 🔍 Find in current file (like Cmd+F)
map("n", "<leader>ff", function()
	vscode.action("actions.find")
end, opts)

-- 🔍 Global search in files (like Shift+Cmd+F)
map("n", "<leader>fg", function()
	vscode.action("workbench.action.findInFiles")
end, opts)

-- 🧹 Format document (EditorConfig priority)
map("n", "<leader>gf", function()
	-- Check if EditorConfig is present in the project
	local editorconfig_path = vim.fn.findfile(".editorconfig", ".;")
	if editorconfig_path ~= "" then
		-- Use VS Code's format document which respects EditorConfig
		vscode.action("editor.action.formatDocument")
		vim.schedule(function()
			vim.notify("📝 Formatting with EditorConfig (VS Code)", vim.log.levels.INFO)
		end)
	else
		-- Standard VS Code formatting
		vscode.action("editor.action.formatDocument")
	end
end, opts)

-- 🗂 Toggle file explorer
map("n", "<leader>ne", function()
	vscode.action("workbench.view.explorer")
end, opts)

-- 🌿 Toggle git sidebar
map("n", "<leader>nb", function()
	vscode.action("workbench.view.scm")
end, opts)

-- Peak error/warning messages
map("n", "<leader>e", function()
	vscode.action("editor.action.showHover")
end, opts)

-- 📜 Show definition preview hover
map("n", "K", function()
	vscode.action("editor.action.showDefinitionPreviewHover")
end, opts)

-- ➕ Add line below / above
map("n", "o", function()
	vscode.action("editor.action.insertLineAfter")
end, opts)
map("n", "O", function()
	vscode.action("editor.action.insertLineBefore")
end, opts)

-- 💬 Toggle comment
map("v", "<leader>gc", function()
	vscode.action("editor.action.commentLine")
end, opts)

-- ⚡ Quick action (Code actions)
map("n", "<leader>ca", function()
	vscode.action("editor.action.quickFix")
end, opts)

-- ✏️ Rename symbol (same as Fn+F2)
map("n", "<leader>r", function()
	vscode.action("editor.action.rename")
end, opts)

-- Disable yanking text when deleting
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })

-- Set miminalistic plugins with lazy
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			"kylechui/nvim-surround",
			version = "*",
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({})
			end,
		},
	}
})
