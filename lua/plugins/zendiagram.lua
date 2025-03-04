return {
	"caliguIa/zendiagram.nvim",
  event = "LspAttach",
	opts = {
		-- Below are the default values
		header = "Diagnostics", -- Header text
		max_width = 50, -- The maximum width of the float window
		min_width = 25, -- The minimum width of the float window
		max_height = 10, -- The maximum height of the float window
		border = "rounded", -- The border style of the float window
		position = {
			row = 1, -- The offset from the top of the screen
			col_offset = 2, -- The offset from the right of the screen
		},
		highlights = { -- Highlight groups for each section of the float
			ZendiagramHeader = "Error", -- Accepts a highlight group name or a table of highlight group opts
			ZendiagramSeparator = "NonText",
			ZendiagramText = "Normal",
			ZendiagramKeyword = "Keyword",
		},
	},
}
