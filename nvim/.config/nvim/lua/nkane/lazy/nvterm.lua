return {
    'NvChad/nvterm',
    config = function ()
        local term = require('nvterm')
        term.setup({
            terminals = {
            shell = vim.o.shell,
                list = {},
                type_opts = {
                float = {
                  relative = 'editor',
                  row = 0.1,
                  col = 0.15,
                  width = 0.7,
                  height = 0.7,
                  border = 'single',
                },
                horizontal = { location = 'rightbelow', split_ratio = 0.3 },
                vertical = { location = 'rightbelow', split_ratio = 0.5 },
              },
            },
            behavior = {
                autoclose_on_quit = {
                    enabled = false,
                    confirm = true,
                },
                close_on_exit = true,
                auto_insert = true,
            }
        })
        vim.keymap.set('n', '<leader><S-t>', function() require('nvterm.terminal').toggle 'float' end)
        vim.keymap.set('t', '<leader><S-t>', function() require('nvterm.terminal').toggle 'float' end)
    end
}
