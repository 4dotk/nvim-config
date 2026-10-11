-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- Add lazy into the runtime path
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim (leader is set in config.options, which loads first)
require("lazy").setup({
    ui = {
        border = "rounded"
    },
    spec = {
        -- import your plugins from $CONFIG_HOME/lua/plugins
        { import = "plugins" },
    },
    -- Colorscheme used while installing plugins on a fresh machine
    install = { colorscheme = { "vague" } },
})
