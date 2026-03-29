import QtQuick
import Quickshell
import Quickshell.Io
import qs.Services.UI

Item {
  id: root

  property var pluginApi: null
  property bool useSlurp: false

  readonly property var cfg: pluginApi?.pluginSettings ?? ({})

  Component.onCompleted: {
    if (pluginApi) {
      pluginApi.pluginSettings.isRecording = false;
      pluginApi.pluginSettings.recordingFile = "";
      pluginApi.pluginSettings.recordingStartTime = 0;
      pluginApi.pluginSettings.selectedRegion = "";
      pluginApi.saveSettings();

      if (!pluginApi.ipcHandlers) {
        pluginApi.ipcHandlers = {};
      }
      pluginApi.ipcHandlers.startRecording = function() { root.startRecording(); };
      pluginApi.ipcHandlers.stopRecording = function() { root.stopRecording(); };
      pluginApi.ipcHandlers.startRegionRecording = function() { root.startRegionRecording(); };
    }
  }

  IpcHandler {
    target: "plugin:wl-screenrec"

    function toggle() {
      if (pluginApi) {
        pluginApi.withCurrentScreen(screen => {
          pluginApi.openPanel(screen);
        });
      }
    }
  }

  function startRecording() {
    startRecordingInternal(false);
  }

  function startRegionRecording() {
    // Close panel immediately
    if (pluginApi && pluginApi.closePanel) {
      pluginApi.closePanel();
    }
    startRecordingInternal(true, true);
  }

  function stopRecording() {
    if (!cfg.isRecording) return;
    recorderProcess.signal(2);
  }

  function startRecordingInternal(useRegion, withDelay) {
    if (pluginApi?.pluginSettings?.isRecording) return;

    useSlurp = useRegion;

    var dir = resolveHome(pluginApi?.pluginSettings?.saveDirectory || "~/Videos");
    mkdirProcess.command = ["mkdir", "-p", dir];

    if (withDelay) {
      delayTimer.interval = 2000;
      delayTimer.start();
    } else {
      mkdirProcess.running = true;
    }
  }

  Timer {
    id: delayTimer
    onTriggered: {
      mkdirProcess.running = true;
    }
  }

  function resolveHome(path) {
    if (path && path.startsWith("~/")) {
      return Quickshell.env("HOME") + path.substring(1);
    }
    return path || "~/Videos";
  }

  function buildFilename() {
    var dir = resolveHome(cfg.saveDirectory || "~/Videos");
    var pattern = cfg.filePattern || "recording_{datetime}";
    var ext = cfg.videoFormat || "mp4";

    var now = new Date();
    var datetime = Qt.formatDateTime(now, "yyyy-MM-dd_HH-mm-ss");
    var filename = pattern.replace("{datetime}", datetime);

    return dir + "/" + filename + "." + ext;
  }

  function buildShellCommand() {
    var file = buildFilename();
    var cmd = "wl-screenrec -f " + file;

    if (useSlurp) {
      cmd = "sleep 2 && " + cmd + ' -g "$(slurp)"';
      useSlurp = false;
    } else if (cfg.selectedRegion && cfg.selectedRegion !== "") {
      cmd += " -g " + cfg.selectedRegion;
    } else if (cfg.selectedMonitor && cfg.selectedMonitor !== "") {
      cmd += " -o " + cfg.selectedMonitor;
    }

    if (cfg.recordAudio) {
      cmd += " --audio";
    }

    if (cfg.codec && cfg.codec !== "auto") {
      cmd += " --codec " + cfg.codec;
    }

    if (cfg.bitrate && cfg.bitrate !== "") {
      cmd += " -b \"" + cfg.bitrate + "\"";
    }

    pluginApi.pluginSettings.recordingFile = file;
    return cmd;
  }

  Process {
    id: mkdirProcess
    command: ["mkdir", "-p", ""]

    onExited: function(exitCode, exitStatus) {
      if (exitCode === 0) {
        var cmd = root.buildShellCommand();
        console.log("wl-screenrec:", cmd);
        // Use bash -l to load user environment (including WAYLAND_DISPLAY)
        recorderProcess.command = ["bash", "-l", "-c", cmd];
        recorderProcess.running = true;
      } else {
        ToastService.showNotice("Failed to create save directory");
      }
    }
  }

  Process {
    id: recorderProcess

    onStarted: {
      pluginApi.pluginSettings.isRecording = true;
      pluginApi.pluginSettings.recordingStartTime = Date.now();
      pluginApi.saveSettings();
      ToastService.showNotice("Recording started");
      if (pluginApi && pluginApi.closePanel) {
        pluginApi.closePanel();
      }
    }

    onExited: function(exitCode, exitStatus) {
      var file = pluginApi.pluginSettings.recordingFile;
      pluginApi.pluginSettings.isRecording = false;
      pluginApi.pluginSettings.recordingFile = "";
      pluginApi.pluginSettings.recordingStartTime = 0;
      pluginApi.saveSettings();

      // Close panel when recording stops
      if (pluginApi && pluginApi.closePanel) {
        pluginApi.closePanel();
      }

      if (exitCode === 0 || exitCode === 255) {
        ToastService.showNotice("Recording saved: " + file);
      } else {
        ToastService.showNotice("Recording failed (exit code: " + exitCode + ")");
      }
    }

    stdout: SplitParser {
      onRead: function(data) {
        console.log("wl-screenrec stdout:", data);
      }
    }

    stderr: SplitParser {
      onRead: function(data) {
        console.log("wl-screenrec stderr:", data);
      }
    }
  }
}
