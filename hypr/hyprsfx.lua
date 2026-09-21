-- https://codeberg.org/Gapva/hyprsfx

local M = {}

local home = os.getenv("HOME")
local sounds_dir = home .. "/.config/hypr/sounds"
local sounds_map_path = home .. "/.config/hypr/sounds.lua"

M.enabled = true
M.volume = 1.0 -- percentage, not decibels

local function file_exists(path)
	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	else
		return false
	end
end

function M.play(file)
	if not M.enabled then
		return
	end
	hl.exec_cmd(string.format("pw-play --volume %s '%s/%s'", tostring(M.volume), sounds_dir, file))
end

function M.play_random(subdir)
	local dir = sounds_dir .. "/" .. subdir
	local files = {}

	local p = io.popen(string.format("find '%s' -maxdepth 1 -type f", dir))
	if p then
		for line in p:lines() do
			table.insert(files, line)
		end
		p:close()
	end

	if #files == 0 or not M.enabled then
		return
	end

	local pick = files[math.random(#files)]
	hl.exec_cmd(string.format("pw-play '%s'", pick))
end

function M.toggle()
	M.enabled = not M.enabled
	hl.notification.create({
		text = "hyprsfx " .. (M.enabled and "enabled" or "disabled"),
		timeout = 1000,
		icon = "info",
	})
end

function M.setup()
	-- pop/latency mitigation
	hl.on("hyprland.start", function()
		hl.exec_cmd("pw-play --rate=48000 --channels=2 --format=s16 --raw /dev/zero")
	end)

	if not file_exists(sounds_map_path) then
		return
	end

	local sounds = dofile(sounds_map_path)
	for event, file in pairs(sounds) do
		hl.on(event, function()
			M.play(file)
		end)
	end
end

return M
