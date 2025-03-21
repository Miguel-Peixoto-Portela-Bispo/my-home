return {
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "mfussenegger/nvim-jdtls" },
	{
		"scalameta/nvim-metals",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspData = require("data.lsp")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local handlers = { default = require("lspconfig") }

			for _, targetData in ipairs(lspData.targets) do
				local setupData = lspData.getSetupData(targetData.name)
				local setup = function()
					local capable = cmp_nvim_lsp.default_capabilities()
					local configuration = vim.tbl_deep_extend("keep", setupData.configuration or {}, capable)

					if targetData.setup ~= nil then
						return targetData.setup(configuration)
					end
					handlers.default[targetData.name].setup(configuration)
				end

				if not setupData.lazy then
					setup()
				else
					local autocmdObject = {
						pattern = setupData.fileTypes or "*",
						callback = function()
							setup()
							vim.cmd("LspStart")
						end,
                        unpack(setupData.autocmdObject or {})
					}

					if setupData.group then
						autocmdObject.group = setupData.group
					end
					vim.api.nvim_create_autocmd("FileType", autocmdObject)
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				underline = true,
				severity_sort = true,
			})

			vim.keymap.set("n", "<C-x>", function()
				vim.diagnostic.open_float(nil, { focus = false })
			end)
			vim.keymap.set("n", "H", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "S", vim.lsp.buf.signature_help, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "sdc", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "sdf", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "sim", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "rnm", vim.lsp.buf.rename, {})
		end,
	},
}
