return {
	"folke/noice.nvim",
	event = "UIEnter",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		notify = {
			enabled = false,
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
		},
		presets = {
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = true, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	},
}
