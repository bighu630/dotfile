import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets

Item {
  id: root

  property var pluginApi: null

  readonly property var geometryPlaceholder: panelContainer
  property real contentPreferredWidth: 360 * Style.uiScaleRatio
  property real contentPreferredHeight: contentColumn.implicitHeight + Style.marginL * 2
  readonly property bool allowAttach: true

  property var cfg: pluginApi?.pluginSettings || ({})
  readonly property bool isRecording: cfg.isRecording ?? false

  anchors.fill: parent

  Rectangle {
    id: panelContainer
    anchors.fill: parent
    color: "transparent"

    ColumnLayout {
      id: contentColumn
      anchors {
        fill: parent
        margins: Style.marginL
      }
      spacing: Style.marginM

      // Recording status indicator
      RowLayout {
        Layout.fillWidth: true
        visible: isRecording
        spacing: Style.marginS

        Rectangle {
          width: 8
          height: 8
          radius: 4
          color: Color.mError

          SequentialAnimation on opacity {
            running: isRecording
            loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.3; duration: 800 }
            NumberAnimation { from: 0.3; to: 1.0; duration: 800 }
          }
        }

        NText {
          text: pluginApi?.tr("panel.recording") || "Recording"
          pointSize: Style.fontSizeM
          font.weight: Font.Bold
          color: Color.mError
        }

        NText {
          id: elapsedTime
          text: "00:00"
          pointSize: Style.fontSizeM
          color: Color.mError
        }

        NIcon {
          visible: cfg.audioSource && cfg.audioSource !== "none"
          icon: (cfg.audioSource === "mic" || cfg.audioSource === "both") ? "microphone" : "speaker"
          pointSize: Style.fontSizeS
          color: Color.mError
        }

        Timer {
          running: isRecording
          interval: 1000
          repeat: true
          triggeredOnStart: true

          onTriggered: {
            var startTime = cfg.recordingStartTime || 0;
            if (startTime === 0) return;
            var elapsed = Math.floor((Date.now() - startTime) / 1000);
            var h = Math.floor(elapsed / 3600);
            var m = Math.floor((elapsed % 3600) / 60);
            var s = elapsed % 60;
            if (h > 0) {
              elapsedTime.text = h.toString().padStart(2, '0') + ":"
                + m.toString().padStart(2, '0') + ":"
                + s.toString().padStart(2, '0');
            } else {
              elapsedTime.text = m.toString().padStart(2, '0') + ":"
                + s.toString().padStart(2, '0');
            }
          }
        }
      }

      // Main action button
      NButton {
        Layout.fillWidth: true
        text: isRecording ? (pluginApi?.tr("panel.stopRecording") || "Stop Recording") : (pluginApi?.tr("panel.startRecording") || "Start Recording")
        icon: isRecording ? "stop-circle" : "circle"
        backgroundColor: isRecording ? Color.mError : Color.mPrimary
        textColor: isRecording ? Color.mOnError : Color.mOnPrimary

        onClicked: {
          if (isRecording) {
            pluginApi.ipcHandlers.stopRecording();
          } else {
            pluginApi.ipcHandlers.startRecording();
          }
        }
      }

      // Audio source selection
      NComboBox {
        Layout.fillWidth: true
        label: pluginApi?.tr("panel.audio") || "Audio"
        enabled: !isRecording
        model: [
          {"key": "none", "name": pluginApi?.tr("panel.audioNone") || "None"},
          {"key": "mic", "name": pluginApi?.tr("panel.audioMic") || "Microphone"},
          {"key": "desktop", "name": pluginApi?.tr("panel.audioDesktop") || "Desktop Audio"},
          {"key": "both", "name": pluginApi?.tr("panel.audioBoth") || "Both"}
        ]
        currentKey: cfg.audioSource ?? "none"

        onSelected: function(key) {
          pluginApi.pluginSettings.audioSource = key;
          pluginApi.saveSettings();
        }
      }

      // Monitor/Region selection
      NComboBox {
        Layout.fillWidth: true
        label: pluginApi?.tr("panel.recordingTarget") || "Recording Target"
        enabled: !isRecording
        model: {
          var items = [
            {"key": "", "name": pluginApi?.tr("panel.targetRegion") || "Region (Portal)"},
            {"key": "screen", "name": pluginApi?.tr("panel.targetFullScreen") || "Full Screen"}
          ];
          for (var i = 0; i < Quickshell.screens.length; i++) {
            var s = Quickshell.screens[i];
            items.push({"key": s.name, "name": s.name});
          }
          return items;
        }
        currentKey: cfg.selectedMonitor ?? ""

        onSelected: function(key) {
          pluginApi.pluginSettings.selectedMonitor = key;
          pluginApi.saveSettings();
        }
      }

      // Codec selection
      NComboBox {
        Layout.fillWidth: true
        label: pluginApi?.tr("panel.codec") || "Codec"
        enabled: !isRecording
        model: [
          {"key": "auto", "name": pluginApi?.tr("panel.codecAuto") || "Auto"},
          {"key": "h264", "name": "H.264"},
          {"key": "hevc", "name": "H.265/HEVC"},
          {"key": "av1", "name": "AV1"},
          {"key": "vp9", "name": "VP9"}
        ]
        currentKey: cfg.codec ?? "auto"

        onSelected: function(key) {
          pluginApi.pluginSettings.codec = key;
          pluginApi.saveSettings();
        }
      }

      // Quality preset
      NComboBox {
        Layout.fillWidth: true
        label: pluginApi?.tr("panel.quality") || "Quality"
        enabled: !isRecording
        model: [
          {"key": "medium", "name": "Medium"},
          {"key": "high", "name": "High"},
          {"key": "very_high", "name": "Very High"},
          {"key": "ultra", "name": "Ultra"}
        ]
        currentKey: cfg.quality ?? "high"

        onSelected: function(key) {
          pluginApi.pluginSettings.quality = key;
          pluginApi.saveSettings();
        }
      }

      // Framerate selection
      NComboBox {
        Layout.fillWidth: true
        label: pluginApi?.tr("panel.framerate") || "Framerate"
        enabled: !isRecording
        model: [
          {"key": "30", "name": "30"},
          {"key": "60", "name": "60"},
          {"key": "120", "name": "120"},
          {"key": "144", "name": "144"}
        ]
        currentKey: cfg.framerate ?? "60"

        onSelected: function(key) {
          pluginApi.pluginSettings.framerate = key;
          pluginApi.saveSettings();
        }
      }

      // Stream destination selection
      NComboBox {
        Layout.fillWidth: true
        label: pluginApi?.tr("panel.streamDestination") || "Stream To"
        enabled: !isRecording
        model: {
          var items = [
            {"key": "", "name": pluginApi?.tr("panel.noStream") || "No streaming (record to file)"}
          ];
          var destinations = cfg.streamDestinations || {};
          for (var destName in destinations) {
            items.push({"key": destName, "name": destName});
          }
          return items;
        }
        currentKey: cfg.streamDestination ?? ""

        onSelected: function(key) {
          pluginApi.pluginSettings.streamDestination = key;
          pluginApi.saveSettings();
        }
      }

      // Settings button
      NButton {
        Layout.fillWidth: true
        text: pluginApi?.tr("panel.settings") || "Settings"
        icon: "settings"
        outlined: true

        onClicked: {
          var scr = pluginApi?.panelOpenScreen;
          if (scr && pluginApi?.manifest) {
            BarService.openPluginSettings(scr, pluginApi.manifest);
            // Close panel after opening settings
            if (pluginApi && pluginApi.closePanel) {
              pluginApi.closePanel();
            }
          }
        }
      }
    }
  }
}
