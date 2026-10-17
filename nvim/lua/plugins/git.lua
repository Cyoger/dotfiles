return {

  -- ─── Gitsigns: inline blame, hunk nav, hunk staging ────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "󰍵" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "│" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk,  "Next hunk")
        map("n", "[h", gs.prev_hunk,  "Prev hunk")

        -- Actions
        map("n", "<leader>gs",  gs.stage_hunk,                                        "Stage hunk")
        map("n", "<leader>gr",  gs.reset_hunk,                                        "Reset hunk")
        map("v", "<leader>gs",  function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk (visual)")
        map("v", "<leader>gr",  function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk (visual)")
        map("n", "<leader>gS",  gs.stage_buffer,                                      "Stage buffer")
        map("n", "<leader>gR",  gs.reset_buffer,                                      "Reset buffer")
        map("n", "<leader>gp",  gs.preview_hunk,                                      "Preview hunk")
        map("n", "<leader>gb",  function() gs.blame_line({ full = true }) end,        "Blame line")
        map("n", "<leader>gB",  gs.toggle_current_line_blame,                         "Toggle line blame")
        map("n", "<leader>gd",  gs.diffthis,                                          "Diff this")
        map("n", "<leader>gD",  function() gs.diffthis("~") end,                      "Diff this ~")

        -- Text objects for hunks
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },

  -- ─── Toggleterm: floating terminal (used for lazygit) ───────────────────────
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", desc = "Toggle terminal" },
      { "<leader>tg", desc = "Lazygit" },
    },
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<leader>tt]],
        direction = "float",
        float_opts = {
          border = "curved",
          winblend = 3,
        },
        shade_terminals = true,
      })

      -- Lazygit terminal
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = { border = "double" },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })

      vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Lazygit" })

      -- Exit terminal mode with Esc
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
    end,
  },
}
