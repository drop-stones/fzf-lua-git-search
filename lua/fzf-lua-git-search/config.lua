local options = require("fzf-lua-git-search.options")

local M = {}

M.git_grep = {
  cmd = "git grep --ignore-case --extended-regexp --line-number --column --color=always --untracked",
  winopts = { title = " Git Grep " },
  fn_transform_cmd = function(query, cmd, _)
    ---Escape a shell argument, with Windows quoting support
    ---@param shell_arg string
    ---@return string
    local function shellescape(shell_arg)
      if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        return string.format('^"%s^"', shell_arg)
      else
        return string.format("'%s'", shell_arg)
      end
    end

    -- Extract search query and glob string separated by '--'
    local search_query, glob_str = query:match("(.-)%s-%-%-(.*)")

    if not glob_str then
      return -- Fallback to original command if no glob string
    end

    -- Build git-compatible pathspecs, supporting `:(exclude)` for negation
    local pathspecs = {}
    for pathspec in glob_str:gmatch("%S+") do
      if pathspec:sub(1, 1) == "!" then
        -- Convert '!pattern' to git's exclude pathspec
        table.insert(pathspecs, shellescape(":(exclude)" .. pathspec:sub(2)))
      else
        -- Wrap regular pathspec in single quotes
        table.insert(pathspecs, shellescape(pathspec))
      end
    end

    -- Assemble the final git grep command
    local new_cmd = string.format("%s %s -- %s", cmd, shellescape(search_query), table.concat(pathspecs, " "))
    return new_cmd, search_query
  end,
}

---Overrides the default options with user-provided options.
---@param user_options table
function M.setup(user_options)
  M.git_grep = vim.tbl_extend("force", M.git_grep, user_options.git_grep)

  -- Initialize options for fn_transform_cmd()
  options.init()
end

return M
