-- Core keymaps (plugin keymaps live with their plugin spec)
local map = vim.keymap.set

-- Save / Quit
map("n", "<leader>ww", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>qq", "<cmd>q!<CR>", { desc = "Quit without saving" })

-- Execute
map("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
map("n", "<leader>x", ":.lua<CR>", { desc = "Run current line as Lua" })
map("v", "<leader>x", ":lua<CR>", { desc = "Run selection as Lua" })

-- Split
map("n", "<leader>vs", "<cmd>new<CR>", { desc = "Split below" })
map("n", "<leader>lhs", "<cmd>vnew<CR>", { desc = "Split left" })
map("n", "<leader>rhs", "<cmd>vnew<CR><cmd>wincmd r<CR>", { desc = "Split right" })

-- Copy to clipboard
map("v", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })

-- Windows
map("n", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Window left" })
map("n", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Window down" })
map("n", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Window up" })
map("n", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Window right" })

-- Stop highlighting
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Quickfix list
map("n", "<M-j>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
map("n", "<M-k>", "<cmd>cprev<CR>", { desc = "Previous quickfix item" })

-- Buffers and Tabs
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>ct", "<cmd>bd<CR>", { desc = "Close buffer" })
map("n", "<leader>hh", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>ll", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Terminal
local terminal_session_count = 0
map("n", "<leader>sh", function()
    terminal_session_count = terminal_session_count + 1
    vim.cmd.tabnew()
    vim.cmd.term()
    vim.cmd.file("Terminal " .. terminal_session_count)
end, { desc = "Open terminal in new tab" })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
