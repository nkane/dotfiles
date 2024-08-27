return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },
	-- {
	--     'rose-pine/neovim',
	--     name = 'rose-pine',
	--     config = function()
	--         vim.cmd('colorscheme rose-pine')
	--         require('rose-pine').setup({
	--             disable_background = true
	--         })
	--         vim.cmd.colorscheme('rose-pine')
	--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	--     end
	-- }
}
