return {
    "numToStr/Comment.nvim",
    opts = {
        -- add any options here
    },
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>/", function()
            require("Comment.api").toggle.linewise.current()
        end)
        vim.keymap.set(
            "v",
            "<leader>/",
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
        )
    end,
}
