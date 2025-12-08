vim.opt.autoread = true
vim.opt.autowriteall = false
vim.opt.updatetime = 1000

local augroup = vim.api.nvim_create_augroup("auto-reload", { clear = true })

-- Check for external changes on various events
vim.api.nvim_create_autocmd({
  "FocusGained",
  "BufEnter",
  "CursorHold",
  "CursorHoldI",
}, {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
      vim.cmd("silent! checktime")
    end
  end,
})

-- When file change is detected, reload without confirmation
vim.api.nvim_create_autocmd("FileChangedShell", {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.v.fcs_reason == "changed" or vim.v.fcs_reason == "conflict" then
      vim.v.fcs_choice = "reload"
    end
  end,
})

-- Notify after reload
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.notify("File reloaded from disk", vim.log.levels.INFO)
  end,
})
