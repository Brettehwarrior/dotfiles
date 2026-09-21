hyprsfx = dofile(os.getenv("HOME") .. "/.config/hypr/hyprsfx.lua")
hyprsfx.setup()

require("monitors")
require("autostart")
require("environmentVariables")
require("permissions")
require("lookAndFeel")
require("misc")
require("input")

require("keybindings/programs")
require("keybindings/workspaces")
require("keybindings/mediaKeys")

require("windowWorkspaceRules")
require("darkMode")
require("wallpaper")
