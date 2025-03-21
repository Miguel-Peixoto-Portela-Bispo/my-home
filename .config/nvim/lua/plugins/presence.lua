return {
	"IogaMaster/neocord",
	event = "VeryLazy",
	config = function()
		local madeSetup = false

		vim.api.nvim_create_user_command("SetPresence", function()
			if not madeSetup then
				require("neocord").setup({
					logo = "auto",
					logo_tooltip = "Neovim",
					main_image = "language",
					log_level = "warn",
					debounce_timeout = 10,
					blacklist = {},
					file_assets = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
					show_time = true,
					global_timer = false,
					-- Rich Presence text options
					editing_text = "Editing %s",
					file_explorer_text = "Browsing %s",
					git_commit_text = "Committing changes",
					plugin_manager_text = "Managing plugins",
					reading_text = "Reading %s",
					workspace_text = "Working on %s",
					line_number_text = "Line %s out of %s",
					terminal_text = "Using Terminal",
				})
                madeSetup = true
			else
				print("Rich presence is already set upped")
			end
		end, {})
	end,
}
