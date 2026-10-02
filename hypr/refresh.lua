local mainMod = require("settings/keys").mainMod
hyprsfx = require("hyprsfx")

hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("killall -SIGUSR2 waybar")) -- reload waybar
hl.bind(mainMod .. " + F5", hyprsfx.add_missing_events) -- reload waybar