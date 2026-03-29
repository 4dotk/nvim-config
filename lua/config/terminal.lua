vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end
})

local terminal_session_count = 0

vim.keymap.set("n", "<leader>sh", function()
    terminal_session_count = terminal_session_count + 1
    vim.cmd.tabnew()
    vim.cmd.term()
    vim.cmd.file("Terminal " .. terminal_session_count)
end)

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
