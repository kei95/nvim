local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function file_exists(name)
  return vim.fn.filereadable(name) == 1
end

-- ✅ Safe version: only check current folder
local function has_file_with_ext(ext)
  return vim.fn.glob("*." .. ext) ~= ""
end

local function package_has(dep)
  local path = "package.json"
  if not file_exists(path) then
    return false
  end

  local ok, content = pcall(vim.fn.readfile, path)
  if not ok or not content then
    return false
  end

  local json_ok, json = pcall(vim.fn.json_decode, content)
  if not json_ok or not json then
    return false
  end

  local all_deps = vim.tbl_deep_extend("force", json.dependencies or {}, json.devDependencies or {})
  return all_deps[dep] ~= nil
end

local function setup_lsp_per_project()
  -- Always-enabled LSPs
  lspconfig.lua_ls.setup({ capabilities = capabilities })
  lspconfig.jsonls.setup({ capabilities = capabilities })
  lspconfig.html.setup({ capabilities = capabilities })
  lspconfig.eslint.setup({ capabilities = capabilities })

  -- Detect project root
  local root = vim.loop.cwd() -- safer than vim.fn.getcwd()

  -- Tailwind CSS LSP
  if package_has("tailwindcss") or file_exists("tailwind.config.js") or file_exists("tailwind.config.ts") then
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "astro",
      }
    })
    print("🔧 LSP: tailwindcss enabled (Tailwind project)")
  end

  -- Astro project
  if has_file_with_ext("astro") or package_has("astro") then
    lspconfig.astro.setup({
      capabilities = capabilities,
    })
    print("🔧 LSP: astro enabled (Astro project)")
  end

  -- Vue project
  if has_file_with_ext("vue") or package_has("vue") then
    lspconfig.volar.setup({
      capabilities = capabilities,
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      init_options = {
        typescript = {
          tsdk = root .. "/node_modules/typescript/lib",
        },
      },
    })
    print("🔧 LSP: Volar enabled (Vue project)")
    return
  end

  -- React project
  if package_has("react") then
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
    })
    print("🔧 LSP: ts_ls enabled (React project)")
    return
  end

  -- Vanilla TS/JS or any TypeScript project
  if
      has_file_with_ext("ts")
      or has_file_with_ext("js")
      or package_has("typescript")
      or package_has("@types/node")
  then
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
    })
    print("🔧 LSP: ts_ls enabled (TypeScript/JavaScript project)")
  end
end

return {
  setup_lsp_per_project = setup_lsp_per_project,
}
