
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local treesitterData = require("data.treesitter")
        local configs = require("nvim-treesitter.configs")

        configs.setup(
            {
                auto_install = true,
                ensure_installed = treesitterData.NAMES,
                sync_install = false,
                highlight = {
                    enable = true
                },
                indent = {
                    enable = true,
                    disable = {
                        "java", "html", "javascript", "typescript"
                    }
                }
            }
        )
    end
}
