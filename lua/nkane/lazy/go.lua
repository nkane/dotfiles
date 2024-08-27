return {
    {
        'ray-x/go.nvim',
         dependencies = {
            'ray-x/guihua.lua',
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
          require('go').setup({})
        end,
        event = {'CmdlineEnter'},
        ft = {'go', 'gomod'},
        build = ':lua require("go.install").update_all_sync()'
    },
    {
        'crusj/structrue-go.nvim',
        branch = 'main',
        config = function()
            require('structrue-go').setup()
        end
    },
    {
        'crusj/hierarchy-tree-go',
        config = function()
            require('hierarchy-tree-go').setup({})
        end
    },
}
