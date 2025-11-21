# Arch Linux Maintenance Script

Automates system maintenance on Arch Linux: updates `pacman` and AUR packages, cleans caches, removes orphan packages, and sends a desktop notification when done.

---

## Requirements

* Arch Linux.
* `yay` installed as an AUR helper.
* `libnotify` (`notify-send`).

---

## Usage
First, modify the path at `install-service.sh`, at `ExecStart=/your/path/here/maintenance.sh`. 
**If not done properly, it won't work!**
Then, execute the bash script for the first time:
```bash
chmod +x your/path/here/maintenance.sh
sudo your/path/here/maintenance.sh
#replace your/path/here with your actual path
```
You only need `sudo` for the initial setup. After that, the system service runs automatically with root privileges.

---

## What does it do?

* **Update Pacman**: `sudo pacman -Syu --noconfirm`.
* **Update AUR**: checks connectivity to `aur.archlinux.org` and updates with `yay -Syu --noconfirm`.
* **Clean caches**: `yay -Sc` and `sudo pacman -Sc`.
* **Remove orphans**: `pacman -Rns $(pacman -Qtdq)`.
* **Notification**: shows a desktop notification with update status.
* **Automation**: the service will run automatically at each login.
---
## Notes

* Fully silent; output is suppressed.
* Notification icons use standard system icons (`dialog-ok`, `flag-red`).

---
## To-do list
- [x] Implement install script to set it up as a service automatically.
- [x] Implement logs
