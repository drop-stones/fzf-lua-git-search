local config = require("fzf-lua-git-search.config")

local M = {}

---Initializes the plugin with user-provided options.
---@param user_options? table
function M.setup(user_options)
  config.setup(user_options or {})
end

return M
