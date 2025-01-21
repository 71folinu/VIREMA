started() {
	if (Random() > 0.5) {
		return true
	} else {
		return false
	}
}

;class stop_clicked {
;	Call(args, *){
;		MsgBox("STOP")
;	}
;}

stop_clicked(GuiCtrlObj, Info){
	MsgBox("AAAAAAAAAA")
}