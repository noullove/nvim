return {
	"olimorris/codecompanion.nvim",
	event = "LspAttach",
	cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
	config = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			-- Change the default chat adapter
			chat = {
				adapter = "copilot",
			},
			inline = {
				adapter = "copilot",
			},
		},
		opts = {
			-- Set debug logging
			log_level = "DEBUG",
		},
	},
}
