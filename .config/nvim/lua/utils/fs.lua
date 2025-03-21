local M = {}
function M.searchDirectoryUp(list, path)
    return vim.fs.dirname(
    vim.fs.find(list, { upward = true , path = path })[1]
    )
end
function M.scanDirectory(directory)
    local FILE_PATHS = vim.split(
        vim.fn.glob(directory .. "/*"),
        '\n', {trimempty=true}
    )
    local result = {}

    for i, path in pairs(FILE_PATHS) do
        result[i] = path:gsub("(.*)/(.*)", "%2")
    end
    return result
end
function M.directoryContains(...)
    local searchingFor = {...}

    return function(directory)
        local content = M.scanDirectory(directory)
        local set = {}

        for _, v in ipairs(content) do
            set[v] = true
        end
        for _, v in ipairs(searchingFor) do
            if set[v] then return true end
        end
        return false
    end
end
function M.isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end
function M.currentBufferDirectory()
    return vim.fn.getcwd()
end

return M
