---------------------
---- KEYBINDINGS ----
---------------------

local terminal = "kitty"
local fileManager = "/usr/sbin/rofi -show filebrowser"
local menu = "/usr/sbin/rofi -show run"
local browser = "zen-browser"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + SPACE", function()
	hl.dispatch(hl.dsp.window.cycle_next({
		floating = not hl.get_active_window().floating,
	}))
end)
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(
	mainMod .. " + SHIFT + W",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" "/home/fellipe/Pictures/ScreenShots/$(date +%F-%T).png"; wl-copy < "/home/fellipe/Pictures/ScreenShots/$(date +%F-%T).png"'
	)
)
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with right hand keys
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + ccedilla", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + ccedilla", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + C", hl.dsp.workspace.toggle_special("chats"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.move({ workspace = "special:chats" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + tab", function()
	local layouts = { "scrolling", "dwindle", "master", "monocle" }
	local workspace = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

	local next_layout = "dwindle"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end)
