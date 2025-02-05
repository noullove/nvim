require("nvchad.mappings")

-- 변수 설정
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- IME 설정 (입력모드가 아닐 경우 영문설정)
-- im-select 설치 필요
autocmd("ModeChanged", {
	callback = function()
		vim.fn.system("im-select com.apple.keylayout.ABC")
	end,
})

-- 마지막 커서 포지션 로드
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line > 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

-- inlay 힌트 설정
autocmd("LspAttach", {
	desc = "Enable inlay hints",
	callback = function(event)
		local id = vim.tbl_get(event, "data", "client_id")
		local client = id and vim.lsp.get_client_by_id(id)
		if client == nil or not client.supports_method("textDocument/inlayHint") then
			return
		end

		vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
	end,
})

-- 도움말 창은 항상 오른쪽 창 분할로 표시
autocmd("BufWinEnter", {
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "help" then
			vim.cmd("wincmd L")
		end
	end,
})

-- 사용자 키 맵핑
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>cd", require("telescope").extensions.zoxide.list, { desc = "Telescope zoxide list" })
map("n", "<leader>tm", require("telescope").extensions.file_browser.file_browser, { desc = "Telescope file manager" })
map("n", "<leader>mv", function()
	require("render-markdown").toggle()
end, { desc = "Markdown Preview" })

-- zen mode
map("n", "<leader>td", function()
	require("twilight").toggle()
end, { desc = "Dimming" })

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
	require("menu").open("default")
end, {})

-- volt menu
-- mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
	require("menu.utils").delete_old_menus()

	vim.cmd.exec('"normal! \\<RightMouse>"')

	-- clicked buf
	local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
	local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

	require("menu").open(options, { mouse = true })
end, {})

map({ "n", "v" }, "<leader>cq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
	end
end, { desc = "CopilotChat - Quick chat" })
