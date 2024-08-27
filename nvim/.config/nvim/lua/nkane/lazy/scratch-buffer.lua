return {
	{
		"miguelcrespo/scratch-buffer.nvim",
		event = "VimEnter",
		config = function()
			require("scratch-buffer").setup()
		end,
		dependencies = {
			-- Recommended if you want interactive evaluation
			"Olical/conjure",
		},
	},
}
