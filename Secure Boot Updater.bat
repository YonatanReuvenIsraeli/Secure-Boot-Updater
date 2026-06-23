@echo off
title Secure Boot Updater
setlocal
echo Program Name: Secure Boot Updater
echo Version: 1.0.0
echo License: GNU General Public License v3.0
echo Developer: @YonatanReuvenIsraeli
echo GitHub: https://github.com/YonatanReuvenIsraeli
echo Sponsor: https://github.com/sponsors/YonatanReuvenIsraeli
"%windir%\System32\net.exe" session > nul 2>&1
if not "%errorlevel%"=="0" goto "NotAdministrator"
"%windir%\System32\net.exe" user > nul 2>&1
if not "%errorlevel%"=="0" goto "InPERE"
goto "Start"

:"NotAdministrator"
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"InPERE"
echo.
echo You are in Windows Preinstallation Environment or Windows Recovery Environment! You must run this batch file in Windows. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"Close"
endlocal
exit

:"Start"
echo.
echo Press any key to update Secure boot.
pause > nul 2>&1
goto "Update"

:"Update"
if exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure boot Updater.bat" goto "Exist"
echo.
echo Updating Secure boot.
"%windir%\System32\reg.exe" add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Secureboot" /v AvailableUpdates /t REG_DWORD /d 0x5944 /f > nul 2>&1
"%windir%\System32\schtasks.exe" /run /tn "\Microsoft\Windows\PI\Secure-Boot-Update" > nul 2>&1
(echo @echo off) > "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo title Secure Boot Updater) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo setlocal) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo "%windir%\System32\schtasks.exe" /run /tn "\Microsoft\Windows\PI\Secure-Boot-Update" ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo echo Secure boot has been updated. Press any key to close this batch file.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo start "" /min "%windir%\System32\cmd.exe" /c del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" /f /q ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo pause ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo endlocal) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo exit) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
echo Restart needed to finish updating Secure boot. Please save everything you want before restarting this PC! Press any key to restart this PC.
pause > nul 2>&1
"%windir%\System32\shutdown.exe" /r /t 0
exit

:"Exist"
echo Please rename to something else or move to another location "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" in order for this batch file to proceed. "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" is not a system file. Press any key to continue when "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" is renamed to something else or moved to another location.
pause > nul 2>&1
goto "Update"
