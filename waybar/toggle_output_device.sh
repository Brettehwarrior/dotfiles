#!/usr/bin/env bash

Headphones="alsa_output.pci-0000_00_1f.3.analog-stereo"
Speaker="alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3"

currentSink=$(pactl get-default-sink)

if [[ "$currentSink" == "$Speaker" ]]; then
    newSink="$Headphones"
else
    newSink="$Speaker"
fi

if ! pactl list short sinks | awk '{print $2}' | grep -Fxq "$newSink"; then
    echo "Sink does not exist: $newSink" >&2
    exit 1
fi

pactl set-default-sink "$newSink"

while read -r streamId sinkId _; do
    [[ -n "$streamId" ]] || continue
    pactl move-sink-input "$streamId" "$newSink"
done < <(pactl list short sink-inputs)

echo "Switched to: $newSink"