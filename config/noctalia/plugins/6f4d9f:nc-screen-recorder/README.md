# Screen Recorder Plugin

A Noctalia Shell plugin for screen recording powered by [wl-screenrec](https://github.com/russelltg/wl-screenrec).

## Features

- **Bar Widget**: Shows recording status with video/audio indicators and pulse animation
- **Recording Controls**: Start/stop full-screen or region recording
- **Region Selection**: Interactive area selection via `slurp`
- **Audio Recording**: Toggle system audio capture (PipeWire)
- **Multi-Monitor**: Select which monitor to record
- **Format & Codec**: Configure container format (MP4/MKV/WebM) and encoder (H.264/H.265/VP8/VP9/AV1)
- **Bitrate Control**: Adjustable video bitrate
- **Custom Output**: Configurable save directory and file naming pattern

## Dependencies

- `wl-screenrec` — screen recording backend
- `slurp` — interactive region selection (optional, for region recording)

## Installation

Copy this plugin directory to your Noctalia plugins folder, or install via the plugin registry.

## Usage

1. Add the **Screen Recorder** widget to your bar
2. **Left-click** the widget to open the recording menu
3. Configure format, codec, bitrate, monitor, and audio as needed
4. Click **Start Recording** to begin
5. Click **Stop Recording** to finish — the file is saved to your configured directory
6. For region recording, click **Select Region** first, draw the area, then start recording

### File Naming

The default pattern is `recording_{datetime}`, which produces filenames like:

```
recording_2026-03-29_14-30-00.mp4
```

You can customize the pattern in the panel or settings. The `{datetime}` placeholder is replaced with a `yyyy-MM-dd_HH-mm-ss` timestamp.

### IPC Commands

```bash
qs -c noctalia-shell ipc call plugin:wl-screenrec startRecording
qs -c noctalia-shell ipc call plugin:wl-screenrec stopRecording
qs -c noctalia-shell ipc call plugin:wl-screenrec selectRegion
qs -c noctalia-shell ipc call plugin:wl-screenrec clearRegion
qs -c noctalia-shell ipc call plugin:wl-screenrec toggle
qs -c noctalia-shell ipc call plugin:wl-screenrec startRegionRecording
```

## License

MIT
