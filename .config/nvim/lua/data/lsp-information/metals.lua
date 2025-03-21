return {
    lazy = true,
    fileTypes = { "java", "scala", "sbt" },
	autocmdObject = {
		group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
	},
	configuration = {
		on_attach = function(_, _) end,
	},
}
