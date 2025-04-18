; main.ahk

#Requires AutoHotkey v2.0
CoordMode "Pixel", "Screen"
CoordMode "Mouse", "Screen"
Persistent
#NoTrayIcon
TraySetIcon "icon.ico", , true
;@Ahk2Exe-SetName VIREMA
;@Ahk2Exe-SetVersion 0.3.0

; INCLUDES
#include running.ahk

; GLOBAL CONSTANTS
global exit_allowed := 1
global window_title := "VIREMA 0.3.0"
global status_bar_refresh_period := 156*2
global wait_ImageSearch_in_folder_time_sec := 1
global data_v2__arr := []
global data_v2__arr__capacity := 15
global data_v2__arr__index__test := data_v2__arr__capacity + 0

; ENABLING ADMIN RIGHTS
if not (A_IsAdmin or RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {
	try {
		if A_IsCompiled
			Run '*RunAs "' A_ScriptFullPath '" /restart'
		else
			Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
	}
}
Sleep(156*4)
if not (A_IsAdmin) {
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), window_title
	ExitApp
}

; GLOBAL VARIABLES
if FileExist("reset.userdata.virema") and FileExist("userdata.virema") {
	FileDelete("userdata.virema")
	FileDelete("reset.userdata.virema")
}
data_update()

; BULDING WINDOW
global main_window := Gui.Call(,window_title)
main_window.Add("Text", "+x105 +y10 +w190 +h40 +Center", "VIREMA").SetFont("s24")
global status_bar := main_window.Add("StatusBar",, " Loading...")
status_bar.SetFont("s8")
global title_status := main_window.Add("Text", "+x150 +y60 +w100 +h30 +Center", "Loading...")
title_status.SetFont("s13 cAAAAAA")
global startstop_button := main_window.Add("Button", "+x10 +y100 +w120 +h80", "Loading...")
startstop_button.SetFont("s11")
global see_logs_button := main_window.Add("Button", "+x10 +y190 +w120 +h80", "See logs")
see_logs_button.SetFont("s11")
see_logs_button.OnEvent("Click", see_logs_button_clicked)
global set_bridge_button := main_window.Add("Button", "+x140 +y190 +w120 +h80", "Set bridge")
set_bridge_button.SetFont("s11")
set_bridge_button.OnEvent("Click", set_bridge_button_pressed)
global force_stop_button := main_window.Add("Button", "+x270 +y190 +w120 +h80", "FORCE`nSTOP")
force_stop_button.SetFont("s11")
force_stop_button.OnEvent("Click", force_stop_button__clicked)

; REFRESHING STATUS BAR
refresh_status(*) {
	if WinExist(window_title) and not WinActive(window_title) and exit_allowed {
		ExitApp
	}
	if WinExist(window_title . " - tor logs") and not WinActive(window_title . " - tor logs") {
		WinClose(window_title . " - tor logs")
	}
	update_logs_window_field()
	if (started()) {
		if (check_string_in_log("Bootstrapped 100% (done): Done")) {
			status_bar.SetText(" Connected! You may close the window now, connection will stay active.")
			if not title_status.Text = "Connected." {
				title_status.Text := "Connected."
				title_status.SetFont("s13 c00BB00")
				startstop_button.Text := "STOP"
				startstop_button.OnEvent("Click", start_clicked, 0)
				startstop_button.OnEvent("Click", stop_clicked)
			}
			return
		}
		if not title_status.Text = "Started." {
			title_status.Text := "Started."
			title_status.SetFont("s13 c779977")
			startstop_button.Text := "STOP"
			startstop_button.OnEvent("Click", start_clicked, 0)
			startstop_button.OnEvent("Click", stop_clicked)
		}
		if (check_string_in_log("Bootstrapped 1% (conn_pt): Connecting to pluggable transport")) {
			status_bar.SetText(" Connecting to tor network...")
			return
		}
		if (check_string_in_log("Starting with guard context `"bridges`"")) {
			if (!check_string_in_log("Read configuration file `"C:\VIREMA\torrc`".")) {
				ProcessClose("VIREMA_tor.exe")
				status_bar.SetText(" No torrc file found!!!")
				MsgBox("No torrc file found!!!`nReinstall VIREMA.", window_title . ": ERROR")
				ExitApp
				return
			}
			if (!check_string_in_log("Opened Socks listener connection (ready) on 127.0.0.1:9050")) {
				ProcessClose("VIREMA_tor.exe")
				status_bar.SetText(" Failed to open socks listener!!!")
				MsgBox("Failed to open socks listener!!!`nCheck your firewall settings.", window_title . ": ERROR")
				ExitApp
				return
			}
			if (!check_string_in_log("Parsing GEOIP IPv4 file C:\VIREMA\third_party\geoip.")) {
				ProcessClose("VIREMA_tor.exe")
				status_bar.SetText(" No geoip file found!!!")
				MsgBox("No geoip file found!!!`nReinstall VIREMA.", window_title . ": ERROR")
				ExitApp
				return
			}
			if (!check_string_in_log("Parsing GEOIP IPv6 file C:\VIREMA\third_party\geoip6.")) {
				ProcessClose("VIREMA_tor.exe")
				status_bar.SetText(" No geoip6 file found!!!")
				MsgBox("No geoip6 file found!!!`nReinstall VIREMA.", window_title . ": ERROR")
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
		if not title_status.Text = "Stopped." {
			title_status.Text := "Stopped."
			title_status.SetFont("s13 c990000")
			startstop_button.Text := "START"
			startstop_button.OnEvent("Click", stop_clicked, 0)
			startstop_button.OnEvent("Click", start_clicked)
		}
		status_bar.SetText(" Stopped.")
		return
	}
}
SetTimer(refresh_status, status_bar_refresh_period)
Sleep(156)

; SHOWING WINDOW
main_window.Show("Center W400 H300")
global main_window_pos_x := ""
global main_window_pos_y := ""
global main_window_pos_w := ""
global main_window_pos_h := ""
main_window.GetPos(&main_window_pos_x,&main_window_pos_y,&main_window_pos_w,&main_window_pos_h)

; HANDLING WINDOW
close_main(*){
	ExitApp
}
main_window.OnEvent("Close", close_main)
main_window.OnEvent("Size", close_main)
main_window.OnEvent("Escape", close_main)

; DEBUG
if (not A_IsCompiled) {
	global exit_allowed := 0
	test__all()
	global exit_allowed := 1
}
