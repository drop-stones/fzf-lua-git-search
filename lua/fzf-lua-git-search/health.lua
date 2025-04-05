---@class NeovimVersion
---@field major integer
---@field minor integer
---@field patch integer

---Checks if the current Neovim version is greater or equal to the given version.
---@param required_version NeovimVersion
local function check_nvim_version(required_version)
  local version = vim.version()
  local nvim_version = string.format("%d.%d.%d", version.major, version.minor, version.patch)

  if
    version.major > required_version.major
    or (version.major == required_version.major and version.minor > required_version.minor)
    or (
      version.major == required_version.major
      and version.minor == required_version.minor
      and version.patch >= required_version.patch
    )
  then
    vim.health.ok("Neovim version: " .. nvim_version)
  else
    vim.health.warn("Neovim version is outdated: " .. nvim_version .. " (0.10+ recommended)")
  end
end

---Checks if a plugin is installed and reports its status.
---@param plugin_name string
---@param require_name string
---@param is_required boolean
local function check_plugin(plugin_name, require_name, is_required)
  local ok, _ = pcall(require, require_name)
  if ok then
    vim.health.ok(plugin_name .. " is installed")
  else
    if is_required then
      vim.health.error(plugin_name .. " is not installed (required)")
    else
      vim.health.warn(plugin_name .. " is not installed (optional)")
    end
  end
end

return {
  check = function()
    vim.health.start("fzf-lua-git-search")

    check_nvim_version({ major = 0, minor = 10, patch = 0 })
    check_plugin("fzf-lua", "fzf-lua", true)
    check_plugin("project.nvim", "project_nvim", false)
  end,
}
