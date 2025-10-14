#!/bin/bash
set -euo pipefail
USR="usr" #put your user here!
UID_USER=$(id -u "$USR")
DBUS_ADDR="unix:path=/run/user/$UID_USER/bus"
if [[ ! -f /etc/systemd/system/arch-maintenance.service ]]; then
	echo "service doesn't exist, creating it..."
	sudo bash -c 'cat install-service.sh > /etc/systemd/system/arch-maintenance.service'
	echo "enabling it..."
	sudo systemctl daemon-reload
	sudo systemctl enable arch-maintenance.service
	echo "arch-maintenance.service created and enabled!"
else
	echo "arch-maintenance.service already exists"
fi

echo "==> updating pacman..."
pacman -Syu --noconfirm >/dev/null 2>&1 || echo "pacman update failed, continuing..."

echo "==> updating yay...(this will probably take a while)" #it does take quite a while the first time if you have not updated in a while

if nc -z -w1 aur.archlinux.org 443 >/dev/null 2>&1; then
    if sudo -u "$USR" yay -Syu --noconfirm >/dev/null 2>&1; then
	yay_msg="Yay updated!"
	icon="dialog-ok"
    else
	echo "Yay update failed..."
        yay_msg="Yay did not update"
        icon="flag-red"
    fi
else
    echo "aur.archlinux.org is down, retry in a few hours..."
    yay_msg="Yay did not update."
    icon="flag-red"
fi
    
echo "==> Cleaning yay cache"
sudo -u "$USR" yay -Sc --noconfirm >/dev/null 2>&1 || echo "yay cache cleanup failed, continuing..."


echo "==> Cleaning pacman cache"
pacman -Sc --noconfirm >/dev/null 2>&1 || echo "pacman cache cleanup failed, continuing..."

echo "==> Searching for pacman orphans..."
orphans=$(pacman -Qtdq 2>/dev/null || true)

if [[ -n "$orphans" ]]; then
  echo "Deleting orphans... "
  pacman -Rns --noconfirm $orphans >/dev/null 2>&1 || echo "failed to remove pacman orphans, continuing..."
else
  echo "There are no orphans."
fi

sudo -u "$USR" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="$DBUS_ADDR" notify-send -i "$icon" "Maintenance done! 
$yay_msg"

echo "==> Done!"
