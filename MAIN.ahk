#Requires AutoHotkey v2.0
Persistent
#NoTrayIcon
TraySetIcon "icon.ico", , true

; INCLUDES
#include running.ahk

; GLOBAL CONSTANTS
window_title := "deemator 0.1.0"
recheck_timer_period := 5000

; ENABLING ADMIN RIGHTS
if not (A_IsAdmin or RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {
	try {
		if A_IsCompiled
			Run '*RunAs "' A_ScriptFullPath '" /restart'
		else
			Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
	}
}
Sleep(256)
if not (A_IsAdmin) {
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), window_title
	ExitApp
}

; SETUP
recheck_timer_function(*) {
	; empty for now
}
SetTimer(recheck_timer_function, recheck_timer_period)

; BULDING WINDOW
main_window := Gui.Call(,window_title)
main_window.Add("Text", "+x105 +y10 +w190 +h40 +Center", "DEEMATOR").SetFont("s24")
if (started() = true) {
	main_window.Add("Text", "+x150 +y60 +w100 +h30 +Center", "Started.").SetFont("s13 c009900")
	stop_button := main_window.Add("Button", "+x10 +y100 +w100 +h50", "STOP")
	stop_button.SetFont("s11")
	stop_button.OnEvent("Click", stop_clicked)
} else {
	main_window.Add("Text", "+x150 +y60 +w100 +h30 +Center", "Stopped.").SetFont("s13 c990000")
	stop_button := main_window.Add("Button", "+x10 +y100 +w100 +h50", "START")
	stop_button.SetFont("s11")
	stop_button.OnEvent("Click", start_clicked)
}

;

; SHOWING WINDOW
main_window.Show("Center W400 H300")

; HANDLING WINDOW
close_main(*){
	ExitApp
}
main_window.OnEvent("Close", close_main)
main_window.OnEvent("Size", close_main)
