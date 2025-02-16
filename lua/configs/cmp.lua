local cmp = require("cmp")
-- nvim-cmp 설정
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Snippet exntend
    end,
  },
  mapping = {
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<Enter>"] = cmp.mapping.confirm({ select = true }),
    ["<Esc>"] = cmp.mapping.abort(),
  },
  sources = {
    { name = "path" },
    { name = "luasnip" },
    { name = "render-makrdown" },
    { name = "nvim_lsp", keyword_length = 1 },
    { name = "nvim_lua", keyword_length = 2 },
    { name = "buffer", keyword_length = 3 },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
})

-- cmdline 자동완성 설정
cmp.setup.cmdline(":", {
  enabled = false, -- noice cmdline 사용
  sources = cmp.config.sources({
    { name = "cmdline" },
    { name = "nvim_lsp", keyword_length = 1 },
    { name = "nvim_lua", keyword_length = 2 },
  }),
})
