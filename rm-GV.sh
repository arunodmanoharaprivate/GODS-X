#!/bin/bash

# @fileOverview Check usage stats of arunodmanoharaprivate
# @author MasterHide
# @Copyright © 2025 x404 MASTER™
# @license MIT
#
# You may not reproduce or distribute this work, in whole or in part, 
# without the express written consent of the copyright owner.
#
# For more information, visit: https://t.me/@arunodmanoharaofficial


# Ask user for confirmation
echo "This script will uninstall GODS-X and all associated files. Are you sure you want to proceed? (y/n)"
read CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "Uninstallation canceled."
    exit 0
fi

# Stop and disable the systemd service
echo "Stopping and disabling the GODS-X service..."
sudo systemctl stop GODS-X
sudo systemctl disable GODS-X

# Remove the systemd service file
echo "Removing the GODS-X systemd service file..."
sudo rm -f /etc/systemd/system/GODS-X.service

# Reload systemd to reflect changes
sudo systemctl daemon-reload

# Ask for the OS username used during installation
echo "Enter the OS username used during installation (e.g., ubuntu):"
read USERNAME

# Remove the GODS-X directory and its contents
echo "Removing the GODS-X directory..."
sudo rm -rf /home/$USERNAME/GODS-X

# Remove SSL certificates
echo "Removing SSL certificates..."
sudo rm -rf /var/lib/GODS-X/certs

# Remove acme.sh (optional, if it was installed specifically for GODS-X)
echo "Removing acme.sh (SSL certificate tool)..."
sudo rm -rf /root/.acme.sh

# Remove cron job added by acme.sh (if any)
echo "Removing acme.sh cron job..."
sudo crontab -l | grep -v "/root/.acme.sh/acme.sh --cron" | sudo crontab -

# Remove log files
echo "Removing GODS-X log files..."
sudo rm -f /var/log/GODS-X.log

# Optional: Remove Python dependencies (if no longer needed)
echo "Do you want to uninstall Python dependencies installed for GODS-X? (y/n)"
read REMOVE_DEPS

if [ "$REMOVE_DEPS" == "y" ]; then
    echo "Uninstalling Python dependencies..."
    sudo apt remove -y python3-pip python3-venv git sqlite3 socat
    sudo apt autoremove -y
else
    echo "Skipping Python dependency removal."
fi

# Final message
echo "GODS-X has been successfully uninstalled."
