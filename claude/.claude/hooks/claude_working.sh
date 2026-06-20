#!/usr/bin/env bash
# Toggle a per-tmux-pane "Claude Code is working" flag, read by the tmux
# status-bar spinner (see dotfiles/tmux/scripts/pane_activity.sh).
#
# Wired from ~/.claude/settings.json hooks:
#   UserPromptSubmit -> on   (Claude started working)
#   Stop             -> off  (Claude finished its turn)
#   SessionStart     -> off  (clear any stale flag for this pane)
#   SessionEnd       -> off
#
# Keyed by $TMUX_PANE, which Claude inherits from the pane it runs in. Outside
# tmux this is a no-op. Fixed /tmp dir so the tmux side resolves the same path
# regardless of per-process $TMPDIR.

[ -n "$TMUX_PANE" ] || exit 0

dir="/tmp/claude-working"
mkdir -p "$dir" 2>/dev/null
flag="$dir/${TMUX_PANE//%/}"

case "$1" in
  on)  : > "$flag" ;;
  off) rm -f "$flag" ;;
esac

exit 0
