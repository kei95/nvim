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
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "jsonls",
        "html",
        "tailwindcss",
      },
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Helper functions for project detection
      local function file_exists(name)
        return vim.fn.filereadable(name) == 1
      end

      local function package_has(dep)
        local path = "package.json"
        if not file_exists(path) then return false end
        local ok, content = pcall(vim.fn.readfile, path)
        if not ok or not content then return false end
        local json_ok, json = pcall(vim.fn.json_decode, content)
        if not json_ok or not json then return false end
        local all_deps = vim.tbl_deep_extend("force", json.dependencies or {}, json.devDependencies or {})
        return all_deps[dep] ~= nil
      end

      -- Configure LSP servers using vim.lsp.config (new API)
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        capabilities = capabilities,
        settings = {
          Lua = {
            telemetry = { enable = false },
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      }

      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        root_markers = { "package.json", "tsconfig.json", ".git" },
        capabilities = capabilities,
        settings = {
          typescript = {
            format = { enable = false }, -- Disable LSP formatting
          },
          javascript = {
            format = { enable = false }, -- Disable LSP formatting
          },
        },
      }

      vim.lsp.config.jsonls = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
      }

      vim.lsp.config.html = {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
      }

      -- Conditional Tailwind CSS LSP
      if package_has("tailwindcss") or file_exists("tailwind.config.js") or file_exists("tailwind.config.ts") then
        vim.lsp.config.tailwindcss = {
          cmd = { "tailwindcss-language-server", "--stdio" },
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
          root_markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "package.json", ".git" },
          capabilities = capabilities,
        }
        vim.schedule(function() vim.notify("🔧 LSP: tailwindcss enabled (Tailwind project)") end)
      end

      -- Conditional LSP setup for Astro
      if package_has("astro") or vim.fn.glob("*.astro") ~= "" then
        vim.lsp.config.astro = {
          cmd = { "astro-language-server", "--stdio" },
          filetypes = { "astro" },
          root_markers = { "astro.config.mjs", "astro.config.js", "package.json", ".git" },
          capabilities = capabilities,
        }
        vim.schedule(function() vim.notify("🔧 LSP: astro enabled (Astro project)") end)
      end

      -- LSP-related keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition (LSP)" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references (LSP)" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Open Code action (LSP)" })
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol (LSP)" })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Peek LSP Error" })
      vim.keymap.set("n", "[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    end,
  },
}
