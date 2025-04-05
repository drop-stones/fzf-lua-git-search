local util = require("fzf-lua-git-search.util")

---`git_files` if inside a Git repository, otherwise falls back to `fzf-lua.files`.
---@param options? table
local function git_files(options)
  options = util.resolve_cwd(options)
  if require("fzf-lua.path").is_git_repo(options, true) then
    require("fzf-lua").git_files(options)
  else
    require("fzf-lua").files(options)
  end
end

return git_files
