#Requires AutoHotkey v2.0
#NoTrayIcon
TraySetIcon "icon.ico", , true

; INCLUDES
#Include installation.ahk

; WINDOW VARS
window_title := "deemator 0.0"

; BULDING WINDOW
main_window := Gui.Call(,window_title)
main_window.Add("Text", "+x110 +y10 +w1234 +h1234", "DEEMATOR").SetFont("s24")
installed_text := ""
if (installed() = true) {
	installed_text := "Deemator is installed."
} else {
	installed_text := "Deemator is NOT installed."
}
main_window.Add("Text", "+x10 +y30 +w1234 +h1234", installed_text).SetFont("s12")

; SHOWING WINDOW
main_window.Show("Center W400 H300")

; HANDLING EXIT
while (WinExist(window_title)) {
	Sleep(1000/2)
}