#!/bin/bash
# select_region.sh - Run slurp to select a region, then start gpu-screen-recorder for that region.
# Usage: select_region.sh <save_dir> <file_pattern> <video_format> <codec> <quality> <framerate> <record_audio>

SAVE_DIR="${1:-$HOME/Videos}"
FILE_PATTERN="${2:-recording_{datetime}}"
VIDEO_FORMAT="${3:-mp4}"
CODEC="${4:-auto}"
QUALITY="${5:-high}"
FRAMERATE="${6:-60}"
RECORD_AUDIO="${7:-false}"

# Expand ~
SAVE_DIR="${SAVE_DIR/#\~/$HOME}"

cleanup() {
  exit 130
}
trap cleanup SIGINT SIGTERM

sleep 0.5
REGION=$(slurp)
if [ -z "$REGION" ]; then
  exit 1
fi

# Create save directory
mkdir -p "$SAVE_DIR"

# Build filename
DATETIME=$(date +"%Y-%m-%d_%H-%M-%S")
FILENAME="${FILE_PATTERN//\{datetime\}/$DATETIME}"
OUTPUT_FILE="$SAVE_DIR/${FILENAME}.${VIDEO_FORMAT}"

# Build gpu-screen-recorder command
CMD="gpu-screen-recorder -w region -region $REGION -f $FRAMERATE -o '$OUTPUT_FILE'"

if [ "$CODEC" != "auto" ]; then
  CMD="$CMD -k $CODEC"
fi

if [ -n "$QUALITY" ]; then
  CMD="$CMD -q $QUALITY"
fi

if [ "$RECORD_AUDIO" = "true" ]; then
  CMD="$CMD -a default_output"
fi

echo "gpu-screen-recorder: $CMD"
eval $CMD
