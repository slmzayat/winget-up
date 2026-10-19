@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: 1. Auto-Elevation
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: 2. UI Setup & Catppuccin Mocha ANSI Color Palette
for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "ESC=%%E"
set "cFg=%ESC%[38;2;205;214;244m"
set "cComment=%ESC%[38;2;166;173;200m"
set "cSapphire=%ESC%[38;2;116;199;236m"
set "cGreen=%ESC%[38;2;166;227;161m"
set "cPeach=%ESC%[38;2;250;179;135m"
set "cMauve=%ESC%[38;2;203;166;247m"
set "cReset=%ESC%[0m"

title WinGet Auto-Updater
cls

echo %cSapphire%============================================================%cReset%
echo %cMauve%                    WINGET AUTO-UPDATER%cReset%
echo %cSapphire%============================================================%cReset%
echo.

:: 3. Pre-Flight Configuration
echo %cPeach%[*]%cReset% Disabling AC sleep timer
powercfg -change -standby-timeout-ac 0

echo %cPeach%[*]%cReset% Snapshotting desktop shortcuts
set "PublicDesk=%Public%\Desktop"
set "LocalDesk=%UserProfile%\Desktop"
set "CloudDesk=%UserProfile%\OneDrive\Desktop"
set "PreLog=%temp%\wg_shortcuts.txt"
set "OutLog=%temp%\wg_output.log"

dir /b "%LocalDesk%\*.lnk" "%CloudDesk%\*.lnk" "%PublicDesk%\*.lnk" > "%PreLog%" 2>nul

:: 4. Execution with Output Capture
echo.
echo %cSapphire%------------------------------------------------------------%cReset%
echo %cPeach%[*]%cReset% Upgrading packages at High CPU priority
echo %cSapphire%------------------------------------------------------------%cReset%
echo.

start /wait /high "" cmd /c "winget upgrade --all --silent --include-unknown --accept-package-agreements --accept-source-agreements > "%OutLog%" 2>&1"

:: Display raw winget log output
type "%OutLog%"

echo.
echo %cSapphire%------------------------------------------------------------%cReset%

:: 5. Summary Report & Post-Flight Cleanup
echo %cPeach%[*]%cReset% Updated Package Summary:
echo.
set "foundApp=0"
for /f "tokens=1,* delims= " %%A in ('findstr /i /c:"Upgrading" /c:"Successfully installed" "%OutLog%" 2^>nul') do (
    echo   %cGreen%›%cReset% %%A %%B
    set "foundApp=1"
)
if "!foundApp!"=="0" (
    echo   %cComment%› No package updates were required%cReset%
)
echo.

echo %cPeach%[*]%cReset% Scanning for new desktop shortcuts
for %%F in ("%LocalDesk%\*.lnk" "%CloudDesk%\*.lnk" "%PublicDesk%\*.lnk") do (
    findstr /i /x /c:"%%~nxF" "%PreLog%" >nul 2>&1
    if errorlevel 1 (
        echo   %cGreen%+ %cReset%Removing shortcut: %%~nxF
        del /f /q "%%F" >nul 2>&1
    )
)

:: Clean up temporary installer cache and logs
echo %cPeach%[*]%cReset% Flushing WinGet installer cache
rmdir /s /q "%TEMP%\WinGet" >nul 2>&1
del /f /q "%PreLog%" "%OutLog%" >nul 2>&1

echo %cPeach%[*]%cReset% Restoring AC sleep timer to 3 minutes
powercfg -change -standby-timeout-ac 3

:: 6. Dynamic Auto-Close Exit Logic
echo.
echo %cGreen%[✓] Maintenance complete%cReset%

if "!foundApp!"=="1" (
    set "exitTimer=15"
) else (
    set "exitTimer=5"
)

echo %cComment%[*] Press any key to exit immediately (auto-closing in !exitTimer!s)%cReset%
timeout /t !exitTimer! >nul
exit /b