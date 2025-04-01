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
Sleep(156*2)
if not (A_IsAdmin) {
	Sleep(1560)
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), "deemator 0.2.0 installer"
	ExitApp
}

; INSTALLATION
if (MsgBox("Do you want to intall (reinstall) deemator 0.2.0 to this computer?", "deemator 0.2.0 installer", 4) = "Yes") {
	if DirExist("C:\deemator") {
		try {
			DirDelete("C:\deemator", 1)
		} catch {
			MsgBox("DirDelete`nerror", "deemator 0.2.0 installer error")
			ExitApp
		}
	}
	Sleep(156*2)
	try {
		DirCreate("C:\deemator")
		DirCreate("C:\deemator\third_party")
	} catch {
		MsgBox("DirCreate`nerror", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\third_party\deemator_tor.exe", "C:\deemator\third_party\deemator_tor.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\deemator_tor.exe`", `"C:\deemator\third_party\deemator_tor.exe`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	try {
		FileInstall "C:\deemator\third_party\geoip", "C:\deemator\third_party\geoip", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\geoip`", `"C:\deemator\third_party\geoip`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\third_party\geoip6", "C:\deemator\third_party\geoip6", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\geoip6`", `"C:\deemator\third_party\geoip6`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\third_party\lyrebird.exe", "C:\deemator\third_party\lyrebird.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\third_party\lyrebird.exe`", `"C:\deemator\third_party\lyrebird.exe`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\deemator.lnk",A_Desktop . "\deemator.lnk", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\deemator.lnk`",A_Desktop . `"\deemator.lnk`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\deemator.lnk", "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\deemator.lnk", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\deemator.lnk`", `"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\deemator.lnk`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\icon.ico", "C:\deemator\icon.ico", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\icon.ico`", `"C:\deemator\icon.ico`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\LICENSE", "C:\deemator\LICENSE", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\LICENSE`", `"C:\deemator\LICENSE`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\main.exe", "C:\deemator\main.exe", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\main.exe`", `"C:\deemator\main.exe`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\torrc", "C:\deemator\torrc", 1
	} catch {
		MsgBox("FileInstall `"C:\deemator\torrc`", `"C:\deemator\torrc`", 1", "deemator 0.2.0 installer error")
		ExitApp
	}
	Sleep(156*2)
	MsgBox("Successfully installed deemator 0.2.0 to this computer.`nA startup link was placet at the desktop.", "deemator 0.2.0 installer")
	Sleep(156*2)
	ExitApp
} else {
	ExitApp
}
