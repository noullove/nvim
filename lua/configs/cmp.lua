require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")

local formatting_style = {
  fields = { "kind", "abbr", "menu" },

  format = function(entry, item)
    local icons = require("nvchad.icons.lspkind")
    local icon = icons[item.kind] or ""

    -- 소스 정보 추가 (LSP인지 확인)
    local source_name = entry.source.name
    local source_icon = {
      nvim_lsp = '',
      nvim_lua = '',
      luasnip = '',
      buffer = '',
      path = '',
    }

    -- 최대 너비 설정 (예: 10자)
    local kind_text = string.format("%-12s", item.kind or "")
    local source_text = source_icon[source_name] or ""

    -- 일관된 정렬을 위한 문자열 조합
    item.menu = kind_text .. source_text
    item.kind = icon

    return item
  end,
}

-- nvim-cmp 설정
cmp.setup({
  formatting = formatting_style,
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
