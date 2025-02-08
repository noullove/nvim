require("nvchad.mappings")

-- 변수 설정
local map = vim.keymap.set

-- 사용자 키 맵핑
-- visual block mode
map('n', '<C-v>', '<C-v>', { noremap = true, silent = true })

-- 한글모드 일때도 ESC 로 영문모드로 전환
map("n", "<Esc>", function()
	vim.fn.system("im-select com.apple.keylayout.ABC")
	vim.cmd("noh")
end, { desc = "Clear" })

-- command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp", size = 0.5 }
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp", size = 0.5 }
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", size = 0.5, id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", size = 0.5, id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", float_opts = { row = 0.2, col = 0.2, width = 0.6, height = 0.6 }, id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- lagygit
map({ "n", "t" }, "<A-g>", function()
	require("nvchad.term").toggle({
		pos = "float",
		float_opts = {
			border = "rounded",
			style = "minimal",
			row = 0.05,
			col = 0.1,
			width = 0.8,
			height = 0.8,
		},
		id = "lagygit",
		cmd = "lazygit",
	})
end, { desc = "lazygit toggle" })

-- volt menu
-- Keyboard users
map("n", "<C-t>", function()
	require("menu").open("default", { border = true })
end, {})

-- volt menu
-- mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
	require("menu.utils").delete_old_menus()

	vim.cmd.exec('"normal! \\<RightMouse>"')

	-- clicked buf
	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
	local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

	require("me nu").open(options, { mouse = true, border = true })
end, {})

-- copilot chat
map({ "n", "v" }, "<leader>cq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
	end
end, { desc = "CopilotChat - Quick chat" })
