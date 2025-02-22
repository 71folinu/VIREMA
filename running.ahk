started() {
	if ProcessExist("deemator_tor.exe") {
		return true
	} else {
		return false
	}
}

stop_clicked(*){
	MsgBox("stop stub")
	Reload
}

start_clicked(*){
	MsgBox("start stub")
	Reload
}