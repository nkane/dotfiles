return {
    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader><C-t>",
                "<cmd>TodoTelescope<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
        config = function()
            require("todo-comments").setup({
                signs = true,
                sign_priority = 8,
            })
        end,
    },
}
