return {
  { "nvim-tree/nvim-tree.lua", enabled = false },
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("configs.cmp")
		end,
	},

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
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
        }
      }
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() require('snacks').picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() require('snacks').picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() require('snacks').picker.grep() end, desc = "Grep" },
      { "<leader>:", function() require('snacks').picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() require('snacks').picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() require('snacks').explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fb", function() require('snacks').picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() require('snacks').picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() require('snacks').picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() require('snacks').picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() require('snacks').picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() require('snacks').picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gb", function() require('snacks').picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() require('snacks').picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() require('snacks').picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() require('snacks').picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() require('snacks').picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() require('snacks').picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() require('snacks').picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() require('snacks').picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() require('snacks').picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() require('snacks').picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() require('snacks').picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() require('snacks').picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() require('snacks').picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() require('snacks').picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() require('snacks').picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() require('snacks').picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() require('snacks').picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() require('snacks').picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() require('snacks').picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() require('snacks').picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() require('snacks').picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() require('snacks').picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() require('snacks').picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() require('snacks').picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() require('snacks').picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() require('snacks').picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() require('snacks').picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() require('snacks').picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() require('snacks').picker.resume() end, desc = "Resume" },
      { "<leader>su", function() require('snacks').picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() require('snacks').picker.colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() require('snacks').picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() require('snacks').picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() require('snacks').picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() require('snacks').picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() require('snacks').picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() require('snacks').picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() require('snacks').picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",  function() require('snacks').zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() require('snacks').zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() require('snacks').scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() require('snacks').scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>bd", function() require('snacks').bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() require('snacks').rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() require('snacks').gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gg", function() require('snacks').lazygit() end, desc = "Lazygit" },
      { "<leader>un", function() require('snacks').notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() require('snacks').terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() require('snacks').terminal() end, desc = "which_key_ignore" },
      { "]]",         function() require('snacks').words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() require('snacks').words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          require('snacks').win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
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
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            require('snacks').debug.inspect(...)
          end
          _G.bt = function()
            require('snacks').debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          require('snacks').toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          require('snacks').toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          require('snacks').toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          require('snacks').toggle.diagnostics():map("<leader>ud")
          require('snacks').toggle.line_number():map("<leader>ul")
          require('snacks').toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          require('snacks').toggle.treesitter():map("<leader>uT")
          require('snacks').toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          require('snacks').toggle.inlay_hints():map("<leader>uh")
          require('snacks').toggle.indent():map("<leader>ug")
          require('snacks').toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
    opts = {
      lsp = {
        signature = {
          enabled = true,
          auto_open = { enabled = false },
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
	},

	{
		"folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- markdown rendering
	{
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
		requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
    cmd = "RenderMarkdown",
    keys = {
      { "<leader>mv", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown Preview" },
    },
	},

  -- copilot
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "github/copilot.vim"
    }
  },

  -- showkeys
	{
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
      position = "top-right",
    },
    keys = {
      { "<leader>k", "<cmd>ShowkeysToggle<cr>", desc = "Show keys" },
    },
  },

  -- timerly
	{
    "nvzone/timerly",
    cmd = "TimerlyToggle",
    opts = {
      position = "bottom-right",
    },
    keys = {
      { "<A-t>", "<cmd>TimerlyToggle<cr>", desc = "Timerly" },
    },
  },
}
