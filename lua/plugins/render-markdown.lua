return {
	"MeanderingProgrammer/render-markdown.nvim",
	after = { "nvim-treesitter" },
	requires = {
		"nvim-tree/nvim-web-devicons",
		opt = true, -- if you prefer nvim-web-devicons
	},
	opts = {
		enabled = true,
		file_types = { "markdown", "Avante" },
	},
	ft = { "markdown", "Avante" },
}
