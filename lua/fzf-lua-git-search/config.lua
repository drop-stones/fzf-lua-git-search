local options = require("fzf-lua-git-search.options")
local util = require("fzf-lua-git-search.util")

local M = {}

M.git_grep = {
  cmd = "git grep --ignore-case --extended-regexp --line-number --column --color=always --untracked",
  winopts = { title = " Git Grep " },
  fn_transform_cmd = function(query, cmd, _)
    -- ensure grep contexts are available during runtime
    vim.opt.rtp:append(vim.env.FZF_LUA_GIT_SEARCH)
    return require("fzf-lua-git-search").transform(query, cmd)
  end,
}

---Overrides the default options with user-provided options.
---@param user_options table
function M.setup(user_options)
  M.git_grep = vim.tbl_extend("force", M.git_grep, user_options.git_grep)

  -- Set plugin root path for access from headless child processes
  vim.env.FZF_LUA_GIT_SEARCH = util.get_plugin_root()

  -- Initialize options for fn_transform_cmd()
  options.init()
end

return M
