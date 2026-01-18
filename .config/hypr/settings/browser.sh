flatpak=$(command -v flatpak)
flatpak_list="$(flatpak list --app)"

if [ -n "${flatpak}" ]; then
    flatpak_browsers=(
        "app.zen_browser.zen"
    )

    for browser in "${flatpak_browsers[@]}"; do
        [[ "${flatpak_list}" == *"${browser}"* ]] && \
            flatpak run "${browser}" && \
            exit 0
    done;
fi
