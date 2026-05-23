-- Save
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>")

-- Quit
vim.keymap.set("n", "<leader>qq", "<cmd>q!<CR>")

-- Execute
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- Split
vim.keymap.set("n", "<leader>vs", ":new<CR>")
vim.keymap.set("n", "<leader>lhs", ":vnew<CR>")
vim.keymap.set("n", "<leader>rhs", ":vnew<CR><cmd>wincmd r<CR>")

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", "\"+y")

-- Windows
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")

-- Stop highlighting
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>")

-- Quickfix list
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- Buffers and Tabs
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>ct", "<cmd>bd<CR>")
vim.keymap.set("n", "<leader>hh", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<leader>ll", "<cmd>bnext<CR>")
