-----------------
---- WINDOWS ----
-----------------

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = {
		class = "xwaylandvideobridge",
	},
	-- max_size = "1 1",
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	opacity = 0.0,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "float-images",
	match = {
		class = "Nsxiv",
	},
	float = true,
})

hl.window_rule({
	name = "float-vt",
	match = {
		class = "AgISOVirtualTerminal",
	},
	float = true,
})

hl.window_rule({
	name = "chat-workspaces",
	match = {
		class = "(?:discord|elecwhat)",
	},
	workspace = "special:chats",
})

-- hl.on("window.open", function(w)
-- 	if w.class ~= "discord" or w.class ~= "elecwhat" then
-- 		return
-- 	end
--
--   hl.dispatch()
-- end)

hl.on("window.open", function(w)
	if w.class ~= "zen" then
		return
	end
	if w.initial_title ~= "Zen Browser" then
		return
	end

	local ff_windows = hl.get_windows({ class = "zen" })
	if #ff_windows <= 1 then
		return
	end

	hl.dispatch(hl.dsp.window.float({ action = "set", window = w }))

	local sub
	sub = hl.on("window.title", function(tw)
		if tw.address ~= w.address then
			return
		end
		if
			tw.title == ""
			or tw.title == "Zen Browser"
			or tw.title == "about:blank"
			or tw.title:match("^about:.*Zen Browser$")
		then
			return
		end

		sub:remove()

		if tw.title:match("^Extension:") then
			hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600, window = tw }))
			hl.dispatch(hl.dsp.window.center({ window = tw }))
			hl.dispatch(hl.dsp.focus({ window = tw }))
		else
			hl.dispatch(hl.dsp.window.float({ action = "unset", window = tw }))
		end
	end)
end)
