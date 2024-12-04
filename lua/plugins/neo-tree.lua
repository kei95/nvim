return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false, -- Do not hide dotfiles (e.g., .gitignore, .env)
        never_show = { ".git", ".git/*" }, -- Hide .git and its contents
      },
    },
  },
  config = function(_, opts) -- Pass opts to setup
    require("neo-tree").setup(opts)
    vim.keymap.set("n", "<leader>ne", ":Neotree filesystem reveal right<CR>", {})
    vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
  end,
}
