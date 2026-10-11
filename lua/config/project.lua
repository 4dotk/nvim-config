-- Load <cwd>/.nvim/init.lua only after the user has trusted it.
-- vim.secure.read prompts once per file and again whenever its contents change
-- (manage trust with :trust / :trust ++deny / :trust ++remove).
local path = vim.fn.getcwd() .. "/.nvim/init.lua"
if vim.fn.filereadable(path) == 0 then
    return
end

local content = vim.secure.read(path)
if not content then
    return
end

local chunk, err = load(content, "@" .. path)
if not chunk then
    vim.notify("Failed to load " .. path .. ":\n" .. err, vim.log.levels.ERROR)
    return
end
chunk()
