return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native fzf sorter (much faster on large codebases)
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",  -- use telescope for vim.ui.select
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = " ",
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Esc>"] = actions.close,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")

      -- ─── Keymaps ───────────────────────────────────────────────────────────
      local map = vim.keymap.set
      local builtin = require("telescope.builtin")

      map("n", "<leader>ff", builtin.find_files,                        { desc = "Find files" })
      map("n", "<leader>fg", builtin.live_grep,                         { desc = "Live grep" })
      map("n", "<leader>fb", builtin.buffers,                           { desc = "Buffers" })
      map("n", "<leader>fh", builtin.help_tags,                         { desc = "Help tags" })
      map("n", "<leader>fr", builtin.oldfiles,                          { desc = "Recent files" })
      map("n", "<leader>fc", builtin.grep_string,                       { desc = "Grep cursor word" })
      map("n", "<leader>fk", builtin.keymaps,                           { desc = "Keymaps" })
      map("n", "<leader>fd", builtin.diagnostics,                       { desc = "Diagnostics" })
      map("n", "<leader>fs", builtin.lsp_document_symbols,              { desc = "Document symbols" })
      map("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols,     { desc = "Workspace symbols" })
      map("n", "<leader>f/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          previewer = false,
        }))
      end, { desc = "Fuzzy search in buffer" })
    end,
  },
}
