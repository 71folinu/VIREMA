; running.ahk - functions for app operation

data_var_decrypt(data_var_decrypt_var_in) {
	global data_var_decrypt_str_in := String(data_var_decrypt_var_in)
	if data_var_decrypt_str_in = "0" {
		return "NO DATA"
	}
	global data_var_decrypt_str_out := ""
	Loop Parse data_var_decrypt_str_in, " " {
		global data_var_decrypt_str_out := data_var_decrypt_str_out . Chr(Number(A_LoopField))
	}
	return data_var_decrypt_str_out
}

data_var_encrypt(var_in) {
	str_in := String(var_in)
	str_out := ""
	Loop {
		if A_Index = 1 {
			str_out := Ord(SubStr(str_in,A_Index,1))
		} else if A_index <= StrLen(str_in) {
			str_out := str_out . " " . Ord(SubStr(str_in,A_Index,1))
		} else {
			Break
		}
	}
	return str_out
}

data_MsgBox(*) {
	MsgBox(data_launch_count . "`n" . data_custom_text . "`n" . data_placeholder_0 . "`n" . data_placeholder_1 . "`n" . data_debug_set . "`n" . data_datetime_utc . "`n" . data_end_line, "data.virema")
}

data_update(*) {
	data_read()
	global data_launch_count := data_launch_count + 1
	global data_datetime_utc := A_NowUTC
	data_write()
}

data_write(*) {
	if FileExist("data.virema") {
		FileDelete("data.virema")
	}
	FileAppend(data_var_encrypt(data_launch_count) . "`n", "data.virema")
	FileAppend(data_var_encrypt(data_custom_text) . "`n", "data.virema")
	FileAppend(data_var_encrypt(data_placeholder_0) . "`n", "data.virema")
	FileAppend(data_var_encrypt(data_placeholder_1) . "`n", "data.virema")
	FileAppend(data_var_encrypt(data_debug_set) . "`n", "data.virema")
	FileAppend(data_var_encrypt(data_datetime_utc), "data.virema")
	try {
		FileAppend(data_var_encrypt(data_end_line), "data.virema")
	} catch {
		if FileExist("data.virema") {
			FileDelete("data.virema")
			Reload
		}
	}
}

data_read(*) {
	Loop Read "data.virema" {
		if (A_Index = 1) {
			global data_launch_count := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 2) {
			global data_custom_text := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 3) {
			global data_placeholder_0 := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 4) {
			global data_placeholder_1 := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 5) {
			global data_debug_set := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 6) {
			global data_datetime_utc := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 7) {
			global data_end_line := data_var_decrypt(A_LoopReadLine)
		}
	} else {
		FileAppend(data_var_encrypt("0") . "`n", "data.virema")
		FileAppend(data_var_encrypt("this is custom text") . "`n", "data.virema")
		FileAppend(data_var_encrypt("data_placeholder_0") . "`n", "data.virema")
		FileAppend(data_var_encrypt("data_placeholder_1") . "`n", "data.virema")
		FileAppend(data_var_encrypt("``1234567890-=QWERTYUIOP[]\ASDFGHJKL;'ZXCVBNM,./~!@#$%^&*()_+qwertyuiop{}|asdfghjkl:`"zxcvbnm<>?") . "`n", "data.virema")
		FileAppend(data_var_encrypt(A_NowUTC) . "`n", "data.virema")
		FileAppend(data_var_encrypt("data_end_line"), "data.virema")
		Sleep(156)
		data_read()
	}
}

enable_proxy(*) {
	BlockInput 1
	global exit_allowed := 0
	enable_proxy_check_proxy_err_off_on_val := check_proxy_err_off_on()
	if enable_proxy_check_proxy_err_off_on_val = 1 {
		if not click_wait_ImageSearch_in_folder("C:\deemator\img\03unchecked", wait_ImageSearch_in_folder_time_sec) {
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
			BlockInput 0
			return 0
		}
		if not click_wait_ImageSearch_in_folder("C:\deemator\img\04config", wait_ImageSearch_in_folder_time_sec) {
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
			BlockInput 0
			return 0
		}
		if not wait_ImageSearch_in_folder("C:\deemator\img\05configed", wait_ImageSearch_in_folder_time_sec) {
			Sleep(156*3)
			Send "^a"
			Sleep(156*3)
			Send "{Delete}"
			Sleep(156*3)
			Send "{Tab}"
			Sleep(156*3)
			Send "^a"
			Sleep(156*3)
			Send "{Delete}"
			Sleep(156*3)
			Send "{Tab}"
			Sleep(156*3)
			Send "^a"
			Sleep(156*3)
			Send "{Delete}"
			Sleep(156*3)
			Send "{Tab}"
			
			Sleep(156*3)
			Send "^a"
			Sleep(156*3)
			Send "{Delete}"
			Sleep(156*3)
			Send "{Tab}"
			
			Sleep(156*3)
			Send "^a"
			Sleep(156*3)
			Send "{Delete}"
			Sleep(156*3)
			Send "{Tab}"
			Sleep(156*3)
			Send "^a"
			Sleep(156*3)
			Send "{Delete}"
			Sleep(156*3)
			Send "{Tab}"
			Sleep(156*3)
			Send "127.0.0.1"
			Sleep(156*3)
			Send "{Tab}"
			Sleep(156*3)
			Send "9050"
			Sleep(156*3)
		}
		if not click_wait_ImageSearch_in_folder("C:\deemator\img\06configok", wait_ImageSearch_in_folder_time_sec) {
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
			BlockInput 0
			return 0
		} else {
			Sleep(156*3)
			Send "{Tab 2}"
			Sleep(156*3)
			Send "{Enter}"
			Sleep(156*3)
			Send "{Escape}"
			Sleep(156*3)
			Send "{Alt down}"
			Sleep(156*3)
			Send "{F4}"
			Sleep(156*3)
			Send "{Alt up}"
			Sleep(156*3)
			global exit_allowed := 1
			BlockInput 0
			return 1
		}
	} else if enable_proxy_check_proxy_err_off_on_val = 0 {
		MsgBox_ImageSearch_not_supported()
		global exit_allowed := 1
		BlockInput 0
		return 0
	} else {
		Sleep(156*3)
		Send "{Tab 2}"
		Sleep(156*3)
		Send "{Enter}"
		Sleep(156*3)
		Send "{Escape}"
		Sleep(156*3)
		Send "{Alt down}"
		Sleep(156*3)
		Send "{F4}"
		Sleep(156*3)
		Send "{Alt up}"
		Sleep(156*3)
		global exit_allowed := 1
		BlockInput 0
		return 1
	}
}

disable_proxy(*) {
	BlockInput 1
	global exit_allowed := 0
	enable_proxy_check_proxy_err_off_on_val := check_proxy_err_off_on()
	if enable_proxy_check_proxy_err_off_on_val = 2 {
		if not click_wait_ImageSearch_in_folder("C:\deemator\img\03checked", wait_ImageSearch_in_folder_time_sec) {
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
			BlockInput 0
			return 0
		} else {
			Sleep(156*3)
			Send "{Tab}"
			Sleep(156*3)
			Send "{Enter}"
			Sleep(156*3)
			Send "{Escape}"
			Sleep(156*3)
			Send "{Alt down}"
			Sleep(156*3)
			Send "{F4}"
			Sleep(156*3)
			Send "{Alt up}"
			Sleep(156*3)
		}
		global exit_allowed := 1
		BlockInput 0
		return 1
	} else if enable_proxy_check_proxy_err_off_on_val = 0 {
		MsgBox_ImageSearch_not_supported()
		global exit_allowed := 1
		BlockInput 0
		return 0
	} else {
		Sleep(156*3)
		Send "{Tab}"
		Sleep(156*3)
		Send "{Enter}"
		Sleep(156*3)
		Send "{Escape}"
		Sleep(156*3)
		Send "{Alt down}"
		Sleep(156*3)
		Send "{F4}"
		Sleep(156*3)
		Send "{Alt up}"
		Sleep(156*3)
		global exit_allowed := 1
		BlockInput 0
		return 1
	}
}

check_proxy_err_off_on() {
	RunWait "::{21EC2020-3AEA-1069-A2DD-08002B30309D}"
	Sleep(156*1)
	if not click_wait_ImageSearch_in_folder("C:\deemator\img\00browsersettings", wait_ImageSearch_in_folder_time_sec) {
		return 0
	}
	if not click_wait_ImageSearch_in_folder("C:\deemator\img\01connections", wait_ImageSearch_in_folder_time_sec) {
		return 0
	}
	if not click_wait_ImageSearch_in_folder("C:\deemator\img\02local", wait_ImageSearch_in_folder_time_sec) {
		return 0
	}
	if wait_ImageSearch_in_folder("C:\deemator\img\03checked", wait_ImageSearch_in_folder_time_sec) {
		return 2
	} else if wait_ImageSearch_in_folder("C:\deemator\img\03unchecked", wait_ImageSearch_in_folder_time_sec) {
		return 1
	} else {
		return 0
	}
}

MsgBox_ImageSearch_not_supported(*) {
	if MsgBox("Looks like your version of Windows (language, theme or scaling)`nis not supported.`nWould you like to see instructions`non how to setup proxy manually?", window_title . ": ERROR", "YN") = "Yes" {
		Run("https://github.com/samid36360/deemator#handling-wndows-proxy-manualy")
	}
}

click_wait_ImageSearch_in_folder(folder_full_path, timeout_secs) {
	if wait_ImageSearch_in_folder(folder_full_path, timeout_secs) {
		Sleep(156)
		Click(ImageSearch_in_folder_OutputVarX,ImageSearch_in_folder_OutputVarY)
		global ImageSearch_in_folder_OutputVarX := ""
		global ImageSearch_in_folder_OutputVarY := ""
		return 1
	} else {
		return 0
	}
}

wait_ImageSearch_in_folder(folder_full_path, timeout_secs) {
	Loop Ceil(timeout_secs*2) {
		Sleep(156*3)
		if (ImageSearch_in_folder(folder_full_path)) {
			return 1
		}
	}
	return 0
}

ImageSearch_in_folder(folder_full_path) {
	try {
		global ImageSearch_in_folder_OutputVarX := ""
		global ImageSearch_in_folder_OutputVarY := ""
		Loop Files folder_full_path . "\*.*" {
			ImageSearch &ImageSearch_in_folder_OutputVarX, &ImageSearch_in_folder_OutputVarY, 0, 0, A_ScreenWidth, A_ScreenHeight, "*31 " . A_LoopFileFullPath
			if ImageSearch_in_folder_OutputVarX and ImageSearch_in_folder_OutputVarY {
				return 1
			}
		}
		return 0
	} catch {
		MsgBox("ImageSearch_in_folder error.`nTry reinstalling deemator.", window_title . ": ERROR")
	}
}

started(*) {
	if ProcessExist("deemator_tor.exe") {
		return true
	} else {
		return false
	}
}

stop_clicked(*) {
	ProcessClose("deemator_tor.exe")
	global tor_launch_ordered := 0
	disable_proxy()
}

start_clicked(*) {
	Run A_ComSpec ' /c ""C:\deemator\third_party\deemator_tor.exe" "-f" "C:\deemator\torrc" >"tor_log.txt""',,"Hide"
	SetTimer(check_connection_success, -1560*47)
	global tor_launch_ordered := 1
	enable_proxy()
}

check_connection_success(*) {
	if (started()) {
		if not (check_string_in_log("Bootstrapped 100% (done): Done")) {
			stop_clicked()
			MsgBox("Connection took too long and was aborted. Try again.`nIf the issue persists, try reinstalling deemator.", window_title . ": ERROR")
		}
	} else if tor_launch_ordered {
		try stop_clicked()
		MsgBox("Tor process failed to start. Try again.`nIf the issue persists, try reinstalling deemator.", window_title . ": ERROR")
	}
}

check_string_in_log(string) {
	Try {
		global log_string := FileRead("tor_log.txt")
	} catch {
		return 0
	}
	if (InStr(log_string, string)) {
		return 1
	} else {
		return 0
	}
}

; MsgBox(,,"T0.156")
; MsgBox
; Loading...

update_logs_window_field(*) {
	try {
		if logs_window_field.Text != FileRead("C:\deemator\tor_log.txt") {
			logs_window_field.Text := FileRead("C:\deemator\tor_log.txt")
			global logs_window_field_text_updated := 1
		}
	}
	if WinExist(window_title . " - tor logs") and logs_window_field_text_updated {
		Send("^{End}")
	}
	global logs_window_field_text_updated := 0
}

see_logs_button_clicked(*) {
	global logs_window := Gui.Call(,window_title . " - tor logs")
	global logs_window_field := logs_window.Add("Edit", "+x10 +y10 +w380 +h260 ReadOnly", "No logs were found.")
	Sleep(156)
	logs_window.Show("Center W400 H300")
	Send("^{End}")
	Sleep(156)
	global logs_status_bar := logs_window.Add("StatusBar",, " Close the window to return to main menu.")
	logs_status_bar.SetFont("s8")
}