return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- Mason first so its bin dir is on PATH before servers start
            "mason-org/mason.nvim",
            "saghen/blink.cmp", -- registers its completion capabilities for all servers
        },
        config = function()
            -- Server configs come from nvim-lspconfig's lsp/ directory.
            -- Override per server with vim.lsp.config("<name>", { ... }) or an lsp/<name>.lua file.
            vim.lsp.enable({ "lua_ls", "clangd", "basedpyright", "ts_ls" })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                    -- Format on save
                    if not client:supports_method("textDocument/willSaveWaitUntil")
                        and client:supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("user-lsp-format-" .. args.buf, { clear = true }),
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                            end
                        })
                    end
                end,
            })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
