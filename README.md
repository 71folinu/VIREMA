# deemator
Simplistic tor-powered proxy app for Windows 11, built using AutoHotkey v2.
## Wndows proxy manual
1. To see windows proxy settings, navigate to the Contol Panel first. Then select Category View.
2. Select "Network and Internet". You may also press the icon to the left.
3. Select "Internet Options". You may also press the icon to the left.
4. Navigate to "Connections" tab in the upper part of the new popup window.
5. Press "LAN settings" button in the lower part of the window.
### Enabling proxy
1. To enable proxy enable the "Use a proxy server for your LAN (These settings will not apply to dial-up or VPN connections)." checkbox.
2. The proxy is enabled. THe following steps will be the configuration (will only need to be done once).
3. After enabling proxy checkbox, make sure the "Bypass proxy server for local adresses" checkbox is set, then press "Advanced" button on the right to enter configuration.
4. In the popup menu you will see four lines (adress:port). Make sure each of these lines (address AND port) are empty. Then, in the "Socks" line enter adress YET_TO_DEFINE and port YET_TO_DEFINE.
5. Make sure that the "Use the same proxy server for all protocols" checkbox is NOT set.
6. Press "OK" At the bottom to apply settings.
### DIsabling proxy
To disable proxy you will need to UNSET the "Use a proxy server for your LAN (These settings will not apply to dial-up or VPN connections)." checkbox and press "OK" at the bottom. If you'll want to enable proxy again, you will just need to SET the checkbox again and press "OK" at the bottom. No additional configuration is required, as the settings were saved from the previous time they've been set.
