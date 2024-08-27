return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			dap.adapters.codelldb = {
				name = "codelldb server",
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			dap.configurations.c = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			local dap_go = require("dap-go")
			dap_go.setup({
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						type = "go",
						name = "Debug (Judge Dev Mode)",
						request = "launch",
						program = "${file}",
						args = dap_go.get_arguments,
						buildFlags = dap_go.get_build_flags,
						--args = { "serve", "--enable-workflows=false", "--dev-mode=true" },
						--buildFlags = { "-tags dev" },
					},
				},
				-- delve configurations
				delve = {
					-- the path to the executable dlv which will be used for debugging.
					-- by default, this is the "dlv" executable on your PATH.
					path = "dlv",
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port
					port = "${port}",
					-- additional args to pass to dlv
					args = {},
					-- the build flags that are passed to delve.
					-- defaults to empty string, but can be used to provide flags
					-- such as "-tags=unit" to make sure the test suite is
					-- compiled during debugging, for example.
					-- passing build flags using args is ineffective, as those are
					-- ignored by delve in dap mode.
					build_flags = "",
					-- whether the dlv process to be created detached or not. there is
					-- an issue on Windows where this needs to be set to false
					-- otherwise the dlv server creation will fail.
					detached = true,
					-- the current working directory to run dlv from, if other than
					-- the current working directory.
					cwd = nil,
				},
			})
			vim.keymap.set("n", "<leader><F6>", dap_go.debug_test)

			require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
			table.insert(dap.configurations.python, {
				name = "python-debug",
				type = "python",
				request = "launch",
				program = "${file}",
				justMyCode = false,
			})

			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = "/home/nkane/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
				--debugger_cmd = { "js-debug-adapter" },                                           -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				adapters = {
					"pwa-node",
					"pwa-chrome",
					"pwa-msedge",
					"node-terminal",
					"pwa-extensionHost",
					"node",
					"chrome",
				}, -- which adapters to register in nvim-dap
				-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
				-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
				log_console_level = vim.log.levels.ERROR, -- Logging level for output to console. Set to false to disable console output.
			})

			-- Configuration for TypeScript and JavaScript debugging
			-- NOTE(nick): typescript debugging requires ts-node, make sure to install `npm i -g ts-node`
			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node)",
						cwd = vim.fn.getcwd(),
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with ts-node)",
						cwd = vim.fn.getcwd(),
						runtimeExecutable = "ts-node",
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
				}
			end

			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "🔶", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "💩", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "📜", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
			)

			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<leader><F5>", function()
				require("dap").terminate()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<leader>b", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<leader>B", function()
				require("dap").set_breakpoint()
			end)
		end,
	},
	{
		"leoluz/nvim-dap-go",
	},
	{
		"mfussenegger/nvim-dap-python",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("dapui").setup({})
			vim.keymap.set("n", "<F8>", require("dapui").toggle)
			vim.keymap.set("i", "<F8>", require("dapui").toggle)
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				virt_text_pos = "eol", -- "inline" is another option as well, see `:h nvim_buf_set_extmark()`
				--all_references = true,
			})
		end,
	},
	{
		"mxsdev/nvim-dap-vscode-js",
	},
	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
	-- {
	-- 	'stevearc/overseer.nvim',
	-- 	opts = {},
	-- }
}
