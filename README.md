![VIREMA](https://github.com/user-attachments/assets/c317af5a-eb54-49d6-b665-111659f853d5)

Simplistic tor-powered proxy app for Windows 11, built using AutoHotkey v2.  
Effectively a simple host and command center for the `Tor Expert Bundle`.  
Inspired by `Invizible Pro` Android app.

## Compilation
To compile the app from source, use the `Ahk2Exe.exe` compiler provided in your AutoHotKey installation (by default located in `C:\Program files\AutoHotkey\Compiler\Ahk2Exe.exe`).
Steps necessary to compile the installer (the single distributed file):
1. Compile MAIN.ahk using ahk2exe (right click `main.ahk`, then select `Compile script (GUI)...`). Specify the icon `icon.ico`. Leave all the other fields as defaults.
2. In compiler window, go to `Help` -> `Check for Updates`. Update (or install, if not installed) everything there is. It might take a minute to load initially.
3. Compile installer.ahk using ahk2exe (right click `main.ahk`, then select `Compile script (GUI)...`). Specify the icon `icon.ico`, and compression `MPRESS`. Leave all the other fields as defaults. ***IMPORTANT: One needs to compile MAIN.ahk before running, testing or compiling installer.ahk.***
4. Move the result `VIREMA 0.?.? installer.exe` outside of the app working directory (it might delete itself when testing).

> [!WARNING]
> Program must be compiled using AutoHotkey version 2.0.19, undefined behavior might be expected otherwise.  
> All changes in file structure during development will have to be also written to the installer script for correct compilation.
