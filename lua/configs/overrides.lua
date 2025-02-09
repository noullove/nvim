-- treesitter 설정
-- 기본 파서 설정 (자동설치)
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"c_sharp",
		"cmake",
		"cpp",
		"css",
    "diff",
		"html",
		"java",
		"json",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"printf",
		"python",
		"query",
		"regex",
		"vim",
		"vimdoc",
		"yaml",
	},
	sync_install = true,
	auto_install = true,
})

require("mason").setup({
  ui = {
    border = "rounded",
  }
})

require("which-key").setup({
	preset = "modern",
})
