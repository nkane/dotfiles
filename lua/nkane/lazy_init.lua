local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- { "LazyVim/LazyVim",                        import = "lazyvim.plugins" },
		-- { import = "lazyvim.plugins.extra.lang.typescript" },
		-- { import = "lazyvim.plugins.extra.lang.json" },
		-- { import = "lazyvim.plugins.extra.ui.mini-animate" },
		-- { import = "lazyvim.plugins.extra.test.core" },
		-- { import = "lazyvim.plugins.extra.dap.core" },
		{ import = "nkane.lazy" },
	},
})
