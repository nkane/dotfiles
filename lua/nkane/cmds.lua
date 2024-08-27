vim.api.nvim_command('command! Scratch enew | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile')

vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})
