local config = require("fzf-lua-git-search.config")
local picker = require("fzf-lua-git-search.picker")
local transform = require("fzf-lua-git-search.transform")

local M = {}

---Initializes the plugin with user-provided options.
---@param user_options? table
function M.setup(user_options)
  config.setup(user_options or {})
end

M.files = picker.files
M.grep = picker.grep
M.live_grep = picker.live_grep
M.grep_cword = picker.grep_cword
M.grep_cWORD = picker.grep_cWORD
M.grep_visual = picker.grep_visual

M.transform = transform

return M
