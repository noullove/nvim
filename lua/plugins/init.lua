return {
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

	-- dimming / zen mode
  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>td", "<cmd>Twilight<cr>", desc = "Dimming" },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 0.85, -- width will be 85% of the editor width
      },
    },
    keys = {
      { "<leader>tz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
	-- telescope file manager
	-- telescope zoxide
  {
	  "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      { "<leader>tm", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
    },
  },
  {
    "jvgrootveld/telescope-zoxide",
    keys = {
      { "<leader>cd", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
    },
  },

	-- markdown rendering
	{
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
		requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- if you prefer nvim-web-devicons
    ft = { "markdown", "copilot-chat" },
    cmd = "RenderMarkdown",
    keys = {
      { "<leader>mv", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown Preview" },
    },
	},

  -- copilot
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = { "github/copilot.vim" },
    opts = {},
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
      { "<leader>sk", "<cmd>ShowkeysToggle<cr>", desc = "Show keys" },
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
