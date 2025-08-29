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

-- Disable yanking text when deleting 
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('v', 'd', '"_d', { noremap = true })

vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true, silent = true }) -- Move to the left split
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true, silent = true }) -- Move to the split below
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true, silent = true }) -- Move to the split above
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true, silent = true }) -- Move to the right split

vim.keymap.set("n", "<M-CR>", function()
  local url = vim.fn.expand("<cfile>")
  if url:match("^https?://") then
    vim.fn.jobstart({ "open", url }, { detach = true })
  else
    print("Not a valid URL: " .. url)
  end
end, { desc = "Open URL under cursor in browser" })

vim.keymap.set('n', '<leader>n', ':edit<CR>', { noremap = true, silent = true, desc = "Reload current file" })

-- Window resizing 
vim.keymap.set('n', '<leader>;', ':resize -5<CR>', { noremap = true, silent = true, desc = "Increase window height by 5" })
vim.keymap.set('n', "<leader>'", ':resize +5<CR>', { noremap = true, silent = true, desc = "Decrease window height by 5" })
vim.keymap.set('n', '<leader>,', ':vertical resize +5<CR>', { noremap = true, silent = true, desc = "Increase window width by 5" })
vim.keymap.set('n', '<leader>.', ':vertical resize -5<CR>', { noremap = true, silent = true, desc = "Decrease window width by 5" })
