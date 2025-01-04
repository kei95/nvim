return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use the latest release instead of the latest commit
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

    -- Add note_id_func inside opts
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into a valid file name.
        return title:gsub(" ", "-")
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
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
