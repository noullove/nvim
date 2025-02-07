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

-- Telescope
map("n", "<leader>cd", require("telescope").extensions.zoxide.list, { desc = "Telescope zoxide list" })
map("n", "<leader>tm", require("telescope").extensions.file_browser.file_browser, { desc = "Telescope file manager" })

-- markdown preview
map("n", "<leader>mv", function()
	require("render-markdown").toggle()
end, { desc = "Markdown Preview" })

-- timerly
map("n", "<A-t>", function()
  require("timerly").toggle()
end, { desc = "Timerly" })

-- showkeys
map("n", "<leader>sk", function()
  require("showkeys").toggle()
end, { desc = "Show keys" })

-- dimming
map("n", "<leader>td", function()
	require("twilight").toggle()
end, { desc = "Dimming" })
-- zen mode
map("n", "<leader>tz", function()
	require("zen-mode").toggle({
		window = {
			width = 0.85, -- width will be 85% of the editor width
		},
	})
end, { desc = "Zen Mode" })

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

	require("menu").open(options, { mouse = true, border = true })
end, {})

-- copilot chat
map({ "n", "v" }, "<leader>cq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
	end
end, { desc = "CopilotChat - Quick chat" })
