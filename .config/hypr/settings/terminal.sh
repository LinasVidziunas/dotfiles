#!/usr/bin/env bash

# Ordered list of preferred terminal emulators
emulators=(
    "kitty"
    "emacsclient -e \"(eshell)\""
)


for entry in "${emulators[@]}"; do
    read -r -a parts <<< "${entry}"
    cmd="${parts[0]}"
    opts=("${parts[@]:1}")

    command -v "${cmd}" > /dev/null 2>&1 && \
        exec "${cmd}" "${opts[@]}" "$@" && \
        exit 0
done


exit 1
