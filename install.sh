#!/bin/bash

# ==========================================
# Wingbits Station Web Config - Installer
# (Advanced Version by Gemini)
# ==========================================

set -e

echo ""
echo "======================================"
echo "      Wingbits Station Web Config"
echo "      Web Control Panel Installation Script"
echo "======================================"
echo ""
echo "This script will install all requirements, create the necessary files, "
echo "setup the web backend/frontend, and start the service automatically."
echo ""

# --- Check for root privileges ---
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run as root (sudo bash $0)"
    exit 1
fi

# --- 1. Check if Wingbits client is installed ---
if ! command -v wingbits &> /dev/null; then
    echo "------------------------------------------------------------"
    echo "⚠️ Wingbits client is not installed."
    echo ""
    read -p "Do you want to install it now? (yes/no): " choice

    case "$choice" in
      [yY]|[yY][eE][sS])
        echo "Starting Wingbits client installation..."

        # --- Interactively get location and ID ---
        read -p "Please enter your Latitude: " lat
        read -p "Please enter your Longitude: " lon
        read -p "Please enter your Station ID: " station_id

        # Validate inputs
        if [ -z "$lat" ] || [ -z "$lon" ] || [ -z "$station_id" ]; then
            echo "❌ Latitude, Longitude, and Station ID cannot be empty. Exiting."
            exit 1
        fi

        echo "Installing Wingbits client with the provided details..."
        
        # --- Run the installation ---
        curl -sL https://gitlab.com/wingbits/config/-/raw/master/download.sh | sudo loc="$lat, $lon" id="$station_id" bash
        
        echo "✅ Wingbits client installation finished."
        ;;
      [nN]|[nN][oO])
        echo "------------------------------------------------------------"
        echo "❌ Wingbits client is required for this panel to work."
        echo "You can run this installer again after installing the Wingbits client."
        echo "------------------------------------------------------------"
        exit 1
        ;;
      *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
    esac
else
    echo "✅ Wingbits client is already installed."
fi

echo ""
# --- 2. Check if wb-config is installed ---
if ! command -v wb-config &> /dev/null; then
    echo "wb-config is not installed, installing it now..."
    curl -sL https://gitlab.com/wingbits/config/-/raw/master/wb-config/install.sh | sudo bash
else
    echo "✅ wb-config is already installed."
fi

echo ""
# --- Make all sub-scripts executable ---
echo "Setting execute permissions for sub-scripts..."
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
chmod +x "$SCRIPT_DIR/dependencies.sh"
chmod +x "$SCRIPT_DIR/project-setup.sh"
chmod +x "$SCRIPT_DIR/backend-deps.sh"
chmod +x "$SCRIPT_DIR/backend-app.sh"
chmod +x "$SCRIPT_DIR/frontend-html.sh"
chmod +x "$SCRIPT_DIR/systemd-service.sh"
chmod +x "$SCRIPT_DIR/final-message.sh"
echo "Execute permissions set."
echo ""

# --- 3. Run individual setup scripts sequentially ---
echo "Starting installation of BYOD Web Config Panel..."

"$SCRIPT_DIR/dependencies.sh"
"$SCRIPT_DIR/project-setup.sh"
"$SCRIPT_DIR/backend-deps.sh"
"$SCRIPT_DIR/backend-app.sh"
"$SCRIPT_DIR/frontend-html.sh"
"$SCRIPT_DIR/systemd-service.sh"
"$SCRIPT_DIR/final-message.sh"

exit 0
