#!/usr/bin/env bash
# Detect OS / arch / package manager / brew prefix. Source me; do not exec.
# Sets: OS, ARCH, PKG, BREW_PREFIX (when applicable).

case "$(uname -s)" in
    Darwin) OS=macos ;;
    Linux)  OS=linux ;;
    *)      OS=unknown ;;
esac

case "$(uname -m)" in
    arm64|aarch64) ARCH=arm64 ;;
    x86_64)        ARCH=x86_64 ;;
    *)             ARCH=$(uname -m) ;;
esac

if [ "$OS" = "macos" ]; then
    PKG=brew
    if [ "$ARCH" = "arm64" ]; then
        BREW_PREFIX=/opt/homebrew
    else
        BREW_PREFIX=/usr/local
    fi
elif [ "$OS" = "linux" ]; then
    if command -v apt-get >/dev/null 2>&1; then
        PKG=apt
    elif command -v dnf >/dev/null 2>&1; then
        PKG=dnf
    elif command -v pacman >/dev/null 2>&1; then
        PKG=pacman
    else
        PKG=unknown
    fi
    if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        BREW_PREFIX=/home/linuxbrew/.linuxbrew
    fi
fi

export OS ARCH PKG BREW_PREFIX
