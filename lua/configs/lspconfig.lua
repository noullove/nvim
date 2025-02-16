local lspconfig = require("lspconfig")
local nvlsp = require("nvchad.configs.lspconfig")
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local servers = {
  bashls = {
    filetypes = { "sh", "zsh" },
  },
  html = {},
  cssls = {},
  clangd = {
    filetypes = { "c", "cc", "cpp", "objc", "objcpp" },
  },
  pyright = {},
  marksman = {},
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- 각 LSP별 설정 적용
for lsp, config in pairs(servers) do
  lspconfig[lsp].setup(vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = lsp_capabilities,
  }, config))
end
