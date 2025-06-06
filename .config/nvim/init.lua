local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("general.editor-options")
require("general.keymaps")
require("lazy").setup({
    { import = "plugins" },
    {
        {
            "jay-babu/mason-null-ls.nvim",
            event = { "BufReadPre", "BufNewFile" },
            dependencies = {
                "williamboman/mason.nvim",
                "nvimtools/none-ls.nvim",
            },
            config = function()
                require("mason-null-ls").setup({
                    ensure_installed = require("data.formatting").toInstall,
                    automatic_installation = false,
                    handlers = {},
                })
                require("null-ls").setup()

                vim.keymap.set({ "n", "i" }, "<C-f>", vim.lsp.buf.format, {})
            end,
        },
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio",
            },
            config = function()
                local debugData = require("data.debug")
                local dapui = require("dapui")
                local dap = require("dap")

                dapui.setup()
                for i = 1, #debugData.targets do
                    local name = debugData.targets[i].name

                    if debugData.targets[i].setup == true then
                        local adapter = debugData.getAdapter(name)

                        dap.adapters[name] = adapter
                    end
                end
                dap.listeners.before.attach.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.launch.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated.dapui_config = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited.dapui_config = function()
                    dapui.close()
                end
                vim.keymap.set("n", "<F5>", function()
                    dap.continue()
                end)
                vim.keymap.set("n", "<F10>", function()
                    dap.step_over()
                end)
                vim.keymap.set("n", "<F11>", function()
                    dap.step_into()
                end)
                vim.keymap.set("n", "<F12>", function()
                    dap.step_out()
                end)
                vim.keymap.set("n", "<Leader>b", function()
                    dap.toggle_breakpoint()
                end)
                vim.keymap.set("n", "<leader>cd", function()
                    dapui.toggle()
                end)
            end,
        },
        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                local lspData = require("data.lsp")
                local names = {}

                for _, v in pairs(lspData.targets) do
                    if v.toInstall then
                        table.insert(names, v.name)
                    end
                end

                require("mason-lspconfig").setup({
                    ensure_installed = names,
                })
            end,
        },
        {
            "jay-babu/mason-nvim-dap.nvim",
            config = function()
                local debugData = require("data.debug")

                local names = {}

                for _, v in pairs(debugData.targets) do
                    if v.toInstall then
                        table.insert(names, v.name)
                    end
                end
                require("mason-nvim-dap").setup({
                    ensure_installed = names,
                    automatic_setup = true,
                })
            end,
        },
    },
})
