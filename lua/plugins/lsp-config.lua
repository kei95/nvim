return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        automatic_enable = false,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("config.lsp-setup").setup_lsp_per_project()

      -- LSP-related keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition (LSP)" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references (LSP)" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Open Code action (LSP)" })
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol (LSP)" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Peek LSP Error" })
      vim.keymap.set("n", "n[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "n]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    end,
  },
}
