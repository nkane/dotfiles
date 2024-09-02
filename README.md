### nkane's dotfiles

#### SSH User Systemd Service

- Save the service file in the location '~/.config/systemd/user/ssh-agent.service'.
- Reload the user daemon:

```bash
systemctl --user daemon-reload
```

- Enable the service:

```bash
systemctl --user enable ssh-agent.service
```

- Start the service:

```bash
systemctl --user start ssh-agent.service
```

- Check the service status:

```bash
systemctl --user status ssh-agent.service
```

- View logs:

```bash
journalctl --user -u ssh-agent.service
```
