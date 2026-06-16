#!/usr/bin/env bash
# Print an animated spinner ONLY while Claude Code is actively working in this
# pane. Working state is set by ~/.claude/hooks/claude_working.sh, which Claude
# toggles on UserPromptSubmit (on) and Stop (off). The flag is keyed by pane id.
#
# Usage (in .tmux.conf, inside a window/status format):
#   #(~/dotfiles/tmux/scripts/pane_activity.sh #{pane_id})
#
# tmux expands #{pane_id} into $1 and re-runs this each status-interval, so the
# glyph (chosen from the wall clock) advances once per refresh.

pane="$1"
flag="/tmp/claude-working/${pane//%/}"

[ -f "$flag" ] || exit 0   # not working -> no indicator

frames=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
i=$(( $(date +%s) % ${#frames[@]} ))

# Peach spinner, then restore fg so the Catppuccin segment style is untouched.
printf '#[fg=#fab387]%s#[fg=default] ' "${frames[$i]}"
