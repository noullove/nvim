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

-- LSP Diagnostics 설정
vim.diagnostic.config({
  virtual_text = false, -- 가상 텍스트(코드 옆에 오류 메시지) 비활성화
})

-- 문서 호버(hover) 창 스타일 설정
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'rounded', -- 모서리가 둥근 테두리 적용
  }
)

-- 함수 시그니처 도움말 창 설정
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    focusable = false,  -- 창이 자동으로 포커스를 가져가지 않도록 설정
    border = "rounded", -- 모서리가 둥근 테두리 적용
  }
)
