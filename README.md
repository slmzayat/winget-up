# WinGet Auto-Updater (`winget-up`)

Automated app maintenance for Windows 11. Keeps software updated, system sleep suppressed, processor priority maximized, and the desktop clean.

## Quick Start

Open **PowerShell as Administrator** and run:

```powershell
irm https://raw.githubusercontent.com/slmzayat/winget-up/main/winget-update.bat -OutFile winget-update.bat; .\winget-update.bat
```

## Usage

| Option        | Method                                                     | Behavior                                                                  |
| ------------- | ---------------------------------------------------------- | ------------------------------------------------------------------------- |
| **Manual**    | Double-click `winget-update.bat`                           | Runs on demand with live terminal output.                                 |
| **Automated** | Right-click `install-schedule.bat` -> Run as administrator | Registers a background task for the 2nd Sunday of every month at 3:00 AM. |

## Features

- **High CPU priority:** Launches `winget` using `start /wait /high`.
- **Sleep prevention:** Locks the AC power sleep timeout (`powercfg`) during downloads and restores it afterward.
- **Desktop sweeper:** Logs desktop shortcuts (including OneDrive paths) before updating and removes newly created icons.
- **Cache flushing:** Purges temporary installer files from `%TEMP%\WinGet`.
- **Dynamic auto-close:** Exits after 15 seconds when software was updated, 5 seconds when nothing needed updating.
- **Catppuccin Mocha theme:** Native ANSI 24-bit RGB colors.

## License

[MIT](LICENSE)
