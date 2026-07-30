return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "catppuccin/nvim" },
  event = "VeryLazy",
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto'
      }
    })
  end
}
