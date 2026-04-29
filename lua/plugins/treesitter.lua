return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        },
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)

            local group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(args)
                    -- Skip large files (100 KB limit)
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                    if ok and stats and stats.size > 100 * 1024 then
                        return
                    end
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
}
