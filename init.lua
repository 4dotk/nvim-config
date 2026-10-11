-- Core settings first: leader must be set before lazy.nvim loads plugin keymaps
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugins
require("config.lazy")

-- Trusted per-project overrides (runs last so it can override anything above)
require("config.project")
