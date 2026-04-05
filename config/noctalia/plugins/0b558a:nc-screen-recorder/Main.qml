import QtQuick
import Quickshell
import Quickshell.Io
import qs.Services.UI

Item {
  id: root

  property var pluginApi: null

  readonly property var cfg: pluginApi?.pluginSettings ?? ({})

  // Region selector state
  property string selectedRegionGeometry: ""
  property var regionScreen: null
  property bool waitingForRegion: false

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

  // Normal recording
  function startRecording() {
    if (pluginApi?.pluginSettings?.isRecording) return;

    if (pluginApi && pluginApi.closePanel) {
      pluginApi.closePanel();
    }

    // Use portal if no monitor selected, otherwise use selected monitor
    var usePortal = !(cfg.selectedMonitor && cfg.selectedMonitor !== "");

    if (usePortal) {
      // Use RegionSelector instead of portal
      showRegionSelectorForRecording();
    } else {
      createDirAndRecord(false);
    }
  }

  // Region recording: use RegionSelector instead of slurp script
  function startRegionRecording() {
    if (pluginApi?.pluginSettings?.isRecording) return;

    if (pluginApi && pluginApi.closePanel) {
      pluginApi.closePanel();
    }

    showRegionSelectorForRecording();
  }

  function stopRecording() {
    if (!cfg.isRecording) return;
    // Try to stop whichever process is running
    recorderProcess.signal(2);
    regionScriptProcess.signal(2);
  }

  function runRegionScript() {
    var dir = resolveHome(cfg.saveDirectory || "~/Videos");
    var pattern = cfg.filePattern || "recording_{datetime}";
    var ext = cfg.videoFormat || "mp4";
    var codec = cfg.codec || "auto";
    var quality = cfg.quality || "high";
    var framerate = cfg.framerate || "60";
    var audioSource = cfg.audioSource || "none";
    var audio = (audioSource !== "none") ? "true" : "false";

    var scriptPath = Quickshell.env("HOME") + "/.config/quickshell/plugins/wl-screenrec/select_region.sh";
    regionScriptProcess.command = [
      "bash", "-l", "-c",
      "bash '" + scriptPath + "' '" + dir + "' '" + pattern + "' '" + ext + "' '" + codec + "' '" + quality + "' '" + framerate + "' '" + audio + "'"
    ];
    regionScriptProcess.running = true;
  }

  function createDirAndRecord(usePortal) {
    createDirAndRecordImpl(usePortal || false);
  }

  function createDirAndRecordImpl(usePortal) {
    var dir = resolveHome(cfg.saveDirectory || "~/Videos");
    mkdirProcess.command = ["mkdir", "-p", dir];
    mkdirProcess.running = true;
    mkdirProcess.usePortal = usePortal;
  }

  Process {
    id: mkdirProcess
    command: ["mkdir", "-p", ""]
    property bool usePortal: false

    onExited: function(exitCode, exitStatus) {
      if (exitCode === 0) {
        buildAndRunRecorder(usePortal);
      } else {
        ToastService.showNotice(pluginApi?.tr("notification.failedToCreateDirectory") || "Failed to create save directory");
      }
    }
  }

  function buildAndRunRecorder(usePortal) {
    var file = buildFilename();
    var cmd = "gpu-screen-recorder";

    // Stream destination or file output
    var streamDestination = cfg.streamDestination || "";
    var destinations = cfg.streamDestinations || {};
    var streamUrl = streamDestination ? (destinations[streamDestination] || "") : "";
    if (streamUrl) {
      // Streaming mode
      cmd += " -o '" + streamUrl + "'";
      pluginApi.pluginSettings.recordingFile = "";
      cmd += " -c flv"
    } else {
      // File recording mode
      cmd += " -o '" + file + "'";
      pluginApi.pluginSettings.recordingFile = file;
    }

    // Window/monitor selection
    if (cfg.selectedMonitor && cfg.selectedMonitor !== "") {
      cmd += " -w " + cfg.selectedMonitor;
    } else if (selectedRegionGeometry !== "") {
      // Use selected region geometry instead of portal
      // Format: -region WxH+X+Y

      cmd += " -w region";
      cmd += " -region " + selectedRegionGeometry;
    } else {
      cmd += " -w screen";
    }

    // Framerate
    var framerate = cfg.framerate || "60";
    cmd += " -f " + framerate;

    // Codec
    if (cfg.codec && cfg.codec !== "auto") {
      cmd += " -k " + cfg.codec;
    }

    // Audio
    if (cfg.audioSource && cfg.audioSource !== "none") {
      if (cfg.audioSource === "mic") {
        cmd += " -a default_input";
      } else if (cfg.audioSource === "desktop") {
        cmd += " -a default_output";
      } else if (cfg.audioSource === "both") {
        cmd += " -a 'default_output|default_input'";
      }
    }

    // Quality preset
    if (cfg.quality) {
      cmd += " -q " + cfg.quality;
    }



    console.log("gpu-screen-recorder:", cmd);
    recorderProcess.command = ["bash", "-l", "-c", cmd];
    recorderProcess.usePortal = usePortal;
    recorderProcess.useStreaming = !!streamUrl;
    recorderProcess.running = true;
  }

  // Process to show notification with button
  Process {
    id: notificationProcess

    stdout: SplitParser {
      onRead: function(data) {
        var output = String(data).trim();
        console.log("Notification action:", output);

        if (output === "openFolder") {
          var file = pluginApi?.pluginSettings?.lastRecordingFile || "";
          if (file) {
            // Extract directory from file path
            var dir = file.substring(0, file.lastIndexOf("/"));
            if (dir) {
              Quickshell.execDetached(["xdg-open", dir]);
            }
          }
        }
      }
    }
  }

  // Region: runs slurp + mkdir + wl-screenrec all in one script
  Process {
    id: regionScriptProcess

    onStarted: {
      pluginApi.pluginSettings.isRecording = true;
      pluginApi.pluginSettings.recordingStartTime = Date.now();
      pluginApi.saveSettings();
      ToastService.showNotice(pluginApi?.tr("notification.recordingStarted") || "Recording started");
      if (pluginApi && pluginApi.closePanel) {
        pluginApi.closePanel();
      }
    }

    onExited: function(exitCode, exitStatus) {
      pluginApi.pluginSettings.isRecording = false;
      var file = pluginApi.pluginSettings.recordingFile;
      pluginApi.pluginSettings.recordingFile = "";
      pluginApi.pluginSettings.lastRecordingFile = file;
      pluginApi.pluginSettings.recordingStartTime = 0;
      pluginApi.saveSettings();

      if (pluginApi && pluginApi.closePanel) {
        pluginApi.closePanel();
      }

      if (exitCode === 0 || exitCode === 255) {
        if (file) {
          showNotificationWithButtons(file);
        } else {
          ToastService.showNotice(pluginApi?.tr("notification.recordingSaved") || "Recording saved");
        }
      } else {
        var msg = pluginApi?.tr("notification.recordingFailed") || "Recording failed (exit code: {code})";
        ToastService.showNotice(msg.replace("{code}", exitCode));
      }
    }

    stderr: SplitParser {
      onRead: function(data) {
        console.log("gpu-screen-recorder region:", data);
      }
    }
  }

  // Recorder process
  Process {
    id: recorderProcess
    property bool usePortal: false
    property bool useStreaming: false

    onStarted: {
      pluginApi.pluginSettings.isRecording = true;

      // Delay start time for portal recording (gives time for region selection)
      if (usePortal) {
        pluginApi.pluginSettings.recordingStartTime = Date.now() + 2000;
      } else {
        pluginApi.pluginSettings.recordingStartTime = Date.now();
      }

      pluginApi.saveSettings();

      var message = useStreaming
        ? (pluginApi?.tr("notification.streamingStarted") || "Streaming started")
        : (pluginApi?.tr("notification.recordingStarted") || "Recording started");

      ToastService.showNotice(message);
      if (pluginApi && pluginApi.closePanel) {
        pluginApi.closePanel();
      }
    }

    onExited: function(exitCode, exitStatus) {
      var file = pluginApi.pluginSettings.recordingFile;
      pluginApi.pluginSettings.isRecording = false;
      pluginApi.pluginSettings.recordingFile = "";
      pluginApi.pluginSettings.lastRecordingFile = file;
      pluginApi.pluginSettings.recordingStartTime = 0;
      pluginApi.saveSettings();

      if (pluginApi && pluginApi.closePanel) {
        pluginApi.closePanel();
      }

      if (exitCode === 0 || exitCode === 255) {
        if (useStreaming) {
          ToastService.showNotice(pluginApi?.tr("notification.streamingStopped") || "Streaming stopped");
        } else if (file) {
          showNotificationWithButtons(file);
        } else {
          ToastService.showNotice(pluginApi?.tr("notification.recordingSaved") || "Recording saved");
        }
      } else {
        var errMsg = pluginApi?.tr("notification.recordingFailed") || "Recording failed (exit code: {code})";
        ToastService.showNotice(errMsg.replace("{code}", exitCode));
      }
    }

    stderr: SplitParser {
      onRead: function(data) {
        console.log("wl-screenrec:", data);
      }
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

  function showNotificationWithButtons(file) {
    var title = pluginApi?.tr("notification.recordingSaved") || "Recording saved";
    var body = file;
    var openFolderText = pluginApi?.tr("notification.openFolder") || "Open folder";

    notificationProcess.command = [
      "bash", "-c",
      "echo \"\" | notify-send -a wl-screenrec -i video -t 0 -A \"openFolder=" + openFolderText + "\" \"" + title + "\" \"" + body + "\""
    ];
    notificationProcess.running = true;
  }

  // ── Region Selector Integration ───────────────────────────────────

  function showRegionSelectorForRecording() {
    if (waitingForRegion) return;
    waitingForRegion = true;

    if (pluginApi) {
      pluginApi.withCurrentScreen(screen => {
        regionSelector.show(screen);
      });
    } else {
      regionSelector.show(null);
    }
  }

  function startRecordingWithRegion(x, y, w, h, screen) {
    waitingForRegion = false;

    // Convert screen-local coordinates to global geometry for gpu-screen-recorder
    // gpu-screen-recorder uses format: -region WxH+X+Y
    var scale = screen?.devicePixelRatio ?? 1.0;
    var screenX = screen?.x ?? 0;
    var screenY = screen?.y ?? 0;

    var globalX = Math.round(screenX + x / scale);
    var globalY = Math.round(screenY + y / scale);
    var globalW = Math.round(w / scale);
    var globalH = Math.round(h / scale);

    selectedRegionGeometry = globalW + "x" + globalH + "+" + globalX + "+" + globalY;
    regionScreen = screen;

    // Create directory and start recording with selected region
    createDirAndRecord(false);
  }

  function cancelRegionSelection() {
    waitingForRegion = false;
    selectedRegionGeometry = "";
    regionScreen = null;
    ToastService.showNotice(pluginApi?.tr("notification.regionSelectionCancelled") || "Region selection cancelled");
  }

  // ── Region Selector Component ─────────────────────────────────────

  RegionSelector {
    id: regionSelector

    onRegionSelected: function(x, y, w, h, screen) {
      console.log("Region selected:", x, y, w, h, "screen:", screen?.name);
      startRecordingWithRegion(x, y, w, h, screen);
    }

    onCancelled: {
      console.log("Region selection cancelled");
      cancelRegionSelection();
    }
  }
}
