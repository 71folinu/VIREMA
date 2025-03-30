# **deemator**
Simplistic tor-powered proxy app for Windows 11, built using AutoHotkey v2.  
Effectively a simple host and command center for the `Tor Expert Bundle`.  
Inspired by `Invizible Pro` Android app.
> [!NOTE]
> This application is still in active development, expect ***bugs and missing features***.
## Handling wndows proxy manualy
1. To see windows proxy settings, navigate to the Contol Panel first. Then select Category View.
2. Select "Network and Internet". You may also press the icon to the left.
3. Select "Internet Options". You may also press the icon to the left.
4. Navigate to "Connections" tab in the upper part of the new popup window.
5. Press "LAN settings" button in the lower part of the window.
### Enabling proxy manually
1. To enable proxy enable the "Use a proxy server for your LAN (These settings will not apply to dial-up or VPN connections)." checkbox.
2. The proxy is enabled. THe following steps will be the configuration (will only need to be done once).
3. After enabling proxy checkbox, make sure the "Bypass proxy server for local adresses" checkbox is set, then press "Advanced" button on the right to enter configuration.
4. In the popup menu you will see four lines (adress:port). ***Make sure each of these lines (address AND port) are empty.*** Then, in the "Socks" line enter adress `127.0.0.1` and port `9050`.
5. Make sure that the "Use the same proxy server for all protocols" checkbox is NOT set.
6. Press "OK" At the bottom to apply settings.
### Disabling proxy manually
To disable proxy you will need to UNSET the "Use a proxy server for your LAN (These settings will not apply to dial-up or VPN connections)." checkbox and press "OK" at the bottom. If you'll want to enable proxy again, you will just need to SET the checkbox again and press "OK" at the bottom. No additional configuration is required, as the settings were saved from the previous time they've been set.
## Compilation
To compile the app from source (perhaps you downloaded the repository as a `.zip`) and get the installer binary, compile the `installer.ahk` script using `Ahk2Exe.exe` provided in your AutoHotKey installation (by default located in `C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe`).
> [!WARNING]
> Program must be compiled using AutoHotKey version 2.0.19, undefined behavior might be expected otherwise.
