local M = {}

M.git_grep = {
  cmd = "git grep --ignore-case --extended-regexp --line-number --column --color=always --untracked",
  winopts = { title = " Git Grep " },
  fn_transform_cmd = function(query, cmd, _)
    local search_query, glob_str = query:match("(.-)%s-%-%-(.*)")
    if not glob_str then
      return
    end
    local new_cmd = string.format("%s %s %s", cmd, vim.fn.shellescape(search_query), glob_str)
    return new_cmd, search_query
  end,
}

---Overrides the default options with user-provided options.
---@param user_options table
function M.setup(user_options)
  M.git_grep = user_options.git_grep or M.git_grep
end

return M
