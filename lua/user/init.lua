local M = {}

function M.venv_dir()
	local current_file = vim.api.nvim_buf_get_name(0) or ""
	local root_dir = require("lspconfig.util").root_pattern(".git", "pyproject.toml", "setup.py")(current_file)

	-- root_pattern()이 nil이면 기본값으로 CWD 사용
	if root_dir == nil or root_dir == "" then
		root_dir = vim.fn.getcwd()
	end

	local venv = root_dir .. "/.venv/bin/python"

	-- 실행 가능한 Python인지 확인
	if vim.fn.executable(venv) == 1 then
		return venv
	end

	return vim.fn.exepath("python3") -- 기본 Python3 fallback
end

return M
