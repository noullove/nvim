local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
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

-- floating window 숨기기 (lazygit 등)
autocmd("WinLeave", {
	callback = function()
		local win_id = vim.api.nvim_get_current_win()
		local config = vim.api.nvim_win_get_config(win_id)

		-- Floating window인지 확인
		if config.relative ~= "" then
			local buf_id = vim.api.nvim_win_get_buf(win_id)
			local buftype = vim.bo[buf_id].buftype

			-- floating 윈도우 숨김
			if buftype == "terminal" or buftype == "help" then
				vim.api.nvim_win_hide(win_id)
			end
		end
	end,
})

-- cursorline 설정
autocmd("FileType", {
	pattern = { "trouble", "Outline" },
	callback = function()
		vim.api.nvim_command("hi! link CursorLine Visual")

		if vim.bo.filetype == "Outline" then
			vim.defer_fn(function()
				vim.wo.cursorline = true
				vim.wo.cursorlineopt = "both"
			end, 50) -- 50ms 지연 후 실행
		end
	end,
})

-- lsp 관련 설정
autocmd("LspAttach", {
	desc = "lsp settings",
	callback = function()
		-- lsp diagnostics 설정
		vim.diagnostic.config({
			virtual_text = false, -- 가상 텍스트(코드 옆에 오류 메시지) 비활성화
		})
		-- updatetime을 2000ms(2초)로 설정
		vim.opt.updatetime = 2000
		-- CursorHold 이벤트에서 floating diagnostics 자동 표시
		autocmd("CursorHold", {
			callback = function()
				require("zendiagram").open()
			end,
		})
	end,
})
