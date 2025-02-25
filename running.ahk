started() {
	if ProcessExist("deemator_tor.exe") {
		return true
	} else {
		return false
	}
}

set_proxy_enabled(enabled) {
	MsgBox("set_proxy_enabled " . enabled)
}

stop_clicked(*){
	MsgBox("stop_clicked")
	ProcessClose("deemator_tor.exe")
	set_proxy_enabled(false)
	Reload
}

start_clicked(*){
	MsgBox("start_clicked")
	Run A_ComSpec ' /c ""C:\deemator\third_party\deemator_tor.exe" "-f" "C:\deemator\torrc" >"tor_log.txt""',,"Hide"
	set_proxy_enabled(true)
	Reload
}
