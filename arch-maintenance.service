[Unit]
Description=Maintain Arch by updating pacman and yay. Then, it clears the cache.
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/mnt/hdd600/programming/scripts/arch-maintenance/maintenance.sh

[Install]
WantedBy=default.target
