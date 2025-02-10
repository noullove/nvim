require("nvchad.mappings")

-- 변수 설정
local map = vim.keymap.set
local unmap = vim.keymap.del

-- 플러그인 키 맵핑 삭제
-- nvim-tree
unmap("n", "<C-n>")
unmap("n", "<leader>e")
unmap("n", "<leader>n")

-- telescope
unmap("n", "<leader>ma")
unmap("n", "<leader>fh")
unmap("n", "<leader>fw")
unmap("n", "<leader>fb")
unmap("n", "<leader>gt")
unmap("n", "<leader>ff")
unmap("n", "<leader>pt")
unmap("n", "<leader>fo")
unmap("n", "<leader>cm")
unmap("n", "<leader>fz")
unmap("n", "<leader>th")
unmap("n", "<leader>fa")

-- 사용자 키 맵핑
-- visual block mode
map('n', '<C-v>', '<C-v>', { noremap = true, silent = true })
map({ 'n', 'v' }, '<C-a>', 'ggVG', { noremap = true, silent = true })

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

-- snacks
map("n", "<leader>n", function() require('snacks').picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>e", function() require('snacks').explorer() end, { desc = "File Explorer" })
map("n", "<leader>fb", function() require('snacks').picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>ff", function() require('snacks').picker.files() end, { desc = "Find Files" })
map("n", "<leader>fz", function() require('snacks').picker.zoxide() end, { desc = "Zoxide" })
