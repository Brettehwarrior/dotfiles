#!/bin/bash
get_col() {
    [[ $(niri msg --json focused-window) =~ pos_in_scrolling_layout\":\[([0-9]+) ]]
    echo "${BASH_REMATCH[1]}"
}

before=$(get_col)
niri msg action move-column-right
after=$(get_col)

if [[ $before == "$after" ]]; then
    cur=$(niri msg --json focused-output)
    [[ $cur =~ logical\":\{\"x\":(-?[0-9]+) ]]
    cur_x=${BASH_REMATCH[1]}

    has_right=0
    while read -r x; do
        if (( x > cur_x )); then has_right=1; break; fi
    done < <(niri msg --json outputs \
        | grep -oE '"logical":\{"x":-?[0-9]+' \
        | grep -oE -- '-?[0-9]+$')

    if (( has_right )); then
        niri msg action move-column-to-monitor-right
	niri msg action move-column-to-first
    fi
fi
