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

title WinGet Auto-Updater - Task Scheduler Deployer
cls

echo %cSapphire%============================================================%cReset%
echo %cMauve%                SCHEDULED TASK INSTALLER%cReset%
echo %cSapphire%============================================================%cReset%
echo.

:: 3. Target Batch File Verification
set "TargetScript=%~dp0winget-update.bat"

if not exist "%TargetScript%" (
    echo %cPeach%[!] Error:%cReset% Could not locate 'winget-update.bat' in directory:
    echo     %TargetScript%
    echo.
    echo %cPeach%[*]%cReset% Ensure both scripts reside in the same directory
    timeout /t 5 >nul
    exit /b
)

:: 4. Register Scheduled Task (2nd Sunday of Every Month at 3:00 AM)
echo %cPeach%[*]%cReset% Target script: %TargetScript%
echo %cPeach%[*]%cReset% Registering Windows Scheduled Task

schtasks /Create /TN "WinGet Auto-Updater" ^
    /TR "\"%TargetScript%\"" ^
    /SC MONTHLY /MO SECOND /D SUN ^
    /ST 03:00 ^
    /RU "NT AUTHORITY\SYSTEM" ^
    /RL HIGHEST ^
    /F >nul 2>&1

if %errorLevel% equ 0 (
    echo   %cGreen%›%cReset% Task 'WinGet Auto-Updater' created successfully
    echo   %cGreen%›%cReset% Schedule: 2nd Sunday of every month at 3:00 AM
    echo   %cGreen%›%cReset% Context : SYSTEM Account (Silent execution)
) else (
    echo   %cPeach%! Failed to register scheduled task%cReset%
)

:: 5. Complete Setup with 5-Second Auto-Close Timer
echo.
echo %cGreen%[✓] Setup complete%cReset%
echo %cComment%[*] Press any key to exit immediately (auto-closing in 5s)%cReset%
timeout /t 5 >nul
exit /b