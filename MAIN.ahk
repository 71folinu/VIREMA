#Requires AutoHotkey v2.0
#NoTrayIcon
TraySetIcon "icon.ico", , true

;

window_title := "deemator 0.0"

;

main_window := Gui.Call(,window_title)
main_window.Add("Text", "+x110 +y10 +w1234 +h1234", "DEEMATOR").SetFont("s24")

;

main_window.Show("Center W400 H300")

;

while (WinExist(window_title)) {
	Sleep(1000*2)
}