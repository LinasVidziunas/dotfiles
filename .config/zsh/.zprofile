# Created by `pipx` on 2024-07-13 23:16:58
export PATH="$PATH:/Users/linasvidz/.local/bin"

# Pass
if [ `which pass` == "/opt/homebrew/bin/pass" ]; then
    export PASSWORD_STORE_ENABLE_EXTENSIONS=true
    export PASSWORD_STORE_EXTENSIONS_DIR=/opt/homebrew/lib/password-store/extensions
fi
