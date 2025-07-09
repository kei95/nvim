return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    require("render-markdown").setup({
      heading = {
        width = "block",
        left_pad = 0,
        right_pad = 4,
        icons = {},
      },
    })
  end,
}
