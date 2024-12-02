-- Bootstrap lazy.nvim
vim.cmd("language en_US")

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
vim.api.nvim_set_option("clipboard", "unnamed")
-- To jump around splitted windows
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true }) -- Move to the left split
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true }) -- Move to the split below
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true }) -- Move to the split above
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true }) -- Move to the right split

require("vim-options")
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
