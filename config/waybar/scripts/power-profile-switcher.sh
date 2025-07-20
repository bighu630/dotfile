#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

# Determine the next profile and switch to it
case "$current_profile" in
  "performance")
    next_profile="balanced"
    ;;
  "balanced")
    next_profile="power-saver"
    ;;
  "power-saver")
    next_profile="performance"
    ;;
  *)
    # Default to balanced if the current profile is unknown
    next_profile="balanced"
    ;;
esac

# Set the new profile
powerprofilesctl set "$next_profile"

# Send a notification
notify-send "Power Profile Changed" "Switched to <b>$next_profile</b> mode."
