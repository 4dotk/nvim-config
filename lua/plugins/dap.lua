-- Debugging: nvim-dap + dap-ui, adapters for Python, JS/TS (Node) and Neovim Lua.
-- Adapters (debugpy, js-debug-adapter) are installed manually via :Mason (see mason.lua).
local OSV_PORT = 8086

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mason-org/mason.nvim", -- puts adapter binaries on PATH
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            "jbyuki/one-small-step-for-vimkind",
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Debug: Toggle breakpoint" },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Conditional breakpoint" },
            { "<leader>dc", function() require("dap").continue() end,                                             desc = "Debug: Start / Continue" },
            { "<leader>dn", function() require("dap").step_over() end,                                            desc = "Debug: Step over" },
            { "<leader>di", function() require("dap").step_into() end,                                            desc = "Debug: Step into" },
            { "<leader>do", function() require("dap").step_out() end,                                             desc = "Debug: Step out" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Debug: Run to cursor" },
            { "<leader>dq", function() require("dap").terminate() end,                                            desc = "Debug: Terminate" },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Debug: Toggle REPL" },
            { "<leader>du", function() require("dapui").toggle() end,                                             desc = "Debug: Toggle UI" },
            { "<leader>de", function() require("dapui").eval() end,                                               desc = "Debug: Evaluate",                    mode = { "n", "v" } },
            -- Run in the Neovim instance you want to debug, then <leader>dc from another instance
            { "<leader>dl", function() require("osv").launch({ port = OSV_PORT }) end,                            desc = "Debug: Start Lua server (this nvim)" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- UI
            dapui.setup()
            require("nvim-dap-virtual-text").setup({})

            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticHint" })
            vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo" })
            vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "Visual" })

            -- Python (debugpy)
            require("dap-python").setup("debugpy-adapter")

            -- JavaScript / TypeScript (Node via vscode-js-debug)
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = { command = "js-debug-adapter", args = { "${port}" } },
            }
            for _, ft in ipairs({ "javascript", "typescript" }) do
                dap.configurations[ft] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch current file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach to process",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                    },
                }
            end

            -- Lua (Neovim, via one-small-step-for-vimkind)
            dap.adapters.nlua = function(callback, config)
                callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or OSV_PORT })
            end
            dap.configurations.lua = {
                {
                    type = "nlua",
                    request = "attach",
                    name = "Attach to running Neovim instance",
                },
            }
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = { "nvim-neotest/nvim-nio" },
    },
}
