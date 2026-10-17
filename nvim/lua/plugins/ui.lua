return {

  -- ─── Colorscheme ───────────────────────────────────────────────────────────
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",       -- moon | storm | night | day
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },

  -- ─── Statusline ────────────────────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = "|",
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },   -- relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- ─── Noice (UI overhaul: cmdline, messages, popupmenu) ─────────────────────
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- classic search bar at bottom
        command_palette = true,       -- command palette style cmdline
        long_message_to_split = true, -- long messages go to split
        inc_rename = false,
      },
    },
  },

  -- ─── Which-key (keybind hints) ─────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      -- Register group labels
      wk.add({
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>s", group = "Split" },
        { "<leader>t", group = "Tab / Terminal" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Quickfix" },
        { "<leader>o", group = "Oil (files)" },
      })
    end,
  },

  -- ─── Indent guides ─────────────────────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },

  -- ─── Icons ─────────────────────────────────────────────────────────────────
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ─── Colorize hex codes in-buffer ──────────────────────────────────────────
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- ─── Dashboard ─────────────────────────────────────────────────────────────
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "doom",
      config = {
        header = {
          "",
          "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
          "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
          "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
          "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
          "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
          "",
        },
        center = {
          { action = "Telescope find_files", desc = " Find File",    icon = " ", key = "f" },
          { action = "Telescope oldfiles",   desc = " Recent Files", icon = " ", key = "r" },
          { action = "Telescope live_grep",  desc = " Find Text",    icon = " ", key = "g" },
          { action = "Oil",                  desc = " File Browser", icon = " ", key = "e" },
          { action = "Lazy",                 desc = " Plugins",      icon = "󰒲 ", key = "p" },
          { action = "qa",                   desc = " Quit",         icon = " ", key = "q" },
        },
        footer = {},
      },
    },
  },
}
