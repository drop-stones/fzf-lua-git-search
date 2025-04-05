local config = require("fzf-lua-git-search.config")
local util = require("fzf-lua-git-search.util")

---Executes the specified `git grep` picker if inside a Git repository, otherwise falls back to the default `fzf-lua` picker.
---@param picker string
---@param options? table
local function git_grep(picker, options)
  options = util.resolve_cwd(options)
  if require("fzf-lua.path").is_git_repo(options, true) then
    options = vim.tbl_extend("force", config.git_grep, options or {})
    require("fzf-lua")[picker](options)
  else
    require("fzf-lua")[picker](options)
  end
end

---`git grep` if inside a Git repository, otherwise falls back to `fzf-lua.grep`.
---@param options? table
local function grep(options)
  git_grep("grep", options)
end

---`live_grep` with `git grep` if inside a Git repository, otherwise falls back to `fzf-lua.live_grep`.
---@param options? table
local function live_grep(options)
  git_grep("live_grep", options)
end

---`grep_cword` with `git grep` if inside a Git repository, otherwise falls back to `fzf-lua.grep_cword`.
---@param options? table
local function grep_cword(options)
  git_grep("grep_cword", options)
end

---`grep_cWORD` with `git grep` if inside a Git repository, otherwise falls back to `fzf-lua.grep_cWORD`.
---@param options? table
local function grep_cWORD(options)
  git_grep("grep_cWORD", options)
end

---`grep_visual` with `git grep` if inside a Git repository, otherwise falls back to `fzf-lua.grep_visual`.
---@param options? table
local function grep_visual(options)
  git_grep("grep_visual", options)
end

return {
  grep = grep,
  live_grep = live_grep,
  grep_cword = grep_cword,
  grep_cWORD = grep_cWORD,
  grep_visual = grep_visual,
}
