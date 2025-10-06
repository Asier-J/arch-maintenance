# Arch Linux Maintenance Script

Automates system maintenance on Arch Linux: updates `pacman` and AUR packages, cleans caches, removes orphan packages, and sends a desktop notification when done.

---

## Requirements

* Arch Linux
* `yay` installed
* `libnotify` (`notify-send`)

---

## Usage

```bash
~/scripts/maintenance.sh
```
---

## What does it do?

* **Update Pacman**: `sudo pacman -Syu --noconfirm` (silent)
* **Update AUR**: checks connectivity to `aur.archlinux.org` and updates with `yay -Syu --noconfirm`
* **Clean caches**: `yay -Sc` and `sudo pacman -Sc`
* **Remove orphans**: `pacman -Rns $(pacman -Qtdq)`
* **Notification**: shows a desktop notification with update status

---

## Notes

* Fully silent; output is suppressed.
* Make sure `sudo` does not require a password for pacman/yay if running automatically.
* Notification icons use standard system icons (`dialog-ok`, `flag-red`).
