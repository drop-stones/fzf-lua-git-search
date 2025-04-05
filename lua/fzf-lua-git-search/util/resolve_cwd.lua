---Resolve the `cwd` (current working directory) based on the `root` option.
---@param options? table
---@return table
local function resolve_cwd(options)
  options = options or {}
  if options.root ~= nil then
    if options.root then
      options.cwd = require("project_nvim.project").get_project_root()
    else
      options.cwd = vim.fn.getcwd()
    end
    options.root = nil
  end
  return options
end

return resolve_cwd
