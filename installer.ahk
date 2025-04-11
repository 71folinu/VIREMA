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
	if ProcessExist("VIREMA_tor.exe") {
		ProcessClose("VIREMA_tor.exe")
		Sleep(installer_long_sleep_ms)
	}
	if DirExist("C:\VIREMA") {
		try {
			DirDelete("C:\VIREMA", 1)
		} catch {
			MsgBox("DirDelete`nerror", "VIREMA 0.3.0 installer error")
			ExitApp
		}
	}
	Sleep(installer_sleep_ms)
	try {
		DirCreate("C:\VIREMA")
		DirCreate("C:\VIREMA\third_party")
	} catch {
		MsgBox("DirCreate`nerror", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\third_party\VIREMA_tor.exe", "C:\VIREMA\third_party\VIREMA_tor.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\third_party\VIREMA_tor.exe`", `"C:\VIREMA\third_party\VIREMA_tor.exe`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\third_party\geoip", "C:\VIREMA\third_party\geoip", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\third_party\geoip`", `"C:\VIREMA\third_party\geoip`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\third_party\geoip6", "C:\VIREMA\third_party\geoip6", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\third_party\geoip6`", `"C:\VIREMA\third_party\geoip6`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\third_party\lyrebird.exe", "C:\VIREMA\third_party\lyrebird.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\third_party\lyrebird.exe`", `"C:\VIREMA\third_party\lyrebird.exe`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\VIREMA.lnk",A_Desktop . "\VIREMA.lnk", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\VIREMA.lnk`",A_Desktop . `"\VIREMA.lnk`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\VIREMA.lnk", "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\VIREMA.lnk", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\VIREMA.lnk`", `"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\VIREMA.lnk`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\icon.ico", "C:\VIREMA\icon.ico", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\icon.ico`", `"C:\VIREMA\icon.ico`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\LICENSE", "C:\VIREMA\LICENSE", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\LICENSE`", `"C:\VIREMA\LICENSE`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\main.exe", "C:\VIREMA\main.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\main.exe`", `"C:\VIREMA\main.exe`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\VIREMA\torrc", "C:\VIREMA\torrc", 1
	} catch {
		MsgBox("FileInstall `"C:\VIREMA\torrc`", `"C:\VIREMA\torrc`", 1", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
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
		MsgBox("C:\VIREMA\img", "VIREMA 0.3.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	MsgBox("Successfully installed VIREMA 0.3.0 to this computer.`nA startup link was placed at the desktop.", "VIREMA 0.3.0 installer")
	Sleep(installer_sleep_ms)
	ExitApp
} else {
	ExitApp
}
