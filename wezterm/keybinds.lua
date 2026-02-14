local wezterm = require("wezterm")
local act = wezterm.action

return {
	keys = {
		--================
		-- workspace関連
		--================
		{
			mods = "LEADER",
			key = "w",
			action = act.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }),
		},

		{
			-- Rename workspace
			mods = "LEADER",
			key = "$",
			action = act.PromptInputLine({
				description = "(wezterm) Set workspace title:",
				action = wezterm.action_callback(function(win, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},

		{
			-- Create new workspace
			mods = "LEADER|SHIFT",
			key = "W",
			action = act.PromptInputLine({
				description = "(wezterm) Create new workspace:",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},

		--================
		-- ウィンドウ関連
		--================
		{ key = "n", mods = "SUPER", action = act.SpawnWindow },

		--================
		-- タブ関連
		--================
		-- タブ移動
		{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
		{ key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "1", mods = "CTRL", action = act.ActivateTab(0) },
		{ key = "2", mods = "CTRL", action = act.ActivateTab(1) },
		{ key = "3", mods = "CTRL", action = act.ActivateTab(2) },
		{ key = "4", mods = "CTRL", action = act.ActivateTab(3) },
		{ key = "5", mods = "CTRL", action = act.ActivateTab(4) },
		{ key = "6", mods = "CTRL", action = act.ActivateTab(5) },
		{ key = "7", mods = "CTRL", action = act.ActivateTab(6) },
		{ key = "8", mods = "CTRL", action = act.ActivateTab(7) },
		-- 新規タブ生成
		{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
		-- タブを閉じる
		{ key = "w", mods = "SHIFT|SUPER", action = act.CloseCurrentTab({ confirm = true }) },

		--================
		-- pane関連
		--================
		-- 水平分割
		{ key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- 垂直分割
		{ key = "d", mods = "SHIFT|SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- pane間移動
		{ key = "[", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
		{ key = "]", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
		{ key = "=", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
		{ key = "-", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
		-- paneを閉じる
		{ key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
		-- paneのズーム
		{ key = "Z", mods = "CTRL", action = act.TogglePaneZoomState },
		{ key = "Z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
		{ key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },

		-- [[フォント]]
		{ key = "+", mods = "SHIFT|SUPER", action = act.IncreaseFontSize },
		{ key = "-", mods = "SHIFT|SUPER", action = act.DecreaseFontSize },
		{ key = "0", mods = "SUPER", action = act.DecreaseFontSize },

		-- サイズ変更(現状未定義)
		-- { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Left', 1 } },
		-- { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Right', 1 } },
		-- { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Up', 1 } },
		-- { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize{ 'Down', 1 } },

		--================
		-- 表示関連
		--================
		-- ぼかしON/OFF(現状macのみでしか機能しない)
		{
			key = "u",
			mods = "SUPER",
			action = wezterm.action_callback(function(window, pane)
				local overrides = window:get_config_overrides() or {}

				-- 現在値を取得（未設定なら 0 扱い）
				local current = overrides.macos_window_background_blur or 0

				if current == 0 then
					overrides.macos_window_background_blur = 50
					overrides.window_background_opacity = 0.85
				else
					overrides.macos_window_background_blur = 0
					overrides.window_background_opacity = 0.60
				end

				window:set_config_overrides(overrides)
			end),
		},

		--================
		-- スクロール
		--================
		{ key = "k", mods = "SUPER", action = act.ScrollByLine(-10) },
		{ key = "j", mods = "SUPER", action = act.ScrollByLine(10) },

		--================
		-- モード変更
		--================
		{ key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
		{ key = "X", mods = "CTRL", action = act.ActivateCopyMode },
		{ key = "X", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },

		--================
		-- その他
		--================

		-- コマンドパレット表示
		{ key = "P", mods = "SHIFT|SUPER", action = act.ActivateCommandPalette },

		-- デバッグオーバーレイ表示
		{ key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },

		-- コピー・ペースト
		{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
		-- { key = 'U', mods = 'CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
		-- { key = 'U', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
		-- { key = 'u', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
		{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
		-- { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
		-- { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
		-- { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },

		-- まだ理解できていないのでそのまま
		-- { key = 'F', mods = 'CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
		-- { key = 'F', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
		-- { key = 'K', mods = 'CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
		-- { key = 'K', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
		-- { key = 'f', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
		-- { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
		-- { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
		-- { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },
		-- { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
		-- { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
		-- { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
		{
			key = "Enter",
			mods = "SHIFT",
			action = wezterm.action_callback(function(window, pane)
				local proc = pane:get_foreground_process_name()
				-- プロセス名に 'codex' が含まれているか判定
				-- nilチェックと小文字化を行うとより確実です
				if proc and proc:lower():find("codex") then
					-- codex実行時は改行コード（例：Ctrl+j）を送信
					window:perform_action(act.SendKey({ key = "j", mods = "CTRL" }), pane)
				else
					-- codex以外の時は、本来の「Shift+Enter」をそのまま送信
					-- callbackの中で自分自身と同じキーを送るのではなく、
					-- SendStringで生の改行コードを送るか、あるいは単純なkey assignmentに戻します。
					window:perform_action(act.SendKey({ key = "Enter", mods = "SHIFT" }), pane)
				end
			end),
		},
	},

	key_tables = {
		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "g", mods = "CTRL", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q", mods = "NONE", action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({
					{ CopyTo = "ClipboardAndPrimarySelection" },
					{ Multiple = { "ScrollToBottom", { CopyMode = "Close" } } },
				}),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},

		search_mode = {
			{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},
	},
}
