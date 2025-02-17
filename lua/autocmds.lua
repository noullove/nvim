require("nvchad.autocmds")

-- 변수 설정
local autocmd = vim.api.nvim_create_autocmd
local user_command = vim.api.nvim_create_user_command

-- Only replace cmds, not search; only replace the first instance
local function cmd_abbrev(abbrev, expansion)
  local cmd = 'cabbr ' .. abbrev .. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "' .. expansion .. '" : "' .. abbrev .. '")<CR>'
  vim.cmd(cmd)
end

-- Redirect `:h` to `:Help`
cmd_abbrev('h', 'Help')

-- 사용자 Help 명령어 생성
user_command(
  'Help',
  function(opts)
    local help_topic = opts.args

    -- 도움말 항목이 존재하는지 확인
    local success = pcall(vim.cmd, "help " .. help_topic)

    if not success then
      vim.notify("Help topic not found: " .. help_topic, vim.log.levels.ERROR)
      return
    end

    require('snacks').win({
      width = 0.6,
      height = 0.6,
      border = "rounded",
      wo = {
        spell = false,
        wrap = false,
        signcolumn = "yes",
        statuscolumn = " ",
        conceallevel = 3,
      },
      on_win = function()
        vim.cmd('setlocal buftype=help') -- 버퍼를 help 타입으로 설정
        vim.cmd('help ' .. help_topic) -- 도움말 표시
      end,
    })
  end,
  { nargs = 1 }  -- 하나의 인수를 받도록 설정
)

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

-- lsp 관련 inlay 힌트 및 diagnostics floating 설정 
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable inlay hints and floating diagnostics on CursorHold",
  callback = function(event)
    local id = vim.tbl_get(event, "data", "client_id")
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil or not client.supports_method("textDocument/inlayHint") then
      return
    end

    -- Inlay Hint 활성화
    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

    -- CursorHold 이벤트에서 Floating Diagnostics 자동 표시
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = event.buf, -- 해당 버퍼에서만 동작
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
    })
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

-- 창이 열릴 때 CursorLine을 Visual과 동일하게 링크
autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "nofile" then
      -- nofile 창에서만 CursorLine을 Visual로 링크
      vim.api.nvim_command("hi! link CursorLine Visual")
    end
  end,
})

-- 종료시 prompt, nofile buffer 삭제 (avante, timerly 등)
autocmd("QuitPre", {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "prompt" or vim.bo[buf].buftype == "nofile" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})
