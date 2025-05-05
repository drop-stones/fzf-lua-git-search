local options = require("fzf-lua-git-search.options")
local util = require("fzf-lua-git-search.util")

---Transforms a git-grep command by injecting parsed pathspecs
---@param query string
---@param cmd string?
---@return string?, string?
local function fn_transform_cmd(query, cmd)
  if cmd == nil or query == "<query>" then
    return
  end

  local glob_separator = options.glob_separator()

  -- Extract search query and glob string separated by '--'
  local search_query, glob_str = query:match("(.-)" .. glob_separator .. "(.*)")

  if not glob_str then
    return -- Fallback to original command if no glob string
  end

  -- Build git-compatible pathspecs, supporting `:(exclude)` for negation
  local pathspecs = {}
  for pathspec in glob_str:gmatch("%S+") do
    if pathspec:sub(1, 1) == "!" then
      -- Convert '!pattern' to git's exclude pathspec
      table.insert(pathspecs, util.shellescape(":(exclude)" .. pathspec:sub(2)))
    else
      -- Wrap regular pathspec in single quotes
      table.insert(pathspecs, util.shellescape(pathspec))
    end
  end

  -- Assemble the final git grep command
  local new_cmd = string.format("%s %s -- %s", cmd, util.shellescape(search_query), table.concat(pathspecs, " "))
  return new_cmd, search_query
end

return fn_transform_cmd
