local M = {}

M.opts = {
	bigfile = { enabled = true },
	dashboard = {
		width = 40,
		sections = function()
			local header = [[
  ████ ██████           █████      ██                    
 ███████████             █████                            
 █████████ ███████████████████ ███   ███████████  
█████████  ███    █████████████ █████ ██████████████  
█████████ ██████████ █████████ █████ █████ ████ █████  
███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]]
			local function greeting()
				local hour = tonumber(vim.fn.strftime("%H"))
				-- [02:00, 10:00) - morning, [10:00, 18:00) - day, [18:00, 02:00) - evening
				local part_id = math.floor((hour + 6) / 8) + 1
				local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
				local username = os.getenv("USER") or os.getenv("USERNAME") or "user"
				return ("Good %s, %s"):format(day_part, username)
			end
      -- stylua: ignore
      return {
        { padding = 0, text = { header, hl = "header" } },
        { align = "center", desc = greeting(), padding = 2 },
        { title = "Builtin Actions", indent = 2, padding = 1,
          { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "q", desc = "Quit",            action = ":qa" } },
        { title = "Recent Projects", section = "projects", indent = 2, padding = 1 },
        { title = "Maintenance Actions", indent = 2, padding = 2,
          { icon = " ", key = "c", desc = "Config",      action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
          { icon = "󰒲 ", key = "l", desc = "Lazy",        action = ":Lazy" },
          { icon = "󱁤 ", key = "m", desc = "Mason",       action = ":Mason" },                          },
        { section = "startup" },
      }
		end,
	},
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = {
		enabled = true,
		style = "fancy",
		timeout = 3000,
	},
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	styles = {
		notification = {
			-- wo = { wrap = true } -- Wrap notifications
		},
	},
	images = { enabled = true },
}

M.keys = {
	-- Top Pickers & Explorer
	{
		"<leader><space>",
		function()
			require("snacks").picker.smart()
		end,
		desc = "Smart Find Files",
	},
	{
		"<leader>n",
		function()
			require("snacks").picker.notifications()
		end,
		desc = "Notification History",
	},
	{
		"<leader>e",
		function()
			require("snacks").explorer()
		end,
		desc = "File Explorer",
	},
	-- find
	{
		"<leader>fb",
		function()
			require("snacks").picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<leader>fc",
		function()
			require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "Find Config File",
	},
	{
		"<leader>ff",
		function()
			require("snacks").picker.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fg",
		function()
			require("snacks").picker.git_files()
		end,
		desc = "Find Git Files",
	},
	{
		"<leader>fp",
		function()
			require("snacks").picker.projects()
		end,
		desc = "Projects",
	},
	{
		"<leader>fr",
		function()
			require("snacks").picker.recent()
		end,
		desc = "Recent",
	},
	{
		"<leader>fz",
		function()
			require("snacks").picker.zoxide()
		end,
		desc = "Zoxide",
	},
	-- git
	{
		"<leader>gb",
		function()
			require("snacks").picker.git_branches()
		end,
		desc = "Git Branches",
	},
	{
		"<leader>gl",
		function()
			require("snacks").picker.git_log()
		end,
		desc = "Git Log",
	},
	{
		"<leader>gL",
		function()
			require("snacks").picker.git_log_line()
		end,
		desc = "Git Log Line",
	},
	{
		"<leader>gs",
		function()
			require("snacks").picker.git_status()
		end,
		desc = "Git Status",
	},
	{
		"<leader>gS",
		function()
			require("snacks").picker.git_stash()
		end,
		desc = "Git Stash",
	},
	{
		"<leader>gd",
		function()
			require("snacks").picker.git_diff()
		end,
		desc = "Git Diff (Hunks)",
	},
	{
		"<leader>gf",
		function()
			require("snacks").picker.git_log_file()
		end,
		desc = "Git Log File",
	},
	-- Grep
	{
		"<leader>sb",
		function()
			require("snacks").picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<leader>sB",
		function()
			require("snacks").picker.grep_buffers()
		end,
		desc = "Grep Open Buffers",
	},
	{
		"<leader>sg",
		function()
			require("snacks").picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>sw",
		function()
			require("snacks").picker.grep_word()
		end,
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	-- search
	{
		'<leader>s"',
		function()
			require("snacks").picker.registers()
		end,
		desc = "Registers",
	},
	{
		"<leader>s/",
		function()
			require("snacks").picker.search_history()
		end,
		desc = "Search History",
	},
	{
		"<leader>sa",
		function()
			require("snacks").picker.autocmds()
		end,
		desc = "Autocmds",
	},
	{
		"<leader>sc",
		function()
			require("snacks").picker.command_history()
		end,
		desc = "Command History",
	},
	{
		"<leader>sC",
		function()
			require("snacks").picker.commands()
		end,
		desc = "Commands",
	},
	{
		"<leader>sd",
		function()
			require("snacks").picker.diagnostics()
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>sD",
		function()
			require("snacks").picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
	{
		"<leader>sh",
		function()
			require("snacks").picker.help()
		end,
		desc = "Help Pages",
	},
	{
		"<leader>sH",
		function()
			require("snacks").picker.highlights()
		end,
		desc = "Highlights",
	},
	{
		"<leader>si",
		function()
			require("snacks").picker.icons()
		end,
		desc = "Icons",
	},
	{
		"<leader>sj",
		function()
			require("snacks").picker.jumps()
		end,
		desc = "Jumps",
	},
	{
		"<leader>sk",
		function()
			require("snacks").picker.keymaps()
		end,
		desc = "Keymaps",
	},
	{
		"<leader>sl",
		function()
			require("snacks").picker.loclist()
		end,
		desc = "Location List",
	},
	{
		"<leader>sm",
		function()
			require("snacks").picker.marks()
		end,
		desc = "Marks",
	},
	{
		"<leader>sM",
		function()
			require("snacks").picker.man()
		end,
		desc = "Man Pages",
	},
	{
		"<leader>sp",
		function()
			require("snacks").picker.lazy()
		end,
		desc = "Search for Plugin Spec",
	},
	{
		"<leader>sq",
		function()
			require("snacks").picker.qflist()
		end,
		desc = "Quickfix List",
	},
	{
		"<leader>sr",
		function()
			require("snacks").picker.resume()
		end,
		desc = "Resume",
	},
	{
		"<leader>su",
		function()
			require("snacks").picker.undo()
		end,
		desc = "Undo History",
	},
	{
		"<leader>uC",
		function()
			require("snacks").picker.colorschemes()
		end,
		desc = "Colorschemes",
	},
	-- LSP
	{
		"gd",
		function()
			require("snacks").picker.lsp_definitions()
		end,
		desc = "Goto Definition",
	},
	{
		"gD",
		function()
			require("snacks").picker.lsp_declarations()
		end,
		desc = "Goto Declaration",
	},
	{
		"gr",
		function()
			require("snacks").picker.lsp_references()
		end,
		nowait = true,
		desc = "References",
	},
	{
		"gI",
		function()
			require("snacks").picker.lsp_implementations()
		end,
		desc = "Goto Implementation",
	},
	{
		"gy",
		function()
			require("snacks").picker.lsp_type_definitions()
		end,
		desc = "Goto Type Definition",
	},
	{
		"<leader>ss",
		function()
			require("snacks").picker.lsp_symbols()
		end,
		desc = "LSP Symbols",
	},
	{
		"<leader>sS",
		function()
			require("snacks").picker.lsp_workspace_symbols()
		end,
		desc = "LSP Workspace Symbols",
	},
	-- Other
	{
		"<leader>z",
		function()
			require("snacks").zen()
		end,
		desc = "Toggle Zen Mode",
	},
	{
		"<leader>Z",
		function()
			require("snacks").zen.zoom()
		end,
		desc = "Toggle Zoom",
	},
	{
		"<leader>.",
		function()
			require("snacks").scratch()
		end,
		desc = "Toggle Scratch Buffer",
	},
	{
		"<leader>S",
		function()
			require("snacks").scratch.select()
		end,
		desc = "Select Scratch Buffer",
	},
	{
		"<leader>bd",
		function()
			require("snacks").bufdelete()
		end,
		desc = "Delete Buffer",
	},
	{
		"<leader>cR",
		function()
			require("snacks").rename.rename_file()
		end,
		desc = "Rename File",
	},
	{
		"<leader>gB",
		function()
			require("snacks").gitbrowse()
		end,
		desc = "Git Browse",
		mode = { "n", "v" },
	},
	{
		"<leader>gg",
		function()
			require("snacks").lazygit()
		end,
		desc = "Lazygit",
	},
	{
		"<leader>un",
		function()
			require("snacks").notifier.hide()
		end,
		desc = "Dismiss All Notifications",
	},
	{
		"<c-/>",
		function()
			require("snacks").terminal()
		end,
		desc = "Toggle Terminal",
	},
	{
		"]]",
		function()
			require("snacks").words.jump(vim.v.count1)
		end,
		desc = "Next Reference",
		mode = { "n", "t" },
	},
	{
		"[[",
		function()
			require("snacks").words.jump(-vim.v.count1)
		end,
		desc = "Prev Reference",
		mode = { "n", "t" },
	},
}

M.init = function()
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			-- Setup some globals for debugging (lazy-loaded)
			-- _G.dd = function(...)
			--   require('snacks').debug.inspect(...)
			-- end
			-- _G.bt = function()
			--   require('snacks').debug.backtrace()
			-- end
			-- vim.print = _G.dd -- Override print to use snacks for `:=` command

			-- Create some toggle mappings
			require("snacks").toggle.option("spell", { name = "Spelling" }):map("<leader>us")
			require("snacks").toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
			require("snacks").toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
			require("snacks").toggle.diagnostics():map("<leader>ud")
			require("snacks").toggle.line_number():map("<leader>ul")
			require("snacks").toggle
				.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
				:map("<leader>uc")
			require("snacks").toggle.treesitter():map("<leader>uT")
			require("snacks").toggle
				.option("background", { off = "light", on = "dark", name = "Dark Background" })
				:map("<leader>ub")
			require("snacks").toggle.inlay_hints():map("<leader>uh")
			require("snacks").toggle.indent():map("<leader>ug")
			require("snacks").toggle.dim():map("<leader>uD")
		end,
	})
end

return M
