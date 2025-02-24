local dap = require("dap")
local wk = require("which-key")
local dapui = require("dapui")

-- python 어댑터 설정
dap.adapters.python = {
	type = "executable",
	command = require("user").venv_dir(),
	args = { "-m", "debugpy.adapter" },
}

-- python 디버깅 구성
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
	},
}

-- codelldb 어댑터 설정
dap.adapters.codelldb = function(callback, config)
	local port = config.port or 13000 -- 기본 포트 지정
	callback({
		type = "server",
		host = config.host or "127.0.0.1",
		port = port,
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
			args = { "--port", tostring(port) },
		},
	})
end

-- C,C++,Rust 디버깅 구성
dap.configurations.c = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

-- .vscode/launch.json 참고
require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp", "rust" } })

-- 단축키 매핑
wk.add({
	{ "<leader>d", group = "debug" },
	{
		"<leader>dC",
		function()
			dap.set_breakpoint(vim.fn.input("[Condition] > "))
		end,
		desc = "Conditional Breakpoint",
	},
	{ "<leader>dt", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
	{ "<leader>dc", dap.continue, desc = "Continue" },
	{ "<leader>dp", dap.pause, desc = "Pause" },
	{
		"<leader>dd",
		function()
			dap.disconnect({ terminateDebuggee = true })
		end,
		desc = "Disconnect",
	},
	{ "<leader>db", dap.step_back, desc = "Step Back" },
	{ "<leader>di", dap.step_into, desc = "Step Into" },
	{ "<leader>do", dap.step_over, desc = "Step Over" },
	{ "<leader>dO", dap.step_out, desc = "Step Out" },
	{ "<leader>dx", dap.terminate, desc = "Terminate" },
	{ "<leader>dq", dap.close, desc = "Quit" },
	{ "<leader>dr", dap.run_to_cursor, desc = "Run to Cursor" },
	{ "<leader>dR", dap.repl.open, desc = "Open REPL" },
	{ "<leader>dg", dap.session, desc = "Get Session" },
	{
		"<leader>dh",
		function()
			require("dap.ui.widgets").hover()
		end,
		desc = "Hover Variables",
	},
	{
		"<leader>ds",
		function()
			require("dap.ui.widgets").scopes()
		end,
		desc = "Scopes",
	},
	{ "<leader>du", dapui.toggle, desc = "Toggle UI" },
	{ "<leader>de", dapui.eval, desc = "Evaluate" },
	{
		"<leader>dE",
		function()
			dapui.eval(vim.fn.input("[Expression] > "))
		end,
		desc = "Evaluate Input",
	},
}, { mode = "n" })

require("nvim-dap-virtual-text").setup({
	commented = true,
})

-- dapui 기본 설정
dapui.setup({
	expand_lines = true,
	icons = { expanded = "", collapsed = "", circular = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = { "repl" },
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		max_height = 0.9,
		max_width = 0.5, -- Floats will be treated as percentage of your screen.
		border = vim.g.border_chars or "single", -- Border style. Can be 'single', 'double' or 'rounded'
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})

-- icon 설정
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "󰁕", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DiagnosticsSignInfo",
	linehl = "DiagnosticUnderlineInfo",
	numhl = "DiagnosticsSignInfo",
})

-- DAP 이벤트와 UI 연동
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- virtual text
require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,
	only_first_definition = true,
	all_references = false,
	clear_on_continue = false,
	display_callback = function(variable, buf, stackframe, node, options)
		if options.virt_text_pos == "inline" then
			return " = " .. variable.value:gsub("%s+", " ")
		else
			return variable.name .. " = " .. variable.value:gsub("%s+", " ")
		end
	end,

	virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

	all_frames = false,
	virt_lines = false,
	virt_text_win_col = nil,
})
