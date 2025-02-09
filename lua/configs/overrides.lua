-- telescope picker multi file open
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- telescope 에서 멀티 파일 열기
local function multi_open(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local selections = picker:get_multi_selection()

	-- 선택한 파일이 없으면 현재 선택된 파일 열기
	if vim.tbl_isempty(selections) then
		actions.select_default(prompt_bufnr)
		return
	end

	actions.close(prompt_bufnr)

	for _, entry in ipairs(selections) do
		vim.cmd("edit " .. entry.value) -- `edit` 대신 `split`, `vsplit` 등을 사용할 수도 있음
	end
end

-- telescope 설정
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<CR>"] = multi_open,
			},
			n = {
				["<CR>"] = multi_open,
			},
		},
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			height = 0.8,
			prompt_position = "top",
		},
	},
})

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

-- nvim-tree 설정
-- 플로팅 설정
require("nvim-tree").setup({
	view = {
		float = {
			enable = true,
		},
	},
})

require("mason").setup({
  ui = {
    border = "rounded",
  }
})

require("which-key").setup({
	preset = "modern",
})

require("CopilotChat").setup({})
