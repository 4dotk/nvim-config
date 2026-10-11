local group = vim.api.nvim_create_augroup("user-config", { clear = true })

-- No line numbers in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})
