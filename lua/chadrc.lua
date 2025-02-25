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
			bg = "#000000",
		},
	},
	integrations = { "cmp", "dap", "lsp", "notify", "devicons", "mason", "nvcheatsheet", "treesitter", "trouble" },
}

M.ui = {
	cmp = {
		lspkind_text = true,
		style = "atom",
		format_colors = {
			tailwind = true,
		},
	},

	tabufline = {
		enabled = true,
		lazyload = false,
		order = { "treeOffset", "buffers", "tabs", "btns" },
		modules = nil,
		bufwidth = 21,
	},

	statusline = {
		theme = "minimal",
		separator_style = "default",
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
		},
		modules = {
      encoding = function()
        local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
        if enc == "utf-8" then
          return "" -- UTF-8일 때는 아무것도 표시 안 함
        end
        return "  " .. enc:upper()
      end,
    },
	},
}

M.nvdash = { load_on_startup = false }

M.lsp = { signature = true }

M.cheatsheet = {
	theme = "grid",
	excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
}

M.term = {
	winopts = { number = false },
	sizes = { sp = 0.5, vsp = 0.5, ["bo sp"] = 0.5, ["bo vsp"] = 0.5 },
	float = {
		relative = "editor",
		row = 0.1,
		col = 0.2,
		width = 0.6,
		height = 0.8,
		border = "single",
	},
}

M.colorify = {
	enabled = true,
	mode = "virtual",
	virt_text = "󱓻 ",
	highlight = { hex = true, lspvars = true },
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
		"marksman",
	},
}

return M
