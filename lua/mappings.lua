local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
	require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
	require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
map("n", "<leader>h", function()
	require("nvchad.term").new({ pos = "sp" })
end, { desc = "terminal new horizontal term" })

map("n", "<leader>v", function()
	require("nvchad.term").new({ pos = "vsp" })
end, { desc = "terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
	require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
	require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
	require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- 사용자 키 맵핑
-- 전체선택
map("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- 한글모드 일때도 ESC 로 영문모드로 전환
map("n", "<Esc>", function()
	vim.fn.system("im-select com.apple.keylayout.ABC")
	vim.cmd("noh")
end, { desc = "Clear" })

-- command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- theme picker
map("n", "<leader>th", function()
	require("nvchad.themes").open()
end, { desc = "theme picker" })

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

-- pandoc
map("n", "<leader>p", [[:lua PandocConvert()<CR>]], { desc = "pandoc convert", noremap = true, silent = true })

function PandocConvert()
	if vim.bo.filetype ~= "markdown" then
		vim.notify(
			"PandocConvert can only be used with markdown files",
			vim.log.levels.WARN,
			{ title = "Pandoc Convert" }
		)
		return
	end

	local filename = vim.fn.expand("%:p")
	local filedir = vim.fn.expand("%:p:h")
	local output = vim.fn.expand("$HOME") .. "/Downloads/" .. vim.fn.expand("%:t:r") .. ".pdf"

	-- Change the working directory to the file's directory
	vim.fn.chdir(filedir)

	-- Remove the notification if you don't want it
	vim.notify(
		"Converting " .. string.format("%q", filename) .. " to " .. string.format("%q", output),
		vim.log.levels.INFO,
		{ title = "Pandoc Convert" }
	)

	local command = string.format(
		'pandoc --template=$HOME/.config/pandoc/templates/document.tex --lua-filter=$HOME/.config/pandoc/filters/parse-module.lua --lua-filter=$HOME/.config/pandoc/filters/table.lua --pdf-engine=xelatex --pdf-engine-opt="-shell-escape" --pdf-engine-opt="-output-directory=$TMPDIR" --metadata=graphicspath:$HOME/.config/pandoc/templates/assets/ --metadata=plantuml_path:"$HOME/.config/pandoc/filters/plantuml.jar" --metadata=mainfont:NanumGothic --metadata=monofont:D2Coding --metadata=toc:true --metadata=toc_depth:3 --metadata=number_sections:false --from=markdown+hard_line_breaks -o %q %q',
		output,
		filename
	)

	-- Use vim.fn.jobstart for non-blocking execution
	-- 테이블을 사용하여 출력 저장
	local stdout_table = {}
	local stderr_table = {}

	vim.fn.jobstart(command, {
		on_stdout = function(_, data)
			if data then
				for _, line in ipairs(data) do
					if type(line) == "string" and line ~= "" then
						table.insert(stdout_table, line)
					end
				end
			end
		end,
		on_stderr = function(_, data)
			if data then
				for _, line in ipairs(data) do
					if type(line) == "string" and line ~= "" then
						table.insert(stderr_table, line)
					end
				end
			end
		end,
		on_exit = function(_, code)
			-- 테이블을 문자열로 변환
			local stdout_str = table.concat(stdout_table, "")
			local stderr_str = table.concat(stderr_table, "")

			if stdout_str ~= "" then
				vim.notify(stdout_str, vim.log.levels.INFO, { title = "Pandoc Convert" })
			end
			if stderr_str ~= "" then
				vim.notify(stderr_str, vim.log.levels.ERROR, { title = "Pandoc Convert" })
			end

			if code == 0 then
				vim.notify(
					"Conversion successful: " .. string.format("%q", output),
					vim.log.levels.INFO,
					{ title = "Pandoc Convert" }
				)
				vim.cmd("silent !open " .. string.format("%q", output))
			else
				vim.notify(
					"Conversion failed with exit code: " .. code,
					vim.log.levels.ERROR,
					{ title = "Pandoc Convert" }
				)
			end
		end,
	})
end

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
				require("snacks.image.doc").attach(vim.api.nvim_get_current_buf())
			else
				require("render-markdown").disable()
			end
		end,
	})
	:map("<leader>um")

-- showkeys 설정
require("snacks").toggle
	.new({
		id = "showkeys",
		name = "Show Keys",
		get = function()
			return require("showkeys.state").visible
		end,
		set = function(state)
			if state then
				require("showkeys").open()
			else
				require("showkeys").close()
			end
		end,
	})
	:map("<leader>uk")
