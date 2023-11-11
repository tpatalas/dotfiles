-- https://wezfurlong.org/wezterm/config/lua/config/index.html

local wezterm = require("wezterm")

local function convert_homedir(path)
	local cwd = path
	return cwd:gsub("^" .. wezterm.home_dir, "~")
end

local function basename(s)
	return string.gsub(s, "/$", ""):gsub("(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local proc = basename(tab.active_pane.foreground_process_name)
	local cwd = convert_homedir(tab.active_pane.current_working_dir:gsub("^file://", ""))
	cwd = basename(cwd)
	local title = " [" .. tab.tab_index + 1 .. "] " .. cwd .. ":" .. proc .. " "
	return {
		{ Text = wezterm.truncate_right(title, max_width) },
	}
end)

local mykeys = {}
for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(mykeys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

return {
	-- color_scheme = "tokyonight",
	-- Term
	-- term = "xterm-256color",
	term = "wezterm",
	-- Font
	-- More NerdFont: https://www.nerdfonts.com/font-downloads
	font = wezterm.font_with_fallback({
		{
			family = "JetBrainsMonoNL Nerd Font",
			weight = "Bold",
			stretch = "Expanded",
			italic = false,
		},
		{
			family = "FiraCode Nerd Font",
			harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
			weight = "Regular",
			stretch = "Expanded",
			italic = false,
		},
		{
			family = "Iosevka Nerd Font",
			harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
			weight = "DemiBold",
			stretch = "Expanded",
			italic = false,
		},
		"Symbols Nerd Font",
	}),
	font_shaper = "Harfbuzz",
	front_end = "WebGpu",
	bold_brightens_ansi_colors = "BrightOnly",
	font_size = 15,
	cell_width = 1.0,
	line_height = 1.0,
	freetype_load_target = "Normal", -- Normal, Light, Mono, HorizontalLcd
	freetype_load_flags = "DEFAULT", -- DEFAULT, NO_HINTING, NO_BITMAP, FORCE_AUTOHINT, MONOCHROME, NO_AUTOHINT
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	window_background_opacity = 0.8,
	macos_window_background_blur = 10,
	underline_position = -3,
	underline_thickness = 1,
	window_decorations = "INTEGRATED_BUTTONS", -- NONE | TITLE | RESIZE | INTEGRATED_BUTTONS
	window_padding = {
		left = 0,
		right = 0,
		top = 5,
		bottom = 0,
	},
	audible_bell = "Disabled",
	window_frame = {
		font = wezterm.font({ family = "Roboto", weight = "Bold" }),
		font_size = 12,
		active_titlebar_bg = "#202123",
		inactive_titlebar_bg = "#202123",
		border_left_width = "0.0cell",
		border_right_width = "0.0cell",
		border_bottom_height = "0.0cell",
		border_top_height = "0.0cell",
		border_left_color = "None",
		border_right_color = "None",
		border_bottom_color = "None",
		border_top_color = "None",
	},
	window_close_confirmation = "NeverPrompt",
	use_resize_increments = false,
	-- Tab_bar
	enable_tab_bar = true,
	use_fancy_tab_bar = true,
	tab_max_width = 50,
	tab_bar_at_bottom = false,
	-- colors
	colors = {
		-- https://github.com/rebelot/kanagawa.nvim/blob/master/extras/wezterm.lua
		foreground = "#dcd7ba",
		background = "#1f1f28",
		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",
		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",
		scrollbar_thumb = "#16161d",
		split = "#16161d",
		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
		tab_bar = {
			background = "#1f1f28",
			active_tab = {
				bg_color = "#35363A",
				fg_color = "#7BC6C7",
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = "#202123",
				fg_color = "#758299",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab_hover = {
				bg_color = "#202124",
				fg_color = "#7BC6C7",
				italic = false,
			},
			new_tab = {
				bg_color = "#202124",
				fg_color = "#808080",
			},
			new_tab_hover = {
				bg_color = "#35363A",
				fg_color = "#7BC6C7",
				italic = false,
			},
		},
	},
	-- Cursor
	default_cursor_style = "BlinkingBar",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 700,
	cursor_thickness = 2,
	-- Unicode
	unicode_version = 14,
	-- animation
	animation_fps = 60,
	-- Update
	check_for_updates = true,
	check_for_updates_interval_seconds = 86400,
	-- keys
	keys = {
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.CloseCurrentTab({ confirm = false }),
		},
		{
			key = "w",
			mods = "CMD",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},
		{
			key = "/",
			mods = "CMD|ALT",
			action = wezterm.action.Search({ CaseInSensitiveString = "" }),
		},
		{ key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action.MoveTabRelative(1) },
		{ key = "LeftArrow", mods = "CMD|ALT", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "RightArrow", mods = "CMD|ALT", action = wezterm.action.ActivateTabRelative(1) },
		{
			key = "|",
			mods = "CMD|ALT|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "_",
			mods = "CMD|ALT|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "UpArrow",
			mods = "CMD|ALT|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "DownArrow",
			mods = "CMD|ALT|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "RightArrow",
			mods = "CMD|ALT|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "LeftArrow",
			mods = "CMD|ALT|SHIFT",
			action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "~",
			mods = "CMD|ALT|SHIFT",
			action = wezterm.action.PaneSelect({
				alphabet = "1234567890",
			}),
		},
		{
			key = "UpArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "DownArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "UpArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "DownArrow",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "`",
			mods = "CTRL|CMD",
			action = wezterm.action.ActivatePaneDirection("Next"),
		},
		{ key = "F1", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F2", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F3", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F4", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F5", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F6", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F7", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F8", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F9", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F10", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F11", action = wezterm.action.DisableDefaultAssignment },
		{ key = "F12", action = wezterm.action.DisableDefaultAssignment },
	},
}
