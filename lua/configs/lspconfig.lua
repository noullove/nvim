local M = {}
local map = vim.keymap.set

local servers = {
	bashls = {
		filetypes = { "sh", "zsh" },
	},
	html = {},
	cssls = {},
	clangd = {
		filetypes = { "c", "cc", "cpp", "objc", "objcpp" },
	},
	pyright = {
		before_init = function(_, config)
			config.settings.python.pythonPath = require("user").venv_dir()
		end,
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
				},
			},
		},
	},
	marksman = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
						vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
						vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
						-- vim.fn.stdpath "data" .. "/lazy",
						"${3rd}/luv/library",
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	},
}

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>ra", require("nvchad.lsp.renamer"), opts("NvRenamer"))

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))

	-- lsp diagnostics 설정
	vim.diagnostic.config({
		virtual_text = false, -- 가상 텍스트(코드 옆에 오류 메시지) 비활성화
		severity_sort = true,
		float = {
			border = "rounded",
		},
	})
end

-- disable semanticTokens
M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.defaults = function()
	dofile(vim.g.base46_cache .. "lsp")
	require("nvchad.lsp").diagnostic_config()

	for name, opts in pairs(servers) do
		opts.on_init = M.on_init
		opts.on_attach = M.on_attach
		opts.capabilities = M.capabilities

		require("lspconfig")[name].setup(opts)
	end
end

return M
