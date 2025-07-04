vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader = " "
vim.g.background = "light"
vim.opt.swapfile = false
vim.api.nvim_set_option("clipboard", "unnamed")
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.o.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8" }
vim.env.LANG = "en_US.UTF-8"
vim.opt.conceallevel = 1

-- Disable yanking text when deleting 
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('v', 'd', '"_d', { noremap = true })

vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true }) -- Move to the left split
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true }) -- Move to the split below
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true }) -- Move to the split above
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true }) -- Move to the right split
