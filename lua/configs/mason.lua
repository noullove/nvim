dofile(vim.g.base46_cache .. "mason")

return {
	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
		border = "none",
	},

	max_concurrent_installers = 10,
}
