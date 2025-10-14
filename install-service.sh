[Unit]
Description=Maintain Arch by updating pacman and yay. Then, it clears the cache.
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStartPre=/usr/bin/rm -f /var/log/arch-maintenance.log
ExecStartPre=/usr/bin/touch /var/log/arch-maintenance.log
ExecStartPre=/usr/bin/chmod 644 /var/log/arch-maintenance.log
ExecStart=/your/path/here/maintenance.sh #put your path HERE!
StandardOutput=append:/var/log/arch-maintenance.log
StandardError=append:/var/log/arch-maintenance.log

[Install]
WantedBy=multi-user.target
