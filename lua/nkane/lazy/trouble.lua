return {
    {
        'folke/trouble.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {},
        keys = {
            {
                '<leader>t',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            }
        },
        config = function()
            require('trouble').setup({})
        end
    },
}
