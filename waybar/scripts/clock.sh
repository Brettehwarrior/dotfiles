#!/bin/sh

text="📅 $(date '+%h %-d, %Y') 🕒 $(date '+%-I:%M %p')"
calendar="$(
    cal --color=always 2>/dev/null |
    sed \
        -e 's/\x1b\[7m/<span background="#f1c40f" foreground="#ffffff">/g' \
        -e 's/\x1b\[0m/<\/span>/g' \
        -e 's/\x1b\[[0-9;]*m//g'
)"

jq -cn \
    --arg text "$text" \
    --arg tooltip "$calendar" \
    '{text: $text, tooltip: $tooltip}'