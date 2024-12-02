return {
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>", -- Accept suggestion
          next = "<C-j>", -- Next suggestion
          prev = "<C-k>", -- Previous suggestion
          dismiss = "<C-h>", -- Dismiss suggestion
        },
      },
      panel = { enabled = true },
    })
  end,
}
