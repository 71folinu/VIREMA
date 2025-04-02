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

stop_clicked(*){
	; MsgBox("stop_clicked")
	ProcessClose("deemator_tor.exe")
	set_proxy_enabled(false)
}

start_clicked(*){
	; MsgBox("start_clicked")
	Run A_ComSpec ' /c ""C:\deemator\third_party\deemator_tor.exe" "-f" "C:\deemator\torrc" >"tor_log.txt""',,"Hide"
	set_proxy_enabled(true)
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
