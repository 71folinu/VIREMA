#Requires AutoHotkey v2.0
#NoTrayIcon
TraySetIcon "icon.ico", , true

; ENABLING ADMIN RIGHTS
if not (A_IsAdmin or RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {
	try {
		if A_IsCompiled
			Run '*RunAs "' A_ScriptFullPath '" /restart'
		else
			Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
	}
}
Sleep(188)
if not (A_IsAdmin) {
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), "deemator installer"
	ExitApp
}

; INITIAL PROMPT
if (MsgBox("Do you want to intall deemator to this computer?", "deemator installer", 4) = "Yes") {
	MsgBox("Yes")
} else {
	MsgBox("else")
}
; create folders C:\deemator and C:\deemator\third_party
; FileInstall the files to C:\deemator\third_party
; FileInstall the files to C:\deemator\
; FileInstall a link on the desktop to start the program
