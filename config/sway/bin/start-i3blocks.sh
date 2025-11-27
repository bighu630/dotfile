#!/bin/bash
# i3blocks startup script for sway

# Kill any existing i3blocks processes
pkill -f i3blocks

# Wait a moment for processes to terminate
sleep 0.5

# Start i3blocks with the custom config
exec i3blocks -c ~/.config/sway/i3blocks.conf
