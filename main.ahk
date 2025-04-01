#Requires AutoHotkey v2.0
Persistent
#NoTrayIcon
TraySetIcon "icon.ico", , true
;@Ahk2Exe-SetName deemator
;@Ahk2Exe-SetVersion 0.2.0

; INCLUDES
#include running.ahk

; GLOBAL CONSTANTS
window_title := "deemator 0.2.0"
status_bar_refresh_period := 156*2

; ENABLING ADMIN RIGHTS
if not (A_IsAdmin or RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {
	try {
		if A_IsCompiled
			Run '*RunAs "' A_ScriptFullPath '" /restart'
		else
			Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
	}
}
Sleep(156)
if not (A_IsAdmin) {
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), window_title
	ExitApp
}

; BULDING WINDOW
main_window := Gui.Call(,window_title)
main_window.Add("Text", "+x105 +y10 +w190 +h40 +Center", "DEEMATOR").SetFont("s24")
status_bar := main_window.Add("StatusBar",, " Loading...")
status_bar.SetFont("s8")
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

; REFRESHING STATUS BAR
refresh_status_bar(*) {
	if (started()) {
		if (check_string_in_log("Bootstrapped 100% (done): Done")) {
			status_bar.SetText(" Connected! You may close the window now, connection will stay active.")
			return
		}
		if (check_string_in_log("Bootstrapped 1% (conn_pt): Connecting to pluggable transport")) {
			status_bar.SetText(" Connecting to tor network...")
			return
		}
		if (check_string_in_log("Starting with guard context `"bridges`"")) {
			if (!check_string_in_log("Read configuration file `"C:\deemator\torrc`".")) {
				ProcessClose("deemator_tor.exe")
				status_bar.SetText(" No torrc file found!!!")
				MsgBox("No torrc file found!!!`nReinstall deemator.", window_title . ": ERROR")
				ExitApp
				return
			}
			if (!check_string_in_log("Opened Socks listener connection (ready) on 127.0.0.1:9050")) {
				ProcessClose("deemator_tor.exe")
				status_bar.SetText(" Failed to open socks listener!!!")
				MsgBox("Failed to open socks listener!!!`nCheck your firewall settings.", window_title . ": ERROR")
				ExitApp
				return
			}
			if (!check_string_in_log("Parsing GEOIP IPv4 file C:\deemator\third_party\geoip.")) {
				ProcessClose("deemator_tor.exe")
				status_bar.SetText(" No geoip file found!!!")
				MsgBox("No geoip file found!!!`nReinstall deemator.", window_title . ": ERROR")
				ExitApp
				return
			}
			if (!check_string_in_log("Parsing GEOIP IPv6 file C:\deemator\third_party\geoip6.")) {
				ProcessClose("deemator_tor.exe")
				status_bar.SetText(" No geoip6 file found!!!")
				MsgBox("No geoip6 file found!!!`nReinstall deemator.", window_title . ": ERROR")
				ExitApp
				return
			}
			status_bar.SetText(" Starting tor process...")
			return
		}
		if (check_string_in_log("Tor can't help you if you use it wrong!")) {
			status_bar.SetText(" Configuring connection to tor network...")
			return
		}
	} else {
		status_bar.SetText(" Stopped.")
		return
	}
}
SetTimer(refresh_status_bar, status_bar_refresh_period)

; SHOWING WINDOW
main_window.Show("Center W400 H300")

; HANDLING WINDOW
close_main(*){
	ExitApp
}
main_window.OnEvent("Close", close_main)
main_window.OnEvent("Size", close_main)
