local M = {}
local function multipleToString(...)
    local result = ""
    local argumentsArray = {...}
    local size = #argumentsArray

    for i = 1, size do
        local current = argumentsArray[i]
        local currentString = nil

        if type(current) == "string" then
            currentString = current
        elseif current == nil then
            currentString = "nil"
        else
            currentString = vim.inspect(current)
        end
        result = result .. currentString .. " "
    end
    return string.sub(result, 1, string.len(result)-1)
end
function M.print(...)
    vim.api.nvim_echo({ { multipleToString(...) } }, true, {})
end

return M
