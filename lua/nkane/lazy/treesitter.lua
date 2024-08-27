return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = {
				enable = true,
				enabled = true,
				disable = {},
			},
			sync_install = true,
			indent = {
				enabled = true,
			},
		})

		parser_config.tsx.filetype_to_parsername = {
			"javascript",
			"javascript.jsx",
			"typescript.tsx",
		}
	end,
}
