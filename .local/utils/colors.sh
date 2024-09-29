#!/usr/bin/env bash

# =================================== COLORS ===================================
export FG_BLACK='30'
export FG_RED='31'
export FG_GREEN='32'
export FG_YELLOW='33'
export FG_BLUE='34'
export FG_MAGENTA='35'
export FG_CYAN='36'
export FG_LIGHT_RED='91'
export FG_LIGHT_GREEN='92'
export FG_LIGHT_YELLOW='93'
export FG_LIGHT_BLUE='94'
export FG_LIGHT_MAGENTA='95'
export FG_LIGHT_CYAN='96'
export FG_WHITE='97'

export BG_BLACK='40'
export BG_RED='41'
export BG_GREEN='42'
export BG_YELLOW='43'
export BG_BLUE='44'
export BG_MAGENTA='45'
export BG_CYAN='46'
export BG_LIGHT_RED='101'
export BG_LIGHT_GREEN='102'
export BG_LIGHT_YELLOW='103'
export BG_LIGHT_BLUE='104'
export BG_LIGHT_MAGENTA='105'
export BG_LIGHT_CYAN='106'
export BG_WHITE='107'

export BOLD='1'
export FAINT='2'
export ITALIC='3'
export UNDERLINE='4'
export BLINK='5'
export REVERSE='7'
export HIDDEN='8'
export STRIKETHROUGH='9'

export NC='\033[0m'

# =================================== FUNCTIONS ===================================
colorize_text() {
    # Usage: colorize_text [foreground] [background] [style] text
    #
    # Colorize and style text output in the terminal.
    #
    # Parameters:
    #   foreground: (optional) Foreground color code (e.g., 31 for red)
    #   background: (optional) Background color code (e.g., 42 for green background)
    #   style:      (optional) Text style code (e.g., 1 for bold)
    #   text:       The text to be colorized and styled
    #
    # Color and style codes:
    #   Foreground: 30-37, 90-97
    #   Background: 40-47, 100-107
    #   Style: 0-normal, 1-bold, 2-dim, 3-italic, 4-underline, 5-blink, 7-reverse, 8-hidden
    #
    # Example: colorize_text 31 42 1 "Hello, World!"

    local foreground="$1"
    local background="$2"
    local style="$3"
    local format=""

    shift 3

    [[ -n "$style" ]] && format+=";${style}"
    [[ -n "$foreground" ]] && format+=";${foreground}"
    [[ -n "$background" ]] && format+=";${background}"

    # Remove leading semicolon if present
    format="${format#;}"

    if [[ -n "$format" ]]; then
        printf "\033[${format}m%s${NC}" "$@"
    else
        printf "%s" "$@"
    fi
}
