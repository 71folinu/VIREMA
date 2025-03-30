#Requires AutoHotkey v2.0
#NoTrayIcon
TraySetIcon "icon.ico", , true

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
	MsgBox "A_IsAdmin: " A_IsAdmin "`nCommand line: " DllCall("GetCommandLine", "str"), "deemator installer"
	ExitApp
}

; INSTALLATION
if (MsgBox("Do you want to intall (reinstall) deemator to this computer?", "deemator installer", 4) = "Yes") {
	if DirExist("C:\deemator") {
		try {
			DirDelete("C:\deemator", 1)
		} catch {
			MsgBox("DirDelete`nerror", "deemator installer error")
			ExitApp
		}
	}
	Sleep(156*2)
	try {
		DirCreate("C:\deemator")
		DirCreate("C:\deemator\third_party")
	} catch {
		MsgBox("DirCreate`nerror", "deemator installer error")
		ExitApp
	}
	Sleep(156*2)
	try {
		FileInstall "C:\deemator\third_party\deemator_tor.exe", "C:\deemator\third_party\deemator_tor1.exe", 1
		FileInstall "C:\deemator\third_party\geoip", "C:\deemator\third_party\geoip1", 1
		FileInstall "C:\deemator\third_party\geoip6", "C:\deemator\third_party\geoip61", 1
		FileInstall "C:\deemator\third_party\lyrebird.exe", "C:\deemator\third_party\lyrebird.exe1", 1
		FileInstall "C:\deemator\deemator.lnk",A_Desktop . "\deemator1.lnk", 1
		FileInstall "C:\deemator\deemator.lnk", "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\deemator1.lnk", 1
		FileInstall "C:\deemator\icon.ico", "C:\deemator\icon1.ico", 1
		FileInstall "C:\deemator\LICENSE", "C:\deemator\LICENSE1", 1
		FileInstall "C:\deemator\main.exe", "C:\deemator\main1.exe", 1
		FileInstall "C:\deemator\torrc", "C:\deemator\torrc1", 1
	} catch {
		MsgBox("FileInstall`nerror", "deemator installer error")
		ExitApp
	}
	MsgBox("Successfully installed deemator to this computer.`nA startup link was placet at the desktop.", "deemator installer")
} else {
	ExitApp
}
