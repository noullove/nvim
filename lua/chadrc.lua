-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
	theme_toggle = { "onedark", "tokyonight" },
	transparency = true,
	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
  hl_add = {
    -- nvim-notify 투명도 수정
    NotifyBackground = {
      bg = "#000000"
    }
  }
}

M.nvdash = { load_on_startup = true }

M.ui = {
	cmp = {
		lspkind_text = true,
		style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
		format_colors = {
			tailwind = true,
		},
	},
	telescope = {
		style = "bordered",
	},
	tabufline = {
		lazyload = false,
	},
	statusline = {
		theme = "default",
		separator_style = "arrow",
		order = {
			"mode",
			"file",
			"git",
			"%=",
			"lsp_msg",
			"%=",
			"encoding",
			"diagnostics",
			"lsp",
			"cwd",
			"cursor",
			"position",
		},
		modules = {
			position = "%l:%c",
			encoding = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
				return string.upper(enc)
			end,
		},
	},
}

M.mason = {
	ensure_installed = {
		"lua-language-server",
		"stylua",
		"bash-language-server",
		"clangd",
		"clang-format",
		"codelldb",
		"css-lsp",
		"html-lsp",
    "prettier",
		"pyright",
    "isort",
    "shfmt",
	},
}

return M
