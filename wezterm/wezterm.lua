-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- This is where you actually apply your config choices.

-- or, changing the font size and color scheme.
config.font = wezterm.font("UDEV Gothic 35NF")
config.font_size = 14
-- config.color_scheme = 'Catppuccin Frappe'
config.color_scheme = "Tokyo Night Moon"

--
config.use_ime = true

-- ウィンドウに関する設定
config.window_background_opacity = 0.85
config.window_decorations = "RESIZE" -- タイトルバー削除

-- タブバーの設定
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

-- アクティブなタブの強調表示
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)

config.foreground_text_hsb = {
	hue = 1.0, -- 色相
	saturation = 1.1, -- 彩度
	brightness = 1.2, -- 明るさ
}

-- アクティブなペインの枠線を強調表示
config.inactive_pane_hsb = {
	saturation = 0.9, -- 彩度
	brightness = 0.5, -- 明るさ
}

-- キーバインドの読み込み
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
-- デフォルトのキーバインドを無効
config.disable_default_key_bindings = true

-- Finally, return the configuration to wezterm:
return config
