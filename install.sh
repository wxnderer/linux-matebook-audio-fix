#!/bin/bash

# Define paths for the script and service file
MONITOR_SCRIPT="$HOME/.monitor_sound.sh"
SERVICE_FILE='/etc/systemd/system/monitor_sound.service'

# Create the monitor sound script
echo "Creating monitor sound script..."
cat << 'EOF' > $MONITOR_SCRIPT
#!/bin/bash
# Require inotify-tools package
inotifywait -m /dev/snd/ -e open -e access |
while read path action file; do
    hda-verb /dev/snd/hwC0D0 0x16 0x701 0x0001
    hda-verb /dev/snd/hwC0D0 0x17 0x70C 0x0002
    hda-verb /dev/snd/hwC0D0 0x1 0x715 0x2
    sleep 2
done
EOF

# Make the monitor script executable
chmod +x $MONITOR_SCRIPT

# Create the systemd service file
echo "Creating systemd service file..."
sudo bash -c "cat <<EOF > $SERVICE_FILE
[Unit]
Description=Monitor Sound Device Access and Execute Script
After=network.target sound.target

[Service]
ExecStart=$MONITOR_SCRIPT
Restart=always
#User=$USER

[Install]
WantedBy=default.target
EOF"

# Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable the service to start on boot
echo "Enabling the monitor sound service..."
sudo systemctl enable monitor_sound
