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
goto "SecureBootSet"

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

:"SecureBootSet"
set SecureBootExist=
goto "Start"

:"Start"
if exist "SecureBoot.txt" goto "SecureBootExist"
echo.
echo Checking Secure boot status.
"%windir%\System32\reg.exe" query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing" /v "UEFICA2023Status" | "%windir%\System32\find.exe" /i "UEFICA2023Status" > "SecureBoot.txt"
set /p SecureBoot=< "SecureBoot.txt"
del "SecureBoot.txt" /f /q > nul 2>&1
if /i "%SecureBootExist%"=="True" echo.
if /i "%SecureBootExist%"=="True" echo You can now rename or move the file back to "SecureBoot.txt". Press any key to continue.
if /i "%SecureBootExist%"=="True" pause > nul 2>&1
if /i "%SecureBootExist%"=="True" echo.
if /i "%SecureBoot%"=="    UEFICA2023Status    REG_SZ    Updated" goto "AlreadyUpdated"
if /i "%SecureBootExist%"=="" echo Secure boot is not updated. Press any key to update Secure boot.
pause > nul 2>&1
goto "Update"

:"SecureBootExist"
set SecureBootExist=True
echo.
echo Please temporarily rename to something else or temporarily move to another location "SecureBoot.txt" in order for this batch file to proceed. "SecureBoot.txt" is not a system file. "SecureBoot.txt" is located in the folder "%cd%". Press any key to continue when "SecureBoot.txt" is renamed to something else or moved to another location. This batch file will let you know when you can rename it back to its original name or move it back to its original location.
pause > nul 2>&1
goto "Start"

:"AlreadyUpdated"
echo Secure boot is already updated. Press any key to close this batch file.
pause > nul 2>&1
endlocal
exit

:"Update"
if exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure boot Updater.bat" goto "Exist"
echo.
echo Updating Secure boot.
"%windir%\System32\reg.exe" add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Secureboot" /v AvailableUpdates /t REG_DWORD /d 0x5944 /f > nul 2>&1
"%windir%\System32\schtasks.exe" /run /tn "\Microsoft\Windows\PI\Secure-Boot-Update" > nul 2>&1
(echo @echo off) > "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo title Secure Boot Updater) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo setlocal) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo "%%windir%%\System32\schtasks.exe" /run /tn "\Microsoft\Windows\PI\Secure-Boot-Update" ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo goto "SecureBootSet") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo :"SecureBootSet") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo set SecureBootExist=) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo goto "UpdateCheck") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo :"UpdateCheck") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo if exist "SecureBoot.txt" goto "SecureBootExist") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo "%%windir%%\System32\reg.exe" query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecureBoot\Servicing" /v "UEFICA2023Status" ^| "%%windir%%\System32\find.exe" /i "UEFICA2023Status" ^> "SecureBoot.txt") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo set /p SecureBoot=^< "SecureBoot.txt") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo del "SecureBoot.txt" /f /q ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo if /i "%%SecureBootExist%%"=="True" echo.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo if /i "%%SecureBootExist%%"=="True" echo You can now rename or move the file back to "SecureBoot.txt". Press any key to continue.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo if /i "%%SecureBootExist%%"=="True" pause ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo if /i "%%SecureBootExist%%"=="True" echo.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo if /i "%%SecureBoo%%"=="    UEFICA2023Status    REG_SZ    Updated" echo Secure boot has been updated. Press any key to close this batch file.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo if /i not "%%SecureBoo%%"=="    UEFICA2023Status    REG_SZ    Updated" echo There has been an error and Secure boot has not been updated. Press any key to close this batch file.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo start "" /min "%%windir%%\System32\cmd.exe" /c del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" /f /q ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo pause ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo endlocal) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo exit) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo :"SecureBootExist") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo set SecureBootExist=True) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo echo Please temporarily rename to something else or temporarily move to another location "SecureBoot.txt" in order for this batch file to proceed. "SecureBoot.txt" is not a system file. "SecureBoot.txt" is located in the folder "%%cd%%". Press any key to continue when "SecureBoot.txt" is renamed to something else or moved to another location. This batch file will let you know when you can rename it back to its original name or move it back to its original location.) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo pause ^> nul 2^>^&1) >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
(echo goto "UpdateCheck") >> "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat"
echo Restart needed to finish updating Secure boot. Please save everything you want before restarting this PC! Press any key to restart this PC.
pause > nul 2>&1
"%windir%\System32\shutdown.exe" /r /t 0
exit

:"Exist"
echo Please rename to something else or move to another location "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" in order for this batch file to proceed. "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" is not a system file. Press any key to continue when "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Secure Boot Updater.bat" is renamed to something else or moved to another location.
pause > nul 2>&1
goto "Update"
