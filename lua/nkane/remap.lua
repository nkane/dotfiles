vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move blocks of highlighted text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- set line to caps
vim.keymap.set("n", "Y", "yg$")
-- move bottom line up without moving cursor
vim.keymap.set("n", "J", "mzJ`z")
-- move up and down keep cursor in center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- next and previous search hits cusor in center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- save highlighted paste and place over text doesn't replace
vim.keymap.set("x", "<leader>p", '"_dP')

-- yank in to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- deleting to void register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- vertical split not saved on control-c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Q terrible
vim.keymap.set("n", "Q", "<nop>")

-- https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
-- https://github.com/jrmoulton/tmux-sessionizer
--vim.keymap.set('n', '<C-f>', "<cmd>slient !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

-- quick fix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/nkane/init.lua<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set("i", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")

vim.keymap.set("i", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")

vim.keymap.set("n", "<leader>gtf", "<cmd>GoTestFunc<CR>")

vim.keymap.set("n", "<leader>o", "o<Esc>")

vim.keymap.set("n", "<C-i>", "i<CR><ESC>")
