return {
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                view_options = {
                    show_hidden = true,
                    -- This function defines what is considered a "hidden" file
                    is_hidden_file = function(name, bufnr)
                        local m = name:match("^%.")
                        return m ~= nil
                    end,
                    -- This function defines what will never be shown, even when `show_hidden` is set
                    is_always_hidden = function(name, bufnr)
                        return false
                    end,
                },
                keymaps = {
                    ["<C-h>"] = false,
                    ["<C-l>"] = false,
                },
            })
            vim.keymap.set("n", "<leader>dt", ":Oil<CR>")

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "oil",
                callback = function()
                    vim.opt_local.number = false
                    vim.opt_local.relativenumber = false
                end
            })
        end
    }
}
