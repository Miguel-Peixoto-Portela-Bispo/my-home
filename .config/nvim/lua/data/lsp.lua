local fsUtils = require("utils.fs")
local currentDirectory = (...):match("(.+)%.(.+)") .. "/"
local rootPath = vim.fn.expand("$HOME/.config/nvim")
local lspInformation = {
	locationName = "lsp-information",
	directoryPrefix = rootPath .. "/lua/" .. currentDirectory,
}
local loadFile = function(name)
	local filePath = lspInformation.directoryPrefix .. lspInformation.locationName .. "/" .. name .. ".lua"
	local checkFile = fsUtils.directoryContains(filePath:gsub("(.*)/(.*)", "%2"))
	local existsFile = checkFile(lspInformation.directoryPrefix .. lspInformation.locationName)

	return existsFile and dofile(filePath) or {}
end

return {
	getSetupData = function(name)
		return loadFile(name)
	end,
	targets = {
		{ name = "ruby_lsp" },
		{ name = "solargraph" },
		{ name = "lua_ls", toInstall = true },
		{ name = "ts_ls", toInstall = true },
		{ name = "html", toInstall = true },
		{ name = "cssls", toInstall = true },
		{ name = "bashls", toInstall = true },
		{ name = "lemminx", toInstall = true },
		{ name = "clangd", toInstall = true },
		-- {
		-- 	name = "jdtls",
		-- 	toInstall = true,
		-- 	setup = function(configuration)
		-- 		require("jdtls").start_or_attach(configuration)
		-- 		vim.keymap.set("n", "<Leader>r", function()
		-- 			vim.cmd("JdtUpdateConfig")
		-- 		end, { buffer = true })
		-- 	end,
		-- },
		{
			name = "metals",
			setup = function(configuration)
				local metals = require("metals")
				local bareConfiguration = metals.bare_config()
				local customConfiguration = {
					settings = {
						serverProperties = {
							"-Xss4M",
							"-Xmx2G",
							"-Xms100M",
							"-XX:+UseG1GC",
							"-XX:+UseStringDeduplication",
						},
					},
				}
				local newConfiguration =
					vim.tbl_deep_extend("keep", configuration, bareConfiguration, customConfiguration)

				metals.initialize_or_attach(newConfiguration)
			end,
		},
	},
}
