````markdown
# WinGet Auto-Updater (`winget-up`)

Automated app maintenance for Windows 11. Keeps your software updated, system sleep suppressed, processor priority maximized, and desktop clean.

## ⚡ Quick Start

### One-Line PowerShell Installation

Open **PowerShell as Administrator** and run:

```powershell
irm [https://raw.githubusercontent.com/slmzayat/winget-up/main/winget-update.bat](https://raw.githubusercontent.com/slmzayat/winget-up/main/winget-update.bat) -OutFile winget-update.bat; .\winget-update.bat
```
````

## 🛠️ Usage

| Option        | Method                                                      | Behavior                                                                  |
| ------------- | ----------------------------------------------------------- | ------------------------------------------------------------------------- |
| **Manual**    | Double-click `winget-update.bat`                            | Runs on demand with live terminal output.                                 |
| **Automated** | Right-click `install-schedule.bat` → _Run as administrator_ | Registers a background task for the 2nd Sunday of every month at 3:00 AM. |

## ✨ Features

- **High CPU Priority:** Launches `winget` using `start /wait /high` to allocate maximum CPU resources.
- **Sleep Prevention:** Temporarily locks AC power sleep timeout (`powercfg`) during downloads and restores it on completion.
- **Desktop Sweeper:** Logs desktop shortcuts before updating (including OneDrive-backed paths) and removes newly spawned icons.
- **Cache Flushing:** Automatically purges temporary installer files from `%TEMP%\WinGet`.
- **Dynamic Auto-Close:** Uses a 15-second exit timer when software updates occur, and a 5-second timer when no packages require updating.
- **Catppuccin Mocha Theme:** Styled with native ANSI 24-bit RGB typography.

## 📄 License

[MIT](LICENSE)

```

```
