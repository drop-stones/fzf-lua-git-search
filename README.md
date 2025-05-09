# fzf-lua-git-search

**`fzf-lua-git-search`** is a lightweight Neovim plugin that extends [`fzf-lua`](https://github.com/ibhagwan/fzf-lua) with Git-aware file and grep pickers.

## ✨ Features

- 📁 Git-aware file and grep pickers
- 🧠 Automatically chooses between Git and non-Git search strategies
- 🔧 Fully compatible with all `fzf-lua` options
- 🌐 Optional `root` setting to control search scope

## ⚡️ Requirements

- Neovim >= **0.10.0**
- [`fzf-lua`](https://github.com/ibhagwan/fzf-lua)
- [`project.nvim`](https://github.com/ahmedkhalf/project.nvim) (optional, required for `root = true`)

## 📦 Installation

Install the plugin with your preferred package manager.

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "drop-stones/fzf-lua-git-search",
  dependencies = {
    "ibhagwan/fzf-lua",
    "ahmedkhalf/project.nvim" -- optional
  },
  opts = {},
  keys = {},
}
```

## ⚙️  Configuration

You can customize `git grep` behavior with the following options.<br />
Expand to see the list of all the default options below.

<details><summary>Default Options</summary>

```lua
{
  git_grep = {
    cmd = "git grep --ignore-case --extended-regexp --line-number --column --color=always --untracked",
    winopts = { title = " Git Grep " },
    fn_transform_cmd = function(query, cmd, _)
      -- ensure grep contexts are available during runtime
      vim.opt.rtp:append(vim.env.FZF_LUA_GIT_SEARCH)
      return require("fzf-lua-git-search").transform(query, cmd)
    end,
  }
}
```

</details>

> [!NOTE]
> The plugin sets `vim.env.FZF_LUA_GIT_SEARCH` automatically on startup.<br />
> Make sure to call `fn_transform_cmd` **after** the plugin is loaded.

## 🚀 Usage

### Available Functions

| Function | Description |
| -------- | ----------- |
| `files`  | Git-aware file picker |
| `grep`   | Git-aware grep picker |
| `live_grep` | Git-aware live grep |
| `grep_cword` | Git-aware grep for the word under the cursor |
| `grep_cWORD` | Git-aware grep for the WORD under the cursor |
| `grep_visual` | Git-aware grep for visually selected text |

Each function automatically detects whether you're inside a Git repository and picks the best tool for the job:

- In Git projects: use `git_files` and `git grep` for fast, scoped results
- Outside Git: falls back to default `fzf-lua` pickers like `files` and `live_grep`

### Options

Each function accepts the same options as their `fzf-lua` counterparts.<br />
In addition, this plugin introduces a custom `root` option:

| Option | Description |
| ------ | ----------- |
| `root = true` | Use the **project root** directory (requires [`project.nvim`](https://github.com/ahmedkhalf/project.nvim)) |
| `root = false` | Use the **current working** directory (`vim.fn.getcwd()`) |

### Example

```lua
{
  keys = {
      { "<leader>ff", function() require("fzf-lua-git-search").files({ root = true }) end, desc = "Find Files (Root Dir)" },
      { "<leader>fF", function() require("fzf-lua-git-search").files({ root = false }) end, desc = "Find Files (cwd)" },
      { "<leader>sg", function() require("fzf-lua-git-search").live_grep({ root = true }) end, desc = "Grep (Root Dir)" },
      { "<leader>sG", function() require("fzf-lua-git-search").live_grep({ root = false }) end, desc = "Grep (cwd)" },
      { "<leader>sw", function() require("fzf-lua-git-search").grep_cword({ root = true }) end, desc = "Word (Root Dir)" },
      { "<leader>sW", function() require("fzf-lua-git-search").grep_cword({ root = false }) end, desc = "Word (cwd)" },
      { "<leader>sw", function() require("fzf-lua-git-search").grep_visual({ root = true }) end, mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sW", function() require("fzf-lua-git-search").grep_visual({ root = false }) end, mode = "v", desc = "Selection (cwd)" },
  }
}
```

## 🩺 Troubleshooting

Run `:checkhealth fzf-lua-git-search` if you run into any issues.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
