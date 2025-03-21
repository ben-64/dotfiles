# Plugins

Plugin management is done with [lazy](https://lazy.folke.io/)

In order to disable a plugin it is possible to add a `enabled = false` in the return.

- [telescope](https://github.com/nvim-telescope/telescope.nvim): Fuzzy finder with fzf
- [which-key](https://github.com/folke/which-key.nvim): Display popup with possible keybindings
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua): File explorer
- [auto-session](https://github.com/rmagatti/auto-session): Save current neovim session
- [lualine](https://github.com/nvim-lualine/lualine.nvim): Statusline
- [dressing](https://github.com/stevearc/dressing.nvim): Improve UI (popup when we need to enter name)
- [vim-maximizer](https://github.com/szw/vim-maximizer): Maximize current window
- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Improve language management
- [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): Show line for indentation
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Completion engine plugin
- [autopairs](https://github.com/windwp/nvim-autopairs): Autopair plugins
- [todo-comments](https://github.com/folke/todo-comments.nvim): Highlight and search for specific comments
- [mason](https://github.com/williamboman/mason.nvim): Manage external editor such as LSP server
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Configuration for nvim as a LSP client
- [interestingwords](https://github.com/Mr-LLLLL/interestingwords.nvim): Highlight with different colors words
- [tint](https://github.com/levouh/tint.nvim): Allow to dim the unactive window
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim): Display signs on the columns regarding git status of each line

## Update

```vi
:Lazy
```
 Then u

## autopairs

- Disable `'` for markdown

```lua
    npairs.get_rule("'")[1]:with_pair(function()
        if vim.bo.filetype == 'markdown' then
            return false
        end
    end)
```

- Disable bacquotes is harder, I don't know why

```lua
    npairs.add_rules({
      Rule("`", "`", "markdown")
        :with_pair(function() return false end)  -- Cette ligne désactive l'ajout automatique de backquotes
    })

    npairs.get_rule("`")[1]:with_pair(function()
        if vim.bo.filetype == 'markdown' then
            return false
        end
    end)
```

## treesitter

- Activate tree display: `:TSPlaygroundToggle`
- Highlight category of node: `:TSHighlightCapturesUnderCursor`
