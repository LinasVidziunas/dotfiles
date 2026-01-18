#!/usr/bin/env bash

# Enable markup rendering
echo -en "\0markup-rows\x1ftrue\n"

########################################
# TIME
########################################
time_str=$(date +'[%a %H:%M] (%d/%m/%y)')

########################################
# BATTERY
########################################
if command -v upower >/dev/null; then
    bat_path=$(upower -e | grep BAT | head -n1)
    if [ -n "$bat_path" ]; then
        bat_info=$(upower -i "$bat_path")
        bat_percent=$(echo "$bat_info" | awk '/percentage/ {print $2}')
        bat_state=$(echo "$bat_info" | awk '/state/ {print $2}')
        battery_str="🔋 $bat_percent ($bat_state)"
    else
        battery_str="🔋 N/A"
    fi
elif [ -r /sys/class/power_supply/BAT0/capacity ]; then
    bat_percent=$(cat /sys/class/power_supply/BAT0/capacity)
    bat_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "?")
    battery_str="🔋 ${bat_percent}% ($bat_status)"
else
    battery_str="🔋 N/A"
fi

########################################
# CPU Load and Temp
########################################
# 1-minute load from uptime
cpu_load=$(awk '{print $1}' /proc/loadavg 2>/dev/null)

# CPU temp (lm-sensors or /sys)
if command -v sensors >/dev/null; then
    cpu_temp=$(sensors 2>/dev/null | awk '/^Package id 0:/ {print $4; exit}')
elif [ -r /sys/class/thermal/thermal_zone0/temp ]; then
    raw=$(cat /sys/class/thermal/thermal_zone0/temp)
    cpu_temp=$(awk "BEGIN {printf \"%.1f°C\", $raw/1000}")
else
    cpu_temp="N/A"
fi

cpu_str="🌡 $cpu_temp   ⚙ $cpu_load"

########################################
# Volume
########################################
if command -v pamixer >/dev/null; then
    vol=$(pamixer --get-volume-human 2>/dev/null)
elif command -v pactl >/dev/null; then
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1)
else
    vol="?"
fi
vol_str="🔊 $vol"

########################################
# Brightness
########################################
if command -v brightnessctl >/dev/null; then
    bright=$(brightnessctl -m | cut -d, -f4 2>/dev/null)
elif [ -r /sys/class/backlight/*/brightness ]; then
    cur=$(cat /sys/class/backlight/*/brightness | head -n1)
    max=$(cat /sys/class/backlight/*/max_brightness | head -n1)
    bright=$(awk "BEGIN {printf \"%.0f%%\", ($cur/$max)*100}")
else
    bright="?"
fi
bright_str="💡 $bright"

########################################
# Wi‑Fi
########################################
if command -v nmcli >/dev/null; then
    ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
    wifi_str="📶 ${ssid:-N/A}"
else
    wifi_str="📶 N/A"
fi

########################################
# COMPOSE HEADER
########################################

# Use multiple <span> rows (one per line). Pango markup allows \n for linebreaks!
header="<span weight='bold'>$time_str</span>"
header+="<span size='medium'>    $cpu_str  $vol_str   $bright_str   $wifi_str  $battery_str</span>"
echo -e "$header"
