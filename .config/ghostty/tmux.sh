#!/usr/bin/env bash

SESSION_NAME="ghostty"

# Fallback to sh if tmux is not installed
command -v tmux >/dev/null 2>&1 || {
    /bin/sh
    exit
}

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # Session exists: Create a new GROUPED session linked to it.
    tmux new-session -t "$SESSION_NAME"
else
    # Session does not exist: Create the master session.
    tmux new-session -s "$SESSION_NAME"
fi
