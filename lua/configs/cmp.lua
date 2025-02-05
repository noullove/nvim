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
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    -- { name = "buffer" },
  },
})

-- cmdline 자동완성 설정
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "cmdline" },
  }),
})
