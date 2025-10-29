all: help
.PHONY: help 

nvim-install-nightly-ppa: ## install nightly neovim ppa
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt update -y
	sudo apt install neovim -y
	
nvim-subtree-init: ## init nvim lua configuration via subtree
	git subtree add --prefix nvim/.config/nvim git@github.com:nkane/init.lua.git main --squash

nvim-subtree-pull: ## pull nvim lua configuration via subtree
	git subtree pull --prefix nvim/.config/nvim git@github.com:nkane/init.lua.git main --squash

nvim-subtree-push: ## push nvim lua configuration changes to subtree remote
	git subtree push --prefix nvim/.config/nvim git@github.com:nkane/init.lua.git main

tmux-tpm-install: ## install tpm by cloning github repo to ~/.tmux/plugins/tpm
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

linux-homebrew-install: ## install linux homebrew
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

kitty-install: ## install kitty
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

stow-install: ## install stow
	sudo apt install stow -y

tmux-install: ## install tmux
	sudo apt install tmux -y

zsh-install: ## install omzsh
	sudo apt install zsh
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

zsh-install-plugins: ## install omzsh plugins
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

starship-install: ## install starship
	curl -sS https://starship.rs/install.sh | sh

ripgrep-install: ## install ripgrep
	sudo apt install ripgrep -y

lua-install: ## install lua
	sudo apt install lua5.4 liblua5.4-dev -y
	sudo apt install luarocks -y

pyenv-install: ## install pyenv
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
		libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl
	curl https://pyenv.run | bash
	sudo apt install python3.12-venv -y

go-install: ## install go
	@echo '[Downloading golang]'
	wget https://dl.google.com/go/go1.22.5.linux-amd64.tar.gz
	@if [ -d "/usr/local/go" ]; then sudo rm -rf /usr/local/go; fi
	sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
	rm go1.22.5.linux-amd64.tar.gz
	/usr/local/go/bin/go version
	@echo 'done!'

fonts-install: ## install fonts
	echo "[-] Download fonts [-]"
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
	unzip Meslo.zip -d ~/.fonts
	fc-cache -fv
	echo "done!"

i3-install: ## install i3
	curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
	sudo apt install apt-transport-https --yes
	echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild-ubuntu/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
	sudo apt update
	sudo apt install i3

polybar-install: ## install polybar
	sudo apt install polybar -y

picom-install: ## install picom
	sudo apt install picom -y

rofi-install: ## install rofi
	sudo apt install rofi -y

xrandr-install: 
	sudo apt install x11-xserver-utils -y

ssh-enable-service:
	systemctl --user enable --now ssh-agent
	chmod 600 ~/.ssh/config
	chown ${USER} ~/.ssh/config

stow: ## stow nvim
	stow kitty 
	stow nvim
	stow starship
	stow tmux
	stow rofi
	stow picom
	stow i3
	stow polybar
	stow systemd
	stow environment.d
	stow ssh

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
