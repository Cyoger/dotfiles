local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- UI
opt.signcolumn = "yes"       -- always show sign column (prevents layout shift)
opt.cursorline = true        -- highlight current line
opt.termguicolors = true     -- true color support
opt.scrolloff = 8            -- keep cursor away from screen edges
opt.sidescrolloff = 8
opt.wrap = false             -- no line wrap

-- Search
opt.hlsearch = false         -- don't keep highlighting after search
opt.incsearch = true         -- highlight as you type
opt.ignorecase = true
opt.smartcase = true         -- override ignorecase if query has uppercase

-- Performance
opt.updatetime = 50          -- faster CursorHold / gitsigns updates
opt.timeoutlen = 300         -- which-key popup delay

-- Files
opt.undofile = true          -- persistent undo across sessions
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard (sync with system)
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Misc
opt.mouse = "a"
opt.showmode = false         -- lualine shows it instead
opt.pumheight = 10           -- max items in completion popup
opt.conceallevel = 0         -- show text normally
