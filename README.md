# WinGet Auto-Updater (`winget-up`)

Automated app maintenance for Windows 11. Keeps your software updated, system sleep suppressed, processor priority maximized, and desktop clean.

---

## 📥 Setup & Installation

1. Download the scripts (`winget-update.bat` and `install-schedule.bat`) from this repository.
2. Save them to a permanent folder on your PC where they won't be accidentally deleted.

---

## 🛠️ Usage

| Option | Method | Behavior |
| :--- | :--- | :--- |
| **Manual** | Double-click `winget-update.bat` | Runs on-demand with live terminal output. |
| **Automated** | Right-click `install-schedule.bat` $\rightarrow$ **Run as Administrator** | Registers a background task for the 2nd Sunday of every month at 3:00 AM. |

---

## ✨ Features

* **🚀 High CPU Priority:** Allocates maximum CPU resources using `start /wait /high`.
* **🔋 Sleep Prevention:** Temporarily locks AC power sleep timeout (`powercfg`) during execution.
* **🧹 Desktop Sweeper:** Cleans up newly spawned desktop shortcut icons post-update.
* **🗑️ Cache Flushing:** Purges temporary installer files from `%TEMP%\WinGet`.
* **⏱️ Dynamic Auto-Close:** Exits after 15 seconds if updates occur, or 5 seconds if everything is up to date.
* **🎨 Catppuccin Mocha Theme:** Styled with native ANSI 24-bit RGB typography.

---

## 📄 License

Distributed under the [MIT License](LICENSE).
