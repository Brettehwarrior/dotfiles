
local monitors = require("settings/monitors")

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = monitors.right,
    mode     = "1920x1080@164.60Hz",
    position = "1920x0",
    scale    = "auto",
})
hl.monitor({
    output   = monitors.left,
    mode     = "1920x1080@164.60Hz",
    position = "0x0",
    scale    = "auto",
})