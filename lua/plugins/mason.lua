-- LSP servers and debug adapters are installed manually via :Mason
-- (lua-language-server, clangd, basedpyright, typescript-language-server, debugpy, js-debug-adapter)
return {
    {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = {
            ui = {
                border = "rounded",
                width = 0.75,
                height = 0.75
            }
        }
    },
}
