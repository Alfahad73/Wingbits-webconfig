#!/bin/bash

# Print final message and user instructions

set -e

IP_ADDR=$(hostname -I | awk '{print $1}')

echo "=============================================="
echo "✅ Wingbits Web Config Panel installed successfully!"
echo "=============================================="
echo ""
echo "The control panel is now available at the following link:"
echo ""
echo "  http://$IP_ADDR:5000"
echo ""
echo "You can access it from any browser on the same network and open the link above."
echo ""
echo "----------------------------------------------"
echo "If you encounter any issues during operation:"
echo "  systemctl status wingbits-web-panel"
echo "  sudo systemctl restart wingbits-web-panel"
echo ""
echo "To stop or completely remove the service:"
echo "  sudo systemctl stop wingbits-web-panel"
echo "  sudo systemctl disable wingbits-web-panel"
echo "  rm -rf /opt/wingbits-station-web"
echo "  rm /etc/systemd/system/wingbits-web-panel.service"
echo ""
echo "----------------------------------------------"
echo "For support, please visit our Discord channel:"
echo "https://discord.com/channels/1082294632689455154/1384660050819158167"
echo ""
echo "To contribute to the script development via donation:"
echo "USDT (BSC/BEP20): 0x8FCFDc8B7978a5cCADc995f5d96D2A53F7c3cde5"
echo "----------------------------------------------"
echo ""
echo "================= Done ================="
echo ""
