return {

  -- ─── Oil: file browser as a buffer ─────────────────────────────────────────
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        view_options = {
          show_hidden = true,
        },
        float = {
          padding = 2,
          border = "rounded",
        },
      })

      local map = vim.keymap.set
      map("n", "<leader>oo", "<cmd>Oil<CR>",                                   { desc = "Open Oil (cwd)" })
      map("n", "<leader>of", "<cmd>Oil --float<CR>",                           { desc = "Open Oil (float)" })
      map("n", "-",          "<cmd>Oil<CR>",                                   { desc = "Open parent dir" })
    end,
  },

  -- ─── Autopairs ─────────────────────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({ check_ts = true })

      -- Integration with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ─── Surround: add/change/delete surrounding pairs ─────────────────────────
  -- Usage: ys<motion><char>, cs<old><new>, ds<char>, S<char> in visual
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- ─── Comment.nvim ──────────────────────────────────────────────────────────
  -- gcc to comment line, gc in visual mode, gcip for paragraph, etc.
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      toggler  = { line = "gcc", block = "gbc" },
      opleader = { line = "gc",  block = "gb" },
    },
  },

  -- ─── Leap: fast 2-char jump anywhere on screen ─────────────────────────────
  -- s<char><char> to jump forward, S<char><char> backward
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").create_default_mappings()
    end,
  },

  -- ─── Todo-comments ─────────────────────────────────────────────────────────
  -- Highlights TODO, FIXME, HACK, NOTE, etc. with colors
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    },
  },

  -- ─── Trouble: pretty diagnostics list ──────────────────────────────────────
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",               desc = "Toggle Trouble" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>",               desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",  desc = "Document diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                    desc = "Quickfix (Trouble)" },
    },
    opts = { use_diagnostic_signs = true },
  },

  -- ─── Nvim-ufo: better folding ───────────────────────────────────────────────
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99       -- open all folds by default
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })

      local map = vim.keymap.set
      map("n", "zR", require("ufo").openAllFolds,  { desc = "Open all folds" })
      map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      map("n", "zK", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then vim.lsp.buf.hover() end
      end, { desc = "Peek fold" })
    end,
  },
}
