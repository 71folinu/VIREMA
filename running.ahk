; running.ahk - functions for app operation

enable_proxy() {
	if check_proxy_err_off_on() = 1 {
		if not click_wait_ImageSearch_in_folder("C:\deemator\img\03unchecked", 3) {
			MsgBox_ImageSearch_not_supported()
			return 0
		}
	}
}

disable_proxy() {
	
}

check_proxy_err_off_on() {
	RunWait "::{21EC2020-3AEA-1069-A2DD-08002B30309D}"
	Sleep(156*1)
	if not click_wait_ImageSearch_in_folder("C:\deemator\img\00browsersettings", 3) {
		MsgBox_ImageSearch_not_supported()
		return 0
	}
	if not click_wait_ImageSearch_in_folder("C:\deemator\img\01connections", 3) {
		MsgBox_ImageSearch_not_supported()
		return 0
	}
	if not click_wait_ImageSearch_in_folder("C:\deemator\img\02local", 3) {
		MsgBox_ImageSearch_not_supported()
		return 0
	}
	if wait_ImageSearch_in_folder("C:\deemator\img\03checked", 3) {
		return 2
	} else if wait_ImageSearch_in_folder("C:\deemator\img\03unchecked", 3) {
		return 1
	} else {
		MsgBox_ImageSearch_not_supported()
		return 0
	}
}

MsgBox_ImageSearch_not_supported() {
	MsgBox("Looks like your version of Windows (language, theme or scaling)`nis not supported.`nSetup proxy manually or contact developer at`nhttps://github.com/samid36360/deemator/issues.", window_title . ": ERROR")
}

click_wait_ImageSearch_in_folder(folder_full_path, timeout_secs) {
	if wait_ImageSearch_in_folder(folder_full_path, timeout_secs) {
		Sleep(156)
		Click(ImageSearch_in_folder_OutputVarX,ImageSearch_in_folder_OutputVarY)
		global ImageSearch_in_folder_OutputVarX := ""
		global ImageSearch_in_folder_OutputVarY := ""
		return 1
	} else {
		return 0
	}
}

wait_ImageSearch_in_folder(folder_full_path, timeout_secs) {
	Loop Ceil(timeout_secs*2) {
		Sleep(156*3)
		if (ImageSearch_in_folder(folder_full_path)) {
			return 1
		}
	}
	return 0
}

ImageSearch_in_folder(folder_full_path) {
	try {
		global ImageSearch_in_folder_OutputVarX := ""
		global ImageSearch_in_folder_OutputVarY := ""
		Loop Files folder_full_path . "\*.*" {
			ImageSearch &ImageSearch_in_folder_OutputVarX, &ImageSearch_in_folder_OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, A_LoopFileFullPath
			if ImageSearch_in_folder_OutputVarX and ImageSearch_in_folder_OutputVarY {
				return 1
			}
		}
		return 0
	} catch {
		MsgBox("ImageSearch_in_folder error.`nTry reinstalling deemator.", window_title . ": ERROR")
	}
}

started() {
	if ProcessExist("deemator_tor.exe") {
		return true
	} else {
		return false
	}
}

stop_clicked(*) {
	; MsgBox("stop_clicked")
	ProcessClose("deemator_tor.exe")
	disable_proxy()
	global tor_launch_ordered := 0
}

start_clicked(*) {
	; MsgBox("start_clicked")
	Run A_ComSpec ' /c ""C:\deemator\third_party\deemator_tor.exe" "-f" "C:\deemator\torrc" >"tor_log.txt""',,"Hide"
	enable_proxy()
	SetTimer(check_connection_success, -1560*47)
	global tor_launch_ordered := 1
}

check_connection_success(*) {
	if (started()) {
		if not (check_string_in_log("Bootstrapped 100% (done): Done")) {
			stop_clicked()
			MsgBox("Connection took too long and was aborted. Try again.`nIf the issue persists, try reinstalling deemator.", window_title . ": ERROR")
		}
	} else if tor_launch_ordered {
		try stop_clicked()
		MsgBox("Tor process failed to start. Try again.`nIf the issue persists, try reinstalling deemator.", window_title . ": ERROR")
	}
}

check_string_in_log(string) {
	Try {
		global log_string := FileRead("tor_log.txt")
	} catch {
		return 0
	}
	if (InStr(log_string, string)) {
		return 1
	} else {
		return 0
	}
}

; MsgBox(,,"T0.156")
; MsgBox
; Loading...

update_logs_window_field(*) {
	if WinExist(window_title . " - tor logs") and not WinActive(window_title . " - tor logs") {
		close_logs_window()
	}
	try {
		if logs_window_field.Text != FileRead("C:\deemator\tor_log.txt") {
			logs_window_field.Text := FileRead("C:\deemator\tor_log.txt")
			global logs_window_field_text_updated := 1
		}
	}
	if WinExist(window_title . " - tor logs") and logs_window_field_text_updated {
		Send("^{End}")
	}
	global logs_window_field_text_updated := 0
}

close_logs_window(*){
	logs_window.Destroy()
}

see_logs_button_clicked(*) {
	global logs_window := Gui.Call(,window_title . " - tor logs")
	global logs_window_field := logs_window.Add("Edit", "+x10 +y10 +w380 +h260 ReadOnly", "No logs were found.")
	Sleep(156)
	logs_window.Show("Center W400 H300")
	Send("^{End}")
	Sleep(156)
	logs_window.OnEvent("Close", close_logs_window)
	logs_window.OnEvent("Size", close_logs_window)
	logs_window.OnEvent("Escape", close_logs_window)
	logs_window.OnEvent("ContextMenu", close_logs_window)
	global logs_status_bar := logs_window.Add("StatusBar",, " Press ESC or close the window to return to main menu.")
	logs_status_bar.SetFont("s8")
}