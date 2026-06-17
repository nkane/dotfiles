SHELL := /bin/bash
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
OS := macos
else ifeq ($(UNAME_S),Linux)
OS := linux
else
OS := unknown
endif

all: help
.PHONY: help bootstrap bootstrap-macos bootstrap-linux stow stow-macos stow-linux

bootstrap: bootstrap-$(OS) ## OS-aware full bootstrap

# ────────────────────────────────────────────────────────────────────────────
# macOS
# ────────────────────────────────────────────────────────────────────────────
bootstrap-macos: brew-install brewfile-install zsh-install zsh-install-plugins tmux-tpm-install nvim-subtree-init stow-macos ssh-enable-macos ## macOS full bootstrap

brew-install: ## install homebrew (macos + linux)
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brewfile-install: ## install everything in Brewfile (macos)
	brew bundle --file=Brewfile

ssh-enable-macos: ## load ssh keys into macOS keychain
	bash scripts/ssh-agent-macos.sh

stow-macos: ## stow macOS-relevant configs
	stow kitty
	stow nvim
	stow starship
	stow tmux
	stow ssh
	stow claude

# ────────────────────────────────────────────────────────────────────────────
# Linux (apt — Ubuntu/Debian)
# ────────────────────────────────────────────────────────────────────────────
bootstrap-linux: linux-homebrew-install zsh-install zsh-install-plugins tmux-install tmux-tpm-install stow-install ripgrep-install lua-install pyenv-install go-install fonts-install starship-install kitty-install nvim-install-nightly-ppa nvim-subtree-init stow-linux ssh-enable-service ## linux full bootstrap

linux-homebrew-install: ## install linux homebrew
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

nvim-install-nightly-ppa: ## install nightly neovim ppa
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt update -y
	sudo apt install neovim -y

kitty-install: ## install kitty
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

stow-install: ## install stow
	sudo apt install stow -y

tmux-install: ## install tmux
	sudo apt install tmux -y

ripgrep-install: ## install ripgrep
	sudo apt install ripgrep -y

lua-install: ## install lua
	sudo apt install lua5.4 liblua5.4-dev -y
	sudo apt install luarocks -y

pyenv-install: ## install pyenv (linux build deps)
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
		libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl
	curl https://pyenv.run | bash
	sudo apt install python3.12-venv -y

go-install: ## install go (linux tarball)
	@echo '[Downloading golang]'
	wget https://dl.google.com/go/go1.22.5.linux-amd64.tar.gz
	@if [ -d "/usr/local/go" ]; then sudo rm -rf /usr/local/go; fi
	sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
	rm go1.22.5.linux-amd64.tar.gz
	/usr/local/go/bin/go version
	@echo 'done!'

fonts-install: ## install Meslo nerd font (linux)
	echo "[-] Download fonts [-]"
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
	unzip Meslo.zip -d ~/.fonts
	fc-cache -fv
	echo "done!"

i3-install: ## install i3 (linux only)
	curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
	sudo apt install apt-transport-https --yes
	echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild-ubuntu/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
	sudo apt update
	sudo apt install i3

polybar-install: ## install polybar (linux only)
	sudo apt install polybar -y

picom-install: ## install picom (linux only)
	sudo apt install picom -y

rofi-install: ## install rofi (linux only)
	sudo apt install rofi -y

xrandr-install: ## install xrandr (linux only)
	sudo apt install x11-xserver-utils -y

ssh-enable-service: ## enable systemd ssh-agent service (linux)
	systemctl --user enable --now ssh-agent
	chmod 600 ~/.ssh/config
	chown $${USER} ~/.ssh/config

stow-linux: ## stow Linux configs (includes X11 / systemd)
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
	stow claude

# ────────────────────────────────────────────────────────────────────────────
# OS-agnostic
# ────────────────────────────────────────────────────────────────────────────
stow: stow-$(OS) ## OS-aware stow dispatcher

starship-install: ## install starship
	curl -sS https://starship.rs/install.sh | sh

zsh-install: ## install oh-my-zsh
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

zsh-install-plugins: ## install omzsh plugins
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

tmux-tpm-install: ## install tpm
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

nvim-subtree-init: ## init nvim lua via subtree
	git subtree add --prefix nvim/.config/nvim git@github.com:nkane/init.lua.git main --squash

nvim-subtree-pull: ## pull nvim lua via subtree
	git subtree pull --prefix nvim/.config/nvim git@github.com:nkane/init.lua.git main --squash

nvim-subtree-push: ## push nvim lua subtree
	git subtree push --prefix nvim/.config/nvim git@github.com:nkane/init.lua.git main

caveman-install: ## install caveman Claude Code plugin from JuliusBrussee/caveman
	claude plugin marketplace add JuliusBrussee/caveman
	claude plugin install caveman@caveman

doctor: ## print detected OS / arch / pkg
	@bash -c 'source scripts/detect-os.sh && echo "OS=$$OS ARCH=$$ARCH PKG=$$PKG BREW_PREFIX=$$BREW_PREFIX"'

help: ## Display this help screen
	@echo "Detected OS: $(OS)"
	@echo ""
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
