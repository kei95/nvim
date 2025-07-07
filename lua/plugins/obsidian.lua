return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = {
      {
        name = "kei95",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/kei95",
      },
    },
    ui = {
      enable = false,
    },
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        return title:gsub(" ", "-")
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
          return tostring(os.time()) .. "-" .. suffix
        end
      end
    end,
  },
  keys = {
    {
      desc = "Create New Note",
      "<LEADER>on",
      "<cmd>ObsidianNew<cr>",
    },
    {
      desc = "Open Note in Obsidian",
      "<LEADER>oo",
      "<cmd>ObsidianOpen<cr>",
    },
    {
      desc = "Search Note in Obsidian",
      "<LEADER>os",
      "<cmd>ObsidianSearch<cr>",
    },
    {
      desc = "Search Tags",
      "<LEADER>ot",
      "<cmd>ObsidianTags<cr>",
    },
  },
}
