#!/bin/bash

while true; do
  # Get clipboard contents
  clipboard_content=$(xclip -o -selection clipboard 2>/dev/null)

  # Check if clipboard content is changed.  A simple check for non-empty string. More robust checks might be needed.
  if [[ -n "$clipboard_content" ]]; then
    # Add to cliphist.  Replace 'cliphist-add' if your cliphist command is different.
    wl-copy "$clipboard_content"

    #Optional: Add a timestamp for better logging.
    #date "+%Y-%m-%d %H:%M:%S" >> clip_log.txt
    #echo "$clipboard_content" >> clip_log.txt

  fi
  sleep 1 # Check every 1 second. Adjust as needed.
done
