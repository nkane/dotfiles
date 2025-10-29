return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Use vim.lsp.config instead of lspconfig
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						telemetry = { enable = false },
						diagnostics = {
							globals = { "vim", "require", "pcall", "pairs" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						completion = {
							workspaceWord = true,
							callSnippet = "Replace",
						},
						hint = {
							enable = true,
						},
						format = {
							enable = false,
						},
					},
				},
			}

			vim.lsp.config.gopls = {
				cmd = { "gopls" },
				capabilities = capabilities,
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = { "go.work", "go.mod", ".git" },
			}

			vim.lsp.config.ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				capabilities = capabilities,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"tsx",
					"jsx",
					"typescript",
					"javascript",
				},
			}

			vim.lsp.config.eslint = {
				cmd = { "vscode-eslint-language-server", "--stdio" },
				capabilities = capabilities,
			}

			vim.lsp.config.mdx_analyzer = {
				cmd = { "mdx-language-server", "--stdio" },
				capabilities = capabilities,
				filetypes = { "mdx" },
			}

			vim.lsp.config.tailwindcss = {
				cmd = { "tailwindcss-language-server", "--stdio" },
				capabilities = capabilities,
			}

			vim.lsp.config.pylsp = {
				cmd = { "pylsp" },
				capabilities = capabilities,
			}

			vim.lsp.config.html = {
				cmd = { "vscode-html-language-server", "--stdio" },
				capabilities = capabilities,
			}

			vim.lsp.config.marksman = {
				cmd = { "marksman", "server" },
				capabilities = capabilities,
				filetypes = { "md", "markdown" },
			}

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {})
			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
			--vim.keymap.set('n', '<leader>vf', vim.diagnostic.open_float, {})
			vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>vhh", vim.lsp.buf.signature_help, {})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({})
		end,
	},
	{
		'davidbeckingsale/writegood.vim',
	},
}
