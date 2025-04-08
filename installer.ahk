; installer.ahk - installer script to compile the distributable .exe file

; GLOBAL CONSTANTS
global installer_sleep_ms := 156*3
global installer_long_sleep_ms := 156*7

#Requires AutoHotkey v2.0
#NoTrayIcon
;@Ahk2Exe-ExeName deemator_0.2.0_installer.exe
;@Ahk2Exe-SetName deemator_0.2.0_installer
;@Ahk2Exe-SetVersion 0.2.0

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
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), "deemator 0.2.0 installer"
	ExitApp
}

; INSTALLATION
if (MsgBox("Do you want to intall (reinstall) deemator 0.2.0 to this computer?", "deemator 0.2.0 installer", 4) = "Yes") {
	if ProcessExist("deemator_tor.exe") {
		ProcessClose("deemator_tor.exe")
		Sleep(installer_long_sleep_ms)
	}
	if DirExist("C:\deemator") {
		try {
			DirDelete("C:\deemator", 1)
		} catch {
			MsgBox("DirDelete`nerror", "deemator 0.2.0 installer error")
			ExitApp
		}
	}
	Sleep(installer_sleep_ms)
	try {
		DirCreate("C:\deemator")
		DirCreate("C:\deemator\third_party")
	} catch {
		MsgBox("DirCreate`nerror", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\third_party\deemator_tor.exe", "C:\deemator\third_party\deemator_tor.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\deemator_tor.exe`", `"C:\deemator\third_party\deemator_tor.exe`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\third_party\geoip", "C:\deemator\third_party\geoip", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\geoip`", `"C:\deemator\third_party\geoip`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\third_party\geoip6", "C:\deemator\third_party\geoip6", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\geoip6`", `"C:\deemator\third_party\geoip6`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\third_party\lyrebird.exe", "C:\deemator\third_party\lyrebird.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\lyrebird.exe`", `"C:\deemator\third_party\lyrebird.exe`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\deemator.lnk",A_Desktop . "\deemator.lnk", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\deemator.lnk`",A_Desktop . `"\deemator.lnk`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\deemator.lnk", "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\deemator.lnk", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\deemator.lnk`", `"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\deemator.lnk`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\icon.ico", "C:\deemator\icon.ico", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\icon.ico`", `"C:\deemator\icon.ico`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\LICENSE", "C:\deemator\LICENSE", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\LICENSE`", `"C:\deemator\LICENSE`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\main.exe", "C:\deemator\main.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\main.exe`", `"C:\deemator\main.exe`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		FileInstall "C:\deemator\torrc", "C:\deemator\torrc", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\torrc`", `"C:\deemator\torrc`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	try {
		DirCreate("C:\deemator\img")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\00browsersettings")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\01connections")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\02local")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\03checked")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\03unchecked")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\04config")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\05configed")
		Sleep(installer_sleep_ms)
		DirCreate("C:\deemator\img\06configok")
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\00browsersettings\00.png","C:\deemator\img\00browsersettings\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\00browsersettings\01.png","C:\deemator\img\00browsersettings\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\00browsersettings\02.png","C:\deemator\img\00browsersettings\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\01connections\00.png","C:\deemator\img\01connections\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\01connections\01.png","C:\deemator\img\01connections\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\01connections\02.png","C:\deemator\img\01connections\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\02local\00.png","C:\deemator\img\02local\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\02local\01.png","C:\deemator\img\02local\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\02local\02.png","C:\deemator\img\02local\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\03checked\00.png","C:\deemator\img\03checked\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\03checked\01.png","C:\deemator\img\03checked\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\03checked\02.png","C:\deemator\img\03checked\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\03unchecked\00.png","C:\deemator\img\03unchecked\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\03unchecked\01.png","C:\deemator\img\03unchecked\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\03unchecked\02.png","C:\deemator\img\03unchecked\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\04config\00.png","C:\deemator\img\04config\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\04config\01.png","C:\deemator\img\04config\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\04config\02.png","C:\deemator\img\04config\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\05configed\00.png","C:\deemator\img\05configed\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\05configed\01.png","C:\deemator\img\05configed\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\05configed\02.png","C:\deemator\img\05configed\02.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\06configok\00.png","C:\deemator\img\06configok\00.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\06configok\01.png","C:\deemator\img\06configok\01.png",1)
		Sleep(installer_sleep_ms)
		FileInstall("C:\deemator\img\06configok\02.png","C:\deemator\img\06configok\02.png",1)
		Sleep(installer_sleep_ms)
	} catch {
		MsgBox("C:\deemator\img", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(installer_sleep_ms)
	MsgBox("Successfully installed deemator 0.2.0 to this computer.`nA startup link was placed at the desktop.", "deemator 0.2.0 installer")
	Sleep(installer_sleep_ms)
	ExitApp
} else {
	ExitApp
}
