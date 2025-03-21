return {
    sources = {
        {
            { name = "nvim_lsp" },
            { name = "luasnip" },
        },
        {
            { name = "buffer" }
        }
    },
    icons = {
        "",
        Text = "",
        Variable = "",
        Function = "󰡱",
        Snippet = "",
        Field = "",
        Method = "",
        Keyword = "",
        Class = "",
        Module = "󱒌",
        Interface = "",
        Value = "",
        Constant = ""
    },
    getWindow = function(cmp)
        return {
            col_offset = -3,
            completion = cmp.config.window.bordered(
                {
                    border = "shadow",
                    scrollbar = false
                }
            ),
            documentation = { max_height = 7 }
        }
    end
}
