local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ─── General ─────────────────────────────────────────────────────────────────

map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear search highlight" })

-- ─── Navigation ──────────────────────────────────────────────────────────────

-- Center cursor after jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- Window splits
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- Tabs
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabprev<CR>", { desc = "Prev tab" })

-- ─── Editing ─────────────────────────────────────────────────────────────────

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Stay in visual mode after indent
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Join lines without moving cursor
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Yank to end of line (consistent with D, C)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- ─── Buffers ─────────────────────────────────────────────────────────────────

map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprev<CR>", { desc = "Prev buffer" })

-- ─── Quickfix ────────────────────────────────────────────────────────────────

map("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix" })
map("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "<leader>cp", "<cmd>cprev<CR>", { desc = "Prev quickfix item" })
