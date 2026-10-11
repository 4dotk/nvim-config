local parsers = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "javascript", "typescript" }

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        -- The main branch does not support lazy-loading
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- main branch: setup() only takes install_dir; parsers are installed explicitly.
            -- install() is a no-op for parsers that are already present.
            require("nvim-treesitter").install(parsers)

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("user-treesitter-highlight", { clear = true }),
                callback = function(args)
                    -- Skip large files (100 KB limit)
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                    if ok and stats and stats.size > 100 * 1024 then
                        return
                    end
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
}
