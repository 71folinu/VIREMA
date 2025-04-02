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

update_log_window(*) {
	if FileExist("C:\deemator\tor_log.txt") {
		try {
			global log_window_text := FileRead("C:\deemator\tor_log.txt")
		} catch {
			MsgBox("Failed reading Tor logs. Try again.`nIf the issue persists, try reinstalling deemator.", window_title . ": ERROR")
		}