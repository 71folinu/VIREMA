#Requires AutoHotkey v2.0
Persistent
#NoTrayIcon
TraySetIcon "icon.ico", , true

; INCLUDES
#Include installation.ahk
#include running.ahk

; GLOBAL CONSTANTS
window_title := "deemator 0.0"

;

; BULDING WINDOW
main_window := Gui.Call(,window_title)
main_window.Add("Text", "+x210 +y10 +w190 +h40", "DEEMATOR").SetFont("s24")
if (installed() = true) {
	main_window.Add("Text", "+x10 +y10 +w100 +h50 +Border", "Deemator is installed.").SetFont("s12")
	main_window.Add("Button", "+x10 +y60 +w100 +h50", "UNINSTALL").SetFont("s12")
} else {
	main_window.Add("Text", "+x10 +y10 +w100 +h50 +Border", "Deemator is NOT installed.").SetFont("s12")
	main_window.Add("Button", "+x10 +y60 +w100 +h50", "INSTALL").SetFont("s12")
}
if (started() = true) {
	main_window.Add("Text", "+x290 +y90 +w100 +h20 +Border +Center", "Started.").SetFont("s12")
	stop_button := main_window.Add("Button", "+x290 +y120 +w100 +h50", "STOP")
	stop_button.SetFont("s12")
	stop_button.OnEvent("Click", stop_clicked)
} else {
	main_window.Add("Text", "+x290 +y90 +w100 +h20 +Border +Center", "Stopped.").SetFont("s12")
	stop_button := main_window.Add("Button", "+x290 +y120 +w100 +h50", "START")
	stop_button.SetFont("s12")
	stop_button.OnEvent("Click", start_clicked)
}

;

; SHOWING WINDOW
main_window.Show("Center W400 H300")