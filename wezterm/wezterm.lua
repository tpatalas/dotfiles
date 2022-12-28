-- https://wezfurlong.org/wezterm/
-- https://wezfurlong.org/wezterm/config/lua/config/index.html

local wezterm = require("wezterm")

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
	-- Term
	-- term = "xterm-256color",
	term = "wezterm",
	-- Font
	font = wezterm.font("MesloLGS NF", { weight = "Regular", italic = false }),
	font_shaper = "Harfbuzz",
	font_rules = {
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				family = "MesloLGS NF",
			}),
		},
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "MesloLGS NF",
			}),
		},
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "MesloLGS NF",
			}),
		},
	},
	bold_brightens_ansi_colors = true,
	font_size = 18,
	cell_width = 0.95,
	line_height = 1.05,
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	allow_square_glyphs_to_overflow_width = "Never",
	window_background_opacity = 0.7,
	-- Underline
	underline_position = -6,
	underline_thickness = 3,
	-- text_background_opacity = 0.55,
	adjust_window_size_when_changing_font_size = true,
	window_decorations = "RESIZE",
	window_padding = {
		left = 10,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_frame = {
		border_left_width = "0cell",
		border_right_width = "0cell",
		border_bottom_height = "0cell",
		border_top_height = "0cell",
		border_left_color = "None",
		border_right_color = "None",
		border_bottom_color = "None",
		border_top_color = "None",
	},
	window_close_confirmation = "NeverPrompt",
	use_resize_increments = true,
	dpi = 144,
	-- Tab_bar
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	-- colors
	colors = {
		background = "#1a1b26",
		tab_bar = {
			background = "None",
			active_tab = {
				bg_color = "None",
				fg_color = "#7BC6C7",
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = "None",
				fg_color = "#758299",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab_hover = {
				bg_color = "None",
				fg_color = "#3b3052",
				italic = false,
			},
			new_tab = {
				bg_color = "None",
				fg_color = "#808080",
			},
			new_tab_hover = {
				bg_color = "#3b3052",
				fg_color = "#3b3052",
				italic = false,
			},
		},
		cursor_bg = "gold",
		cursor_border = "None",
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
		{ key = "LeftArrow", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.MoveTabRelative(1) },
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
	},
}
