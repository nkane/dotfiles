### nkane's init.lua

Prerequiste installs:

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [lazydocker](https://github.com/jesseduffield/lazydocker)

### Change Log

- [8f62cbb](https://github.com/nkane/init.lua/commit/8f62cbb3b422183aff37540f56a6caa068ac5d77) initial commit
- [2c81978](https://github.com/nkane/init.lua/commit/2c8197830ec8fac4f9d72d87931d48759ce9817b) minor fixes to bindings and disable gofmt bufwritepre
- [9566f1b](https://github.com/nkane/init.lua/commit/9566f1be2f6f842ad47732d149d9ccdce1b6edad) minor additions to bindings and commands, update to telescope version
- [089c4a3](https://github.com/nkane/init.lua/commit/089c4a3da946e8fb414a8da86900e0ea04f41c86) major update swapping out packer for lazy
- [7a536d0](https://github.com/nkane/init.lua/commit/7a536d0720d484dc09621ff29478a120e7a4fecb) harpoon updates, lsp-config binding updates, setting mason versions, add lazydocker, and add lazygit

### Debugger Info

#### Python

- The DAP extension that is used is [vim-dap-python](https://github.com/mfussenegger/nvim-dap-python), which requires
  python-venv that can be installed on Ubuntu using `apt install python3.10-venv`. Once that is installed, the following
  commands can be run in your home directory:

```bash
mkdir .virtualenvs
cd .virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

- Debugpy can be installed via [mason.nvim](https://github.com/williamboman/mason.nvim), it requires `python venv`.
