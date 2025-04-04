started() {
	if ProcessExist("deemator_tor.exe") {
		return true
	} else {
		return false
	}
}

set_proxy_enabled(enabled) {
	; MsgBox("set_proxy_enabled " . enabled)
}

stop_clicked(*) {
	; MsgBox("stop_clicked")
	ProcessClose("deemator_tor.exe")
	set_proxy_enabled(false)
}

start_clicked(*) {
	; MsgBox("start_clicked")
	Run A_ComSpec ' /c ""C:\deemator\third_party\deemator_tor.exe" "-f" "C:\deemator\torrc" >"tor_log.txt""',,"Hide"
	set_proxy_enabled(true)
	SetTimer(check_connection_success, -1560*47)
}

check_connection_success(*) {
	if (started()) {
		if not (check_string_in_log("Bootstrapped 100% (done): Done")) {
			stop_clicked()
			MsgBox("Connection took too long and was aborted. Try again.`nIf the issue persists, try reinstalling deemator.", window_title . ": ERROR")
		}
	} else {
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