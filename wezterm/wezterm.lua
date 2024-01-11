-- https://wezfurlong.org/wezterm/config/lua/config/index.html

local wezterm = require("wezterm")
local act = wezterm.action

local function prepare_command(pane, command)
	local cwd_uri = pane:get_current_working_dir()
	local cwd = nil

	if cwd_uri then
		cwd_uri = cwd_uri:sub(8)
		local slash = cwd_uri:find("/")
		if slash then
			cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
				return string.char(tonumber(hex, 16))
			end)
		end
	end

	return "cd '" .. cwd .. "' && " .. command
end

wezterm.on("augment-command-palette", function(window, pane)
	return {
		{
			brief = "Rename tab",
			icon = "md_rename_box",

			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
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
	-- color_scheme = "catppuccin-mocha",
	color_scheme = "MaterialOcean",
	-- Term
	term = "wezterm",
	-- Font
	-- More NerdFont: https://www.nerdfonts.com/font-downloads
	font = wezterm.font_with_fallback({
		{
			family = "JetBrainsMonoNL Nerd Font",
			weight = "Regular",
			-- stretch = "Expanded",
			italic = false,
		},
	}),
	font_shaper = "Harfbuzz",
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	bold_brightens_ansi_colors = true,
	font_size = 14,
	cell_width = 1.0,
	line_height = 1.0,
	-- freetype_load_target = "Normal", -- Normal, Light, Mono, HorizontalLcd
	-- freetype_load_flags = "NO_HINTING", -- DEFAULT, NO_HINTING, NO_BITMAP, FORCE_AUTOHINT, MONOCHROME, NO_AUTOHINT
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.0,
	},
	window_background_opacity = 0.80,
	macos_window_background_blur = 30,
	underline_position = -3,
	underline_thickness = 1,
	window_decorations = "RESIZE", -- NONE | TITLE | RESIZE | INTEGRATED_BUTTONS
	window_padding = {
		left = 0,
		right = 0,
		top = 10,
		bottom = 0,
	},
	audible_bell = "Disabled",
	window_frame = {
		font = wezterm.font({ family = "Roboto", weight = "Bold" }),
		font_size = 13,
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
	enable_tab_bar = false,
	use_fancy_tab_bar = true,
	tab_max_width = 50,
	tab_bar_at_bottom = false,
	-- colors
	colors = {
		tab_bar = {
			background = "#1f1f28",
			active_tab = {
				bg_color = "#35363A",
				fg_color = "#e8eaed",
				intensity = "Normal",
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
				fg_color = "#e8eaed",
				italic = false,
			},
			new_tab = {
				bg_color = "#202124",
				fg_color = "#808080",
			},
			new_tab_hover = {
				bg_color = "#35363A",
				fg_color = "#e8eaed",
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
	animation_fps = 5,
	-- Update
	check_for_updates = true,
	check_for_updates_interval_seconds = 86400,
	-- keys

	keys = {
		-- tabs
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		{ key = "[", mods = "CMD|ALT", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "]", mods = "CMD|ALT", action = wezterm.action.MoveTabRelative(1) },
		{ key = "[", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "]", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "-", mods = "CMD|SHIFT", action = wezterm.action.ShowTabNavigator },

		--- rename tab
		{
			key = "r",
			mods = "CMD",
			action = wezterm.action_callback(function(window, pane)
				window:perform_action(
					act.PromptInputLine({
						description = "Enter new name for tab",
						action = wezterm.action_callback(function(window, pane, line)
							if line then
								window:active_tab():set_title(line)
							end
						end),
					}),
					pane
				)
			end),
		},

		-- command Palette
		{ key = "p", mods = "CMD", action = wezterm.action.ActivateCommandPalette },
		-- copy Mode
		-- more info: https://wezfurlong.org/wezterm/config/lua/keyassignment/CopyMode/index.html
		{ key = "c", mods = "CMD|SHIFT", action = wezterm.action.ActivateCopyMode },
		-- swpan window
		{ key = "N", mods = "CMD", action = wezterm.action.SpawnWindow },

		-- disable defaults
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
		-- open lazygit with current wd in a new tab
		{
			key = "l",
			mods = "CMD",
			action = wezterm.action_callback(function(window, pane)
				local command = prepare_command(pane, "lazygit")
				window:perform_action(
					act.SpawnCommandInNewTab({
						args = { "sh", "-lc", command },
					}),
					pane
				)
			end),
		},
		{
			key = "n",
			mods = "CMD",
			action = wezterm.action_callback(function(window, pane)
				local command = prepare_command(pane, "nvim")
				window:perform_action(
					act.SpawnCommandInNewTab({
						args = { "sh", "-lc", command },
					}),
					pane
				)
			end),
		},
	},
}
