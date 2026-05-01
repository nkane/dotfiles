return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			provider = "copilot",
			providers = {
				copilot = {
					model = "claude-4.5-sonnet", -- fixed typo, removed trailing comma
				},
			},
			behaviour = {
				auto_suggestions = false,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
			},
			hints = { enabled = true },
			windows = {
				position = "right", -- right, left, top, bottom
				wrap = true,
				width = 30, -- percentage of editor width
				sidebar_header = {
					align = "center",
					rounded = true,
				},
			},
			mappings = {
				ask = "<leader>aa",
				edit = "<leader>ae",
				refresh = "<leader>ar",
				toggle = {
					debug = "<leader>ad",
					hint = "<leader>ah",
				},
			},
		},
		keys = {
			{ "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante: Ask" },
			{ "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante: Refresh" },
			{ "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Avante: Edit" },
			{ "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante: Toggle" },
			-- This command shows the current provider and model
			{ "<leader>ai", function()
				local config = require("avante.config")
				local provider = config.provider
				local model = config.providers[provider] and config.providers[provider].model or "unknown"
				vim.notify("Provider: " .. provider .. "\nModel: " .. model, vim.log.levels.INFO)
			end, desc = "Avante: Show Provider Info" },
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
