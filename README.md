### nkane's dotfiles

Cross-platform: macOS + Linux (Ubuntu/Debian).

`make doctor` prints the detected OS / arch / pkg manager.

#### macOS install

```bash
git clone <this repo> ~/dotfiles && cd ~/dotfiles
make bootstrap          # OS-aware; runs bootstrap-macos
# or step-by-step:
make brew-install
make brewfile-install
make zsh-install zsh-install-plugins
make tmux-tpm-install
make nvim-subtree-init
make stow               # stows kitty/nvim/starship/tmux/ssh
make ssh-enable-macos   # loads ~/.ssh/id_* into keychain
```

`Brewfile` is the source of truth for macOS packages — keep it in sync with the Linux apt targets in the `Makefile`.

#### Linux (Ubuntu/Debian) install

```bash
git clone <this repo> ~/dotfiles && cd ~/dotfiles
make bootstrap          # OS-aware; runs bootstrap-linux
```

Linux uses the apt-based targets in the `Makefile` plus the X11 stack (`i3`, `polybar`, `picom`, `rofi`) and a systemd ssh-agent service.

##### SSH agent (Linux, systemd)

Save the service file to `~/.config/systemd/user/ssh-agent.service` via `stow systemd`, then:

```bash
systemctl --user daemon-reload
systemctl --user enable ssh-agent.service
systemctl --user start ssh-agent.service
systemctl --user status ssh-agent.service
journalctl --user -u ssh-agent.service
```

#### Layout

| dir | purpose | platform |
| --- | --- | --- |
| `kitty/`, `nvim/`, `tmux/`, `starship/`, `ssh/`, `zsh/`, `bash/`, `git/`, `js/`, `lua/`, `claude/` | shared configs | both |
| `i3/`, `polybar/`, `picom/`, `rofi/`, `systemd/`, `environment.d/` | X11 / systemd | linux |
| `scripts/` | helpers (`detect-os.sh`, `ssh-agent-macos.sh`) | both |
| `Brewfile` | macOS package list | macos |
