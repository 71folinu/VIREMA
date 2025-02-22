started() {
	if ProcessExist("deemator_tor.exe") {
		return true
	} else {
		return false
	}
}

proxy_enable(*) {
	MsgBox("proxy_enable")
}

proxy_disable(*) {
	MsgBox("proxy_disable")
}

stop_clicked(*){
	MsgBox("stop_clicked")
	ProcessClose("deemator_tor.exe")
	proxy_disable()
	Reload
}

start_clicked(*){
	MsgBox("start_clicked")
	Run A_ComSpec ' /c ""C:\deemator\third_party\deemator_tor.exe" "-f" "C:\deemator\torrc" >"tor_log.txt""',,"Hide"
	proxy_enable()
	Reload
}