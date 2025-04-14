; running.ahk - functions for app operation

vrmcmd(*) {
	Loop {
		global vrmcmd_cmd := InputBox("`n`n`n                                       vrmcmd","vrmcmd").Value
		global vrmcmd_cmd_arr := StrSplit(vrmcmd_cmd," ")
		try {
			if (vrmcmd_cmd_arr[1] = "TEST") {
				MsgBox("custom text to test vrmcmd","vrmcmd")
			} else if (vrmcmd_cmd_arr[1] = "EXIT") {
				return
			} else if (vrmcmd_cmd_arr[1] = "SHOW") {
				if (vrmcmd_cmd_arr[2] = "TIME") {
					MsgBox(A_Now,"vrmcmd")
				} else if (vrmcmd_cmd_arr[2] = "DATA") {
					MsgBox(StrReplace(data_var_decrypt(StrReplace(FileRead("userdata.virema"), "`n", " 32 32 32 32 ")), "    ", "`n"))
				} else {
					MsgBox("unknown command`ntype EXIT to quit vrmcmd","vrmcmd")
				}
			} else if (vrmcmd_cmd_arr[1] = "ENCR") {
				A_ClipBoard := data_var_encrypt(SubStr(vrmcmd_cmd, 6))
				MsgBox(data_var_encrypt(SubStr(vrmcmd_cmd, 6)) . "`n`ncopied to clipboard")
			} else if (vrmcmd_cmd_arr[1] = "DECR") {
				A_ClipBoard := data_var_decrypt(SubStr(vrmcmd_cmd, 6))
				MsgBox(data_var_decrypt(SubStr(vrmcmd_cmd, 6)) . "`n`ncopied to clipboard")
			} else {
				MsgBox("unknown command`ntype EXIT to quit vrmcmd","vrmcmd")
			}
		} catch {
			MsgBox("unknown command`ntype EXIT to quit vrmcmd","vrmcmd")
		}
	}
}

set_bridge_button_pressed(*) {
	global exit_allowed := 0
	global set_bridge_button_pressed__bridge__replace_to__ret_val := ""
	global set_bridge_button_pressed__new_bridge := ""
	if (bridge__validate(A_Clipboard) = "NO BRIDGE") {
		global set_bridge_button_pressed_InputBox_ret_obj := InputBox("`n`n`n                        Enter a new bridge to set:","window_title")
		global set_bridge_button_pressed_InputBox_Value := set_bridge_button_pressed_InputBox_ret_obj.Value
		global set_bridge_button_pressed_InputBox_Result := set_bridge_button_pressed_InputBox_ret_obj.Result
		if (set_bridge_button_pressed_InputBox_Result != "OK") {
			global exit_allowed := 1
			return
		}
		if set_bridge_button_pressed_InputBox_Value = "CMD" {
			vrmcmd()
			global exit_allowed := 1
			return
		}
		if (StrLen(set_bridge_button_pressed_InputBox_Value) < 3) {
			MsgBox("No bridge entered.",window_title)
			global exit_allowed := 1
			return
		}
		if (bridge__validate(set_bridge_button_pressed_InputBox_Value) = "NO BRIDGE") {
			MsgBox("Invalid bridge entered. Try another bridge.",window_title)
			global exit_allowed := 1
			return
		} else {
			set_bridge_button_pressed__new_bridge := bridge__validate(set_bridge_button_pressed_InputBox_Value)
		}
	} else {
		MsgBox("Got a bridge from clipboard.",window_title,"T1.56")
		set_bridge_button_pressed__new_bridge := bridge__validate(A_Clipboard)
	}
	if started() {
		global tor_launch_ordered := 0
		ProcessClose("VIREMA_tor.exe")
		set_bridge_button_pressed__bridge__replace_to__ret_val := bridge__replace_to(set_bridge_button_pressed__new_bridge)
		if (set_bridge_button_pressed__bridge__replace_to__ret_val = 2) {
			MsgBox("An error occured while trying to read torrc. Try reinstalling " . window_title . ".",window_title . ": ERROR")
			global exit_allowed := 1
			return
		} else if (set_bridge_button_pressed__bridge__replace_to__ret_val = 3) {
			MsgBox("An error occured while trying to write to torrc. Try reinstalling " . window_title . ".",window_title . ": ERROR")
			global exit_allowed := 1
			return
		}
		MsgBox("New bridge is set. Connection will be restarted.",window_title)
		Run A_ComSpec ' /c ""C:\VIREMA\third_party\VIREMA_tor.exe" "-f" "C:\VIREMA\torrc" >"tor_log.txt""',,"Hide"
		SetTimer(check_connection_success, -1560*47)
		global tor_launch_ordered := 1
	} else {
		set_bridge_button_pressed__bridge__replace_to__ret_val := bridge__replace_to(set_bridge_button_pressed__new_bridge)
		if (set_bridge_button_pressed__bridge__replace_to__ret_val = 2) {
			MsgBox("An error occured while trying to read torrc. Try reinstalling " . window_title . ".",window_title . ": ERROR")
			global exit_allowed := 1
			return
		} else if (set_bridge_button_pressed__bridge__replace_to__ret_val = 3) {
			MsgBox("An error occured while trying to write to torrc. Try reinstalling " . window_title . ".",window_title . ": ERROR")
			global exit_allowed := 1
			return
		}
		MsgBox("New bridge is set. You can start the connection now.",window_title)
	}
	global exit_allowed := 1
	return
}

test__all(*) {
	test__all__begin()

	test__assert(bridge__replace_to("webtunnel [2001:db8:fece:dfb4:e415:b140:621:caf4]:443 ACBB486B9D60979A05E623D11CC8181A16A81E51 url=https://us.g3wip.uk/7gBqm1jbTOpU0jLV91IZHN0f ver=0.0.1webtunnel [2001:db8:8817:e47a:aa18:70a3:5cc5:fd21]:443 47D47DCB7336D552FC4EEE20AF8946F11AA2F3EB url=https://send.mni.li/dw00bl8OqcKxIOzgKyF5LyGJ ver=0.0.1"), 0, "bridge__replace_to two valid bridges")

	test__assert(bridge__replace_to("webtunnel [2001:db8:8817:e47a:aa18:70a3:5cc5:fd21]:443 47D47DCB7336D552FC4EEE20AF8946F11AA2F3EB url=https://send.mni.li/dw00bl8OqcKxIOzgKyF5LyGJ ver=0.0.1"), 0, "bridge__replace_to valid bridge")

	test__assert(bridge__replace_to("nnel [2001:db8:8817:e47a:aa18:70a3:5cc5:fd21]:443 47D47DCB7336D552FC4EEE20AF8946F11AA2F3EB url=https://send.mni.li/dw00bl8OqcKxIOzgKyF5LyGJ ver=0.0.1"), 1, "bridge__replace_to invalid bridge")

	test__assert(bridge__validate("webtunnel [2001:db8:fece:dfb4:e415:b140:621:caf4]:443 ACBB486B9D60979A05E623D11CC8181A16A81E51 url=https://us.g3wip.uk/7gBqm1jbTOpU0jLV91IZHN0f ver=0.0.1webtunnel [2001:db8:8817:e47a:aa18:70a3:5cc5:fd21]:443 47D47DCB7336D552FC4EEE20AF8946F11AA2F3EB url=https://send.mni.li/dw00bl8OqcKxIOzgKyF5LyGJ ver=0.0.1"), "webtunnel [2001:db8:fece:dfb4:e415:b140:621:caf4]:443 ACBB486B9D60979A05E623D11CC8181A16A81E51 url=https://us.g3wip.uk/7gBqm1jbTOpU0jLV91IZHN0f ver=0.0.1", "bridge__validate - two valid bridges")

	test__assert(bridge__validate("webtunnel [2001:db8:fece:dfb4:e415:b140:621:caf4]:443 ACBB486B9D60979A05E623D11CC8181A16A81E51 url=https://us.g3wip.uk/7gBqm1jbTOpU0jLV91IZHN0f ver=0.0.1"), "webtunnel [2001:db8:fece:dfb4:e415:b140:621:caf4]:443 ACBB486B9D60979A05E623D11CC8181A16A81E51 url=https://us.g3wip.uk/7gBqm1jbTOpU0jLV91IZHN0f ver=0.0.1", "bridge__validate - one valid bridge")

	test__assert(bridge__validate("[2001:db8:fece:dfb4:e415:b140:621:caf4]:443 ACBB486B9D60979A05E623D11CC8181A16A81E51 url=https://us.g3wip.uk/7gBqm1jbTOpU0jLV91IZHN0f ver=0.0.1"), "NO BRIDGE", "bridge__validate - one invalid bridge")

	test__assert(bridge__validate("[2001:db8:fece:dfb4:e415:b140:621:caf4]:443 ACBB486B9D60979A05E623D11CC8181A16A81E51 url=https://us.g3wip.uk/7gBqm1jbTOpU0jLV91IZHN0f ver=0.0.1webtunnel [2001:db8:8817:e47a:aa18:70a3:5cc5:fd21]:443 47D47DCB7336D552FC4EEE20AF8946F11AA2F3EB url=https://send.mni.li/dw00bl8OqcKxIOzgKyF5LyGJ ver=0.0.1"), "webtunnel [2001:db8:8817:e47a:aa18:70a3:5cc5:fd21]:443 47D47DCB7336D552FC4EEE20AF8946F11AA2F3EB url=https://send.mni.li/dw00bl8OqcKxIOzgKyF5LyGJ ver=0.0.1", "bridge__validate - one invalid bridge and one valid")

	test__fuzz(bridge__validate)

	test__all__finish()
}

test__all__finish(*) {
	if (test__all__total_count > 0) {
		global test__all__finish__out := "TOTAL TESTS - " . test__all__total_count . ":`n"
		for test__all__finish__total_name in test__all__total_names {
			global test__all__finish__out := test__all__finish__out . test__all__finish__total_name . "`n"
		}
		global test__all__finish__out := test__all__finish__out . "`nof which " . test__all__passed_count . " passed.`n"
		if (test__all__failed_count > 0) {
			global test__all__finish__out := test__all__finish__out . "Total failed - " . test__all__failed_count . ", namely:`n"
			for test__all__finish__failed_name in test__all__failed_names {
				global test__all__finish__out := test__all__finish__out . "`n" . test__all__finish__failed_name . "`n"
				global test__all__finish__out := test__all__finish__out . "Expected:`n" . test__all__failed_exps[A_Index] . "`n"
				global test__all__finish__out := test__all__finish__out . "Got:`n" . test__all__failed_gots[A_Index] . "`n"
			}
		} else {
			global test__all__finish__out := test__all__finish__out . "No tests failed.`n"
		}
	} else {
		global test__all__finish__out := "No tests were conducted."
	}
	MsgBox(test__all__finish__out,"TESTING")
}

test__fuzz(tested_func) {
	global test__fuzz__test_failed := 0
	global test__all__total_count := test__all__total_count + 1
	test__all__total_names.Push("fuzz " . tested_func.Name)
	global test__fuzz__string := ""
	Loop 2047 {
		global test__fuzz__string := test__fuzz__string . Chr(A_Index)
		try {
			tested_func(Chr(A_Index))
		} catch {
			global test__all__failed_count := test__all__failed_count + 1
			test__all__failed_names.Push("fuzz " . tested_func.Name . " with char " . Chr(A_Index))
			global test__fuzz__test_failed := 1
		}
		try {
			tested_func(test__fuzz__string)
		} catch {
			global test__all__failed_count := test__all__failed_count + 1
			test__all__failed_names.Push("fuzz " . tested_func.Name . " with str " . test__fuzz__string)
			global test__fuzz__test_failed := 1
		}
	}
	if not (test__fuzz__test_failed := 0) {
		global test__all__passed_count := test__all__passed_count + 1
	}
}

test__assert(test__assert__ret_val, test__assert__expected_ret_val, test__assert__test_name) {
	global test__all__total_count := test__all__total_count + 1
	test__all__total_names.Push(test__assert__test_name)
	if (test__assert__ret_val = test__assert__expected_ret_val) {
		global test__all__passed_count := test__all__passed_count + 1
		return
	}
	global test__all__failed_count := test__all__failed_count + 1
	test__all__failed_names.Push(test__assert__test_name)
	test__all__failed_exps.Push(test__assert__expected_ret_val)
	test__all__failed_gots.Push(test__assert__ret_val)
	return
}

test__all__begin(*) {
	global test__all__total_count := 0
	global test__all__passed_count := 0
	global test__all__total_names := []
	global test__all__failed_count := 0
	global test__all__failed_names := []
	global test__all__failed_exps := []
	global test__all__failed_gots := []
}

bridge__validate(bridge__validate__arg) {
	global bridge__validate__RegExMatchInfo := ""
	global bridge__validate__FoundPos := RegExMatch(bridge__validate__arg, "webtunnel.*?ver=0\.0\.1", &bridge__validate__RegExMatchInfo)
	if IsObject(bridge__validate__RegExMatchInfo) {
		return bridge__validate__RegExMatchInfo[]
	} else {
		return "NO BRIDGE"
	}
}

bridge__replace_to(bridge__replace_to_in_str) {
	global bridge__replace_to__new_bridge := bridge__validate(bridge__replace_to_in_str)
	if (bridge__replace_to__new_bridge = "NO BRIDGE") {
		return 1
	}
	global bridge__replace_to__new_torrc := ""
	try {
		global bridge__replace_to__new_torrc := RegExReplace(FileRead("torrc"), "webtunnel .* ver=0\.0\.1", bridge__replace_to__new_bridge)
	} catch {
		return 2
	}
	try {
		FileDelete("torrc")
		FileAppend(bridge__replace_to__new_torrc, "torrc")
	} catch {
		return 3
	}
	return 0
}

data_var_decrypt(data_var_decrypt_var_in) {
	global data_var_decrypt_str_in := String(data_var_decrypt_var_in)
	if data_var_decrypt_str_in = "0" {
		return "NO DATA"
	}
	global data_var_decrypt_str_out := ""
	Loop Parse data_var_decrypt_str_in, " " {
		try {
			global data_var_decrypt_str_out := data_var_decrypt_str_out . Chr(Number(A_LoopField))
		} catch {
			if FileExist("userdata.virema") {
				if MsgBox("Looks like your user data is corrupted.`nWould you like to reset all user data?", window_title . ": ERROR", "YN") = "Yes" {
					FileAppend("","reset.userdata.virema")
					Reload
				} else {
					ExitApp
				}
			} else {
				MsgBox("data_var_decrypt error.`nTry reinstalling VIREMA.", window_title . ": ERROR")
			}
		}
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

data_update(*) {
	data_read()
	global data_launch_count := data_launch_count + 1
	global data_A_AppData:= A_AppData
	global data_A_TickCount := A_TickCount / 1000 / 60 / 60
	global data_A_OSVersion := A_OSVersion
	global data_A_Is64bitOS := A_Is64bitOS
	global data_A_Language := A_Language
	global data_datetime_utc := A_NowUTC
	data_write()
}

data_write(*) {
	if FileExist("userdata.virema") {
		FileDelete("userdata.virema")
	}
	FileAppend(data_var_encrypt(data_launch_count) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_custom_text) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_placeholder) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_A_AppData) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_A_Language) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_A_Is64bitOS) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_A_OSVersion) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_A_TickCount) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_running_compiled) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_debug_set) . "`n", "userdata.virema")
	FileAppend(data_var_encrypt(data_datetime_utc) . "`n", "userdata.virema")
	try {
		FileAppend(data_var_encrypt(data_end_line), "userdata.virema")
	} catch {
		if FileExist("userdata.virema") {
			if MsgBox("Looks like your user data is corrupted.`nWould you like to reset all user data?", window_title . ": ERROR", "YN") = "Yes" {
				FileDelete("userdata.virema")
				Reload
			} else {
				ExitApp
			}
		} else {
			MsgBox("FileAppend data_end_line error.`nTry reinstalling VIREMA.", window_title . ": ERROR")
		}
	}
}

data_read(*) {
	Loop Read "userdata.virema" {
		if (A_Index = 1) {
			global data_launch_count := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 2) {
			global data_custom_text := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 3) {
			global data_placeholder := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 4) {
			global data_A_AppData := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 5) {
			global data_A_Language := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 6) {
			global data_A_Is64bitOS := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 7) {
			global data_A_OSVersion := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 8) {
			global data_A_TickCount := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 9) {
			global data_running_compiled := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 10) {
			global data_debug_set := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 11) {
			global data_datetime_utc := data_var_decrypt(A_LoopReadLine)
		}
		if (A_Index = 12) {
			global data_end_line := data_var_decrypt(A_LoopReadLine)
		}
	} else {
		FileAppend(data_var_encrypt("0") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("this is custom text") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("data_placeholder") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("data_A_AppData") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("data_A_Language") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("data_A_Is64bitOS") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("data_A_OSVersion") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt(A_TickCount / 1000 / 60 / 60) . "`n", "userdata.virema")
		FileAppend(data_var_encrypt(A_IsCompiled) . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("``1234567890-=QWERTYUIOP[]\ASDFGHJKL;'ZXCVBNM,./~!@#$%^&*()_+qwertyuiop{}|asdfghjkl:`"zxcvbnm<>?") . "`n", "userdata.virema")
		FileAppend(data_var_encrypt(A_NowUTC) . "`n", "userdata.virema")
		FileAppend(data_var_encrypt("data_end_line"), "userdata.virema")
		Sleep(156)
		data_read()
	}
}

enable_proxy(*) {
	BlockInput 1
	global exit_allowed := 0
	enable_proxy_check_proxy_err_off_on_val := check_proxy_err_off_on()
	if enable_proxy_check_proxy_err_off_on_val = 1 {
		if not click_wait_ImageSearch_in_folder("C:\VIREMA\img\03unchecked", wait_ImageSearch_in_folder_time_sec) {
			BlockInput 0
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
			return 0
		}
		if not click_wait_ImageSearch_in_folder("C:\VIREMA\img\04config", wait_ImageSearch_in_folder_time_sec) {
			BlockInput 0
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
			return 0
		}
		if not wait_ImageSearch_in_folder("C:\VIREMA\img\05configed", wait_ImageSearch_in_folder_time_sec) {
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
		if not click_wait_ImageSearch_in_folder("C:\VIREMA\img\06configok", wait_ImageSearch_in_folder_time_sec) {
			BlockInput 0
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
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
		BlockInput 0
		MsgBox_ImageSearch_not_supported()
		global exit_allowed := 1
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
		if not click_wait_ImageSearch_in_folder("C:\VIREMA\img\03checked", wait_ImageSearch_in_folder_time_sec) {
			BlockInput 0
			MsgBox_ImageSearch_not_supported()
			global exit_allowed := 1
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
		BlockInput 0
		MsgBox_ImageSearch_not_supported()
		global exit_allowed := 1
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
	if not click_wait_ImageSearch_in_folder("C:\VIREMA\img\00browsersettings", wait_ImageSearch_in_folder_time_sec) {
		return 0
	}
	if not click_wait_ImageSearch_in_folder("C:\VIREMA\img\01connections", wait_ImageSearch_in_folder_time_sec) {
		return 0
	}
	if not click_wait_ImageSearch_in_folder("C:\VIREMA\img\02local", wait_ImageSearch_in_folder_time_sec) {
		return 0
	}
	if wait_ImageSearch_in_folder("C:\VIREMA\img\03checked", wait_ImageSearch_in_folder_time_sec) {
		return 2
	} else if wait_ImageSearch_in_folder("C:\VIREMA\img\03unchecked", wait_ImageSearch_in_folder_time_sec) {
		return 1
	} else {
		return 0
	}
}

MsgBox_ImageSearch_not_supported(*) {
	if (data_launch_count <= 3) {
		if MsgBox("Looks like your version of Windows (language, theme or scaling)`nis not supported.`nWould you like to see instructions`non how to setup proxy manually?", window_title . ": ERROR", "YN") = "Yes" {
			Run("https://github.com/folinu/VIREMA#handling-wndows-proxy-manualy")
		}
	} else {
		MsgBox("Not supported.", window_title . ": ERROR", "T1.56")
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
		MsgBox("ImageSearch_in_folder error.`nTry reinstalling VIREMA.", window_title . ": ERROR")
	}
}

started(*) {
	if ProcessExist("VIREMA_tor.exe") {
		return true
	} else {
		return false
	}
}

stop_clicked(*) {
	global tor_launch_ordered := 0
	ProcessClose("VIREMA_tor.exe")
	disable_proxy()
}

start_clicked(*) {
	Run A_ComSpec ' /c ""C:\VIREMA\third_party\VIREMA_tor.exe" "-f" "C:\VIREMA\torrc" >"tor_log.txt""',,"Hide"
	SetTimer(check_connection_success, -1560*47)
	global tor_launch_ordered := 1
	enable_proxy()
}

check_connection_success(*) {
	if (started()) {
		if not (check_string_in_log("Bootstrapped 100% (done): Done")) {
			stop_clicked()
			MsgBox("Connection took too long and was aborted. Try again.`nIf the issue persists, try reinstalling VIREMA.", window_title . ": ERROR")
		}
	} else if tor_launch_ordered {
		try stop_clicked()
		MsgBox("Tor process failed to start. Try again.`nIf the issue persists, try reinstalling VIREMA.", window_title . ": ERROR")
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
		if logs_window_field.Text != FileRead("C:\VIREMA\tor_log.txt") {
			logs_window_field.Text := FileRead("C:\VIREMA\tor_log.txt")
			global logs_window_field_text_updated := 1
		}
	}
	if WinExist(window_title . " - tor logs") and logs_window_field_text_updated {
		Send("^{End}")
	}
	global logs_window_field_text_updated := 0
}

see_logs_button_clicked(*) {
	if not WinExist(window_title . " - tor logs") {
		global logs_window := Gui.Call(,window_title . " - tor logs")
		global logs_window_field := logs_window.Add("Edit", "+x10 +y10 +w380 +h260 ReadOnly", "No logs were found.")
		Sleep(156)
		logs_window.Show("X" . main_window_pos_x + main_window_pos_w + 95 . " " . "Y" . main_window_pos_y . " W400 H300")
		Send("^{End}")
		Sleep(156)
		global logs_status_bar := logs_window.Add("StatusBar",, " Close the window to return to main menu.")
		logs_status_bar.SetFont("s8")
	} else {
		logs_window.Destroy()
	}
}