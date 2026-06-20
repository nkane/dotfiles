# Claude Code hooks

## claude_working.sh — tmux "Claude is working" spinner

Sets a per-tmux-pane flag while Claude Code is mid-turn. The tmux status bar
reads the flag and renders an animated braille spinner before the window name.

Two halves must both be present:

- **Writer** (this dir): `claude_working.sh on|off`, flag at
  `/tmp/claude-working/<pane>`, keyed by `$TMUX_PANE`.
- **Reader** (tmux package): `tmux/scripts/pane_activity.sh`, wired into the
  catppuccin window text in `tmux/.tmux.conf`. Needs `status-interval 1` so the
  spinner animates.

### Wiring (add to `~/.claude/settings.json`)

`stow claude` places the script; the hook entries below are NOT stowed (the rest
of `settings.json` is machine-specific). Merge these into the `hooks` object by
hand:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      { "hooks": [ { "type": "command", "command": "bash \"$HOME/.claude/hooks/claude_working.sh\" on", "timeout": 5 } ] }
    ],
    "Stop": [
      { "hooks": [ { "type": "command", "command": "bash \"$HOME/.claude/hooks/claude_working.sh\" off", "timeout": 5 } ] }
    ],
    "SessionStart": [
      { "hooks": [ { "type": "command", "command": "bash \"$HOME/.claude/hooks/claude_working.sh\" off", "timeout": 5 } ] }
    ],
    "SessionEnd": [
      { "hooks": [ { "type": "command", "command": "bash \"$HOME/.claude/hooks/claude_working.sh\" off", "timeout": 5 } ] }
    ]
  }
}
```

`UserPromptSubmit` → on (turn starts); `Stop` → off (turn ends);
`SessionStart`/`SessionEnd` → off (clear stale flags). Outside tmux the script
no-ops.
