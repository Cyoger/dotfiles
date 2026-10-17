return {

  -- ─── Mason: LSP/linter/formatter installer ──────────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- ─── Bridge mason <-> lspconfig ─────────────────────────────────────────────
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Add language servers here later, e.g.:
      -- ensure_installed = { "clangd", "lua_ls", "pyright" },
      ensure_installed = { "pyright", "clangd", "rust_analyzer", "gopls", "lua_ls" },
      automatic_enable = true,
    },
  },

  -- ─── LSP config ─────────────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      -- Pretty LSP UI improvements
      { "j-hui/fidget.nvim", opts = {} },    -- LSP loading progress indicator
    },
    config = function()
      -- Diagnostic signs in gutter
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Diagnostic display config
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Shared on_attach: keymaps applied when any LSP attaches to a buffer
      local on_attach = function(_, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        local builtin = require("telescope.builtin")

        map("gd",         builtin.lsp_definitions,      "Go to definition")
        map("gD",         vim.lsp.buf.declaration,      "Go to declaration")
        map("gr",         builtin.lsp_references,       "Go to references")
        map("gi",         builtin.lsp_implementations,  "Go to implementation")
        map("gt",         builtin.lsp_type_definitions, "Go to type definition")
        map("K",          vim.lsp.buf.hover,            "Hover docs")
        map("<C-s>",      vim.lsp.buf.signature_help,   "Signature help")
        map("<leader>lr", vim.lsp.buf.rename,           "Rename symbol")
        map("<leader>la", vim.lsp.buf.code_action,      "Code actions")
        map("<leader>ld", vim.diagnostic.open_float,    "Line diagnostics")
        map("[d",         vim.diagnostic.goto_prev,     "Prev diagnostic")
        map("]d",         vim.diagnostic.goto_next,     "Next diagnostic")
      end

      -- Capabilities enhanced with cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Apply on_attach and capabilities to all auto-enabled servers (Neovim 0.11+)
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- lua_ls: teach it about Neovim's runtime and API
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },

  -- ─── Formatting ─────────────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>lf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format buffer",
      },
    },
    opts = {
      -- Add formatters per filetype here later:
      -- formatters_by_ft = {
      --   cpp = { "clang-format" },
      --   python = { "black", "isort" },
      -- },
      formatters_by_ft = {
        python  = { "ruff_format" },   -- install: mason / pip install ruff
        cpp     = { "clang_format" },  -- install: comes with clangd / clang
        c       = { "clang_format" },
        rust    = { "rustfmt" },       -- install: rustup component add rustfmt
        go      = { "goimports" },     -- install: go install golang.org/x/tools/cmd/goimports@latest
        lua     = { "stylua" },        -- install: mason
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
