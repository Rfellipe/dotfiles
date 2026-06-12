-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd(
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE && systemctl --user start hyprland-session.target"
	)
	hl.exec_cmd("waybar & hyprpaper & swaync & discord")
	hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
	hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' ") -- for GTK4 apps
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-color-scheme 'prefer-dark'") -- for GTK4 apps
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Breeze-Dark'")
	hl.exec_cmd(
		"command -v xwaylandvideobridge >/dev/null 2>&1 && ! pgrep -f '(^|/)xwaylandvideobridge($| )' >/dev/null 2>&1 && xwaylandvideobridge"
	)
end)
