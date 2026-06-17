#!/usr/bin/env bash
# Load all ~/.ssh/id_* private keys into the macOS keychain-backed ssh-agent.
# macOS ssh-agent runs under launchd by default; no systemd unit needed.
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
    echo "this script is macOS only" >&2
    exit 1
fi

chmod 600 ~/.ssh/config 2>/dev/null || true

shopt -s nullglob
for key in ~/.ssh/id_*; do
    case "$key" in
        *.pub) continue ;;
    esac
    chmod 600 "$key"
    ssh-add --apple-use-keychain "$key" || true
done

echo "ssh keys loaded into keychain"
