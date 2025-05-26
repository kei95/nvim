-- Bootstrap lazy.nvim
vim.cmd("language en_US")

if vim.g.vscode then
	-- Cursor / VSCode Neovim settings
	require("vscode-config")
else
	-- Standalone Neovim settings
	require("native-config")
end
