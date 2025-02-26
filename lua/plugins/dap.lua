return {
	"mfussenegger/nvim-dap",
	module = { "dap" },
	event = "LspAttach",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			module = { "dapui" },
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
		},
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		require("configs.dap")
	end,
}
