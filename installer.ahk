; installer.ahk - installer script to compile the distributable .exe file

; GLOBAL CONSTANTS
global installer_sleep_ms := 156*3
global installer_long_sleep_ms := 156*7

#Requires AutoHotkey v2.0
#NoTrayIcon
;@Ahk2Exe-ExeName VIREMA_0.3.0_installer.exe
;@Ahk2Exe-SetName VIREMA_0.3.0_installer
;@Ahk2Exe-SetVersion 0.3.0

; ENABLING ADMIN RIGHTS
if not (A_IsAdmin or RegExMatch(DllCall("GetCommandLine", "str"), " /restart(?!\S)")) {
	try {
		if A_IsCompiled
			Run '*RunAs "' A_ScriptFullPath '" /restart'
		else
			Run '*RunAs "' A_AhkPath '" /restart "' A_ScriptFullPath '"'
	}
}
Sleep(installer_long_sleep_ms)
if not (A_IsAdmin) {
	Sleep(installer_sleep_ms)
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), "VIREMA 0.3.0 installer"
	ExitApp
}

; INSTALLATION
if (MsgBox("Do you want to intall (reinstall) VIREMA 0.3.0 to this computer?", "VIREMA 0.3.0 installer", 4) = "Yes") {
	global installer_progress_window := Gui.Call("-MinimizeBox +AlwaysOnTop","VIREMA 0.3.0 installer")
	installer_progress_window_text := installer_progress_window.Add("Text", "+x10 +y10 +w380 +h180", Format("{:-47}","Initializing installation..."))
	installer_progress_window_text.SetFont("s10", "Consolas")
	installer_progress_window.Show("Center W400 H200")
	if ProcessExist("VIREMA_tor.exe") {
		ProcessClose("VIREMA_tor.exe")
		Sleep(installer_long_sleep_ms)
	}
	installer_progress_window_text.Text .= "Done`n"
	installer_progress_window_text.Text .= Format("{:-47}","Cleaning up...")
	if DirExist("C:\VIREMA") {
		try {
			DirDelete("C:\VIREMA", 1)
		} catch {
			installer_progress_window_text.Text .= "`nAn error occured while trying to clean up.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
			installation_done_or_failed()
		}
	}
	Sleep(installer_sleep_ms)
	installer_progress_window_text.Text .= "Done`n"
	installer_progress_window_text.Text .= Format("{:-47}","Setting up file structure...")
	try {
		DirCreate("C:\VIREMA")
		DirCreate("C:\VIREMA\third_party")
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to set up file structure.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	installer_progress_window_text.Text .= "Done`n"
	installer_progress_window_text.Text .= Format("{:-47}","Unpacking third party...")
	try {
		FileInstall "C:\VIREMA\third_party\VIREMA_tor.exe", "C:\VIREMA\third_party\VIREMA_tor.exe", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack third party.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\third_party\geoip", "C:\VIREMA\third_party\geoip", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack third party.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\third_party\geoip6", "C:\VIREMA\third_party\geoip6", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack third party.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\third_party\lyrebird.exe", "C:\VIREMA\third_party\lyrebird.exe", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack third party.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	installer_progress_window_text.Text .= "Done`n"
	installer_progress_window_text.Text .= Format("{:-47}","Installing links...")
	try {
		FileInstall "C:\VIREMA\VIREMA.lnk",A_Desktop . "\VIREMA.lnk", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to install links.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\VIREMA.lnk", "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\VIREMA.lnk", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to install links.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	installer_progress_window_text.Text .= "Done`n"
	installer_progress_window_text.Text .= Format("{:-47}","Unpacking program files...")
	try {
		FileInstall "C:\VIREMA\icon.ico", "C:\VIREMA\icon.ico", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack program files.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\LICENSE", "C:\VIREMA\LICENSE", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack program files.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\main.exe", "C:\VIREMA\main.exe", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack program files.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\torrc", "C:\VIREMA\torrc", 1
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to unpack program files.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	installer_progress_window_text.Text .= "Done`n"
	installer_progress_window_text.Text .= Format("{:-47}","Setting up img file structure...")
	try {
		DirCreate("C:\VIREMA\img")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\00browsersettings")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\01connections")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\02local")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\03checked")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\03unchecked")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\04config")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\05configed")
		Sleep(installer_sleep_ms)
		DirCreate("C:\VIREMA\img\06configok")
		Sleep(installer_sleep_ms)
		installer_progress_window_text.Text .= "Done`n"
		installer_progress_window_text.Text .= Format("{:-47}","Unpacking img files...")
		FileInstall("C:\VIREMA\img\00browsersettings\00.png","C:\VIREMA\img\00browsersettings\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\00browsersettings\01.png","C:\VIREMA\img\00browsersettings\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\00browsersettings\02.png","C:\VIREMA\img\00browsersettings\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\01connections\00.png","C:\VIREMA\img\01connections\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\01connections\01.png","C:\VIREMA\img\01connections\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\01connections\02.png","C:\VIREMA\img\01connections\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\02local\00.png","C:\VIREMA\img\02local\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\02local\01.png","C:\VIREMA\img\02local\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\02local\02.png","C:\VIREMA\img\02local\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\03checked\00.png","C:\VIREMA\img\03checked\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\03checked\01.png","C:\VIREMA\img\03checked\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\03checked\02.png","C:\VIREMA\img\03checked\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\03unchecked\00.png","C:\VIREMA\img\03unchecked\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\03unchecked\01.png","C:\VIREMA\img\03unchecked\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\03unchecked\02.png","C:\VIREMA\img\03unchecked\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\04config\00.png","C:\VIREMA\img\04config\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\04config\01.png","C:\VIREMA\img\04config\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\04config\02.png","C:\VIREMA\img\04config\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\05configed\00.png","C:\VIREMA\img\05configed\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\05configed\01.png","C:\VIREMA\img\05configed\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\05configed\02.png","C:\VIREMA\img\05configed\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\06configok\00.png","C:\VIREMA\img\06configok\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\06configok\01.png","C:\VIREMA\img\06configok\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\VIREMA\img\06configok\02.png","C:\VIREMA\img\06configok\02.png",1)
		Sleep(installer_sleep_ms)
	} catch {
		installer_progress_window_text.Text .= "`nAn error occured while trying to install img files.`nTry again.`nIf the issue persists, contact developer at https://github.com/71folinu/VIREMA/issues/"
		installation_done_or_failed()
	}
	Sleep(installer_sleep_ms)
	installer_progress_window_text.Text .= "Done`n"
	installer_progress_window_text.Text .= "`nSuccessfully installed VIREMA 0.3.0.`nA startup link was placed at the desktop."
	Sleep(installer_sleep_ms)
	installation_done_or_failed()
} else {
	MsgBox("Aborting installation...", "VIREMA 0.3.0 installer error", "T1.56")
	ExitApp
}

installation_done_or_failed(*) {
		Loop {
		if not WinExist("VIREMA 0.3.0 installer") {
			ExitApp
		}
		if WinExist("VIREMA 0.3.0 installer") and not WinActive("VIREMA 0.3.0 installer") {
			ExitApp
		}
		Sleep(156)
	}
}
