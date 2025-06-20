#!/bin/bash

# Set up systemd service for Wingbits web panel

set -e

echo "Setting up systemd service to run the control panel..."

INSTALL_DIR="/opt/wingbits-station-web"
BACKEND_DIR="$INSTALL_DIR/backend"

cat > /etc/systemd/system/wingbits-web-panel.service <<EOF
[Unit]
Description=Wingbits Station Web Config Panel
After=network.target

[Service]
User=root
WorkingDirectory=$BACKEND_DIR
ExecStart=$BACKEND_DIR/venv/bin/python3 $BACKEND_DIR/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable wingbits-web-panel.service
systemctl restart wingbits-web-panel.service

echo ""
echo "The control panel is now running as a persistent service!"
echo ""