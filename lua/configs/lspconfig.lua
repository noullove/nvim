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
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        completion = {
          enable = true
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            -- vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            -- vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            vim.fn.stdpath "data" .. "/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    }
  },
}

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = lsp_capabilities

  require("lspconfig")[name].setup(opts)
end
