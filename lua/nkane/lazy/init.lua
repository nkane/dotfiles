return {
    {
        'nvim-lua/plenary.nvim',
        name = 'plenary'
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },
    {
        'nvim-tree/nvim-web-devicons'
    },
    {
        'nvim-treesitter/playground'
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        'mortepau/codicons.nvim',
        config = function()
            local codicons = require('codicons')
            codicons.setup({
                -- Override by mapping name to icon
                ['account'] = '',
                -- Or by name to hexadecimal/decimal value
                ['comment'] = 0xEA6B, -- hexadecimal
                ['archive'] = 60056,  -- decimal
            })
        end
    },
    {
        'tpope/vim-dadbod'
    },
    {
        'kristijanhusak/vim-dadbod-ui'
    },
    {
        'sindrets/diffview.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('diffview').setup({})
        end
    },
    {
        'saadparwaiz1/cmp_luasnip',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
        end
    },
    {
        'rafamadriz/friendly-snippets'
    },
    {
        'hrsh7th/nvim-compe'
    },
    {
        'hrsh7th/vim-vsnip'
    },
    {
        'hrsh7th/vim-vsnip-integ'
    },
    {
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- setup cmp for autopairs
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    }
}
