local mainMod = require("settings/keys").mainMod
local programs = require("settings/programs")

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd(programs.systemMonitor))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("killall -SIGUSR2 waybar")) -- reload waybar

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -s --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("$HOME/.config/hypr/scripts/record-region"))

-- "Singleton" binds
function bindSingletonTitle(shortcut, specialWorkspaceId, regex, command)
    hl.bind(shortcut,function()
        
        -- Check if program already open
        local matches = {}
        for _, window in ipairs(hl.get_windows()) do
            if window.title:match(regex) then -- get_windows title search doesn't seem to use regex
                matches[#matches+1] = window
            end
        end

        if #matches > 0 then
            local workspace = hl.get_workspace("special:" .. specialWorkspaceId)
            if workspace.visible then
                hl.dispatch(hl.dsp.workspace.toggle_special(specialWorkspaceId))
            else
                hl.dispatch(hl.dsp.focus({ window = matches[1] }))
            end
        else
            hl.dispatch(hl.dsp.workspace.toggle_special(specialWorkspaceId))
            hl.dispatch(hl.dsp.exec_cmd(command))
        end
    end)
end

bindSingletonTitle(mainMod .. " + Q", "music", "ymc$", programs.terminal .. " " .. programs.music)
bindSingletonTitle(mainMod .. " + D", "discord", "discord", programs.discord)
hl.window_rule({
    match = { class = "discord"},
    pseudo = true
})
