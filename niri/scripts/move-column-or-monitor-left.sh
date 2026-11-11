#!/bin/bash

win=$(niri msg --json focused-window)
[[ $win =~ pos_in_scrolling_layout\":\[([0-9]+) ]]
col=${BASH_REMATCH[1]}

if [[ $col == 1 ]]; then
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
        niri msg action move-column-to-monitor-left
        exec niri msg action move-column-to-last
    fi
fi

exec niri msg action move-column-left
