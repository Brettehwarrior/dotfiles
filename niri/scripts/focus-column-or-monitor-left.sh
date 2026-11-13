#!/bin/bash

get_col() {
    local w
    w=$(niri msg --json focused-window)
    [[ $w =~ pos_in_scrolling_layout\":\[([0-9]+) ]]
    printf '%s' "${BASH_REMATCH[1]}"
}

before=$(get_col)
niri msg action focus-column-left
after=$(get_col)

if [[ $before == "$after" ]]; then
    cur=$(niri msg --json focused-output)
    [[ $cur =~ logical\":\{\"x\":(-?[0-9]+) ]]
    cur_x=${BASH_REMATCH[1]}

    left=0
    while read -r x; do
        if (( x < cur_x )); then left=1; break; fi
    done < <(niri msg --json outputs \
        | grep -oE '"logical":\{"x":-?[0-9]+' \
        | grep -oE -- '-?[0-9]+$')

    if (( left )); then
        exec niri msg action focus-monitor-left
    fi
fi

