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

-- mason 설정
require("mason").setup({
  ui = {
    border = "rounded",
  }
})

-- which-key 설정
require("which-key").setup({
	preset = "modern",
})

-- markdown preview 설정
require("snacks").toggle
  .new({
    id = "markdown_preview",
    name = "Markdown Preview",
    get = function()
      return require("render-markdown.state").enabled or false
    end,
    set = function(state)
      if state then
        require("render-markdown.api").enable()
      else
        require("render-markdown").disable()
      end
    end,
}):map("<leader>um")

-- keyboard effect 설정
require("snacks").toggle
  .new({
    id = "keyboard_effect",
    name = "Keyboard Effect",
    get = function ()
      return require("showkeys.state").visible
    end,
    set = function(state)
      if state then
        require("showkeys").open()
        require("player-one.api").enable()
      else
        require("showkeys").close()
        require("player-one.api").disable()
      end
    end
}):map("<leader>uk")
