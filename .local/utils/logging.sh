#!/usr/bin/env bash

[ -z "$UTILS_DIR" ] && UTILS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
[ -z "$UTILS_DIR/colors.sh" ] && echo "Missing required file: colors.sh" && exit 1
. "$UTILS_DIR/colors.sh"

timestamp() {
    date +"%Y-%m-%d %T"
}

debug() {
    printf "$(timestamp) $(colorize_text "$FG_LIGHT_MAGENTA" "" "$BOLD" "[DEBUG]") %s\n" "$*"
}

info() {
    printf "$(timestamp)  $(colorize_text "" "" "$BOLD" "[INFO]") %s\n" "$@"
}

warn() {
    printf "$(timestamp)  $(colorize_text "$FG_YELLOW" "" "$BOLD" "[WARN]") %s\n" "$@"
}

error() {
    printf "$(timestamp) $(colorize_text "$FG_RED" "" "$BOLD" "[ERROR]") %s\n" "$@"
}
