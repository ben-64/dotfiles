return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })
    keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fa", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find helping tag" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Find registers" })
    keymap.set("n", "<leader>cm", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "MAN: Lists LSP document symbols in the current buffer" })
    keymap.set("n", "<leader>ci", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "INCOMING: Lists LSP incoming calls for word under the cursor" })
    keymap.set("n", "<leader>co", "<cmd>Telescope lsp_outgoing_calls<cr>", { desc = "OUTGOING: Lists LSP outgoing calls for word under the cursor" })
    keymap.set("n", "<leader>cc", "<cmd>Telescope lsp_implementations<cr>", { desc = "CODE: Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope" })
    keymap.set("n", "<leader>cd", "<cmd>Telescope lsp_definitions<cr>", { desc = "DEFINITION: Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope" })
    keymap.set("n", "<leader>ct", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "TYPE: Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope" })
  end,
}
