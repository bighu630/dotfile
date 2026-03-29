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
          text: "Recording"
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
          visible: cfg.recordAudio ?? false
          icon: "microphone"
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
        text: isRecording ? "Stop Recording" : "Start Recording"
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

      // Region selection button
      NButton {
        Layout.fillWidth: true
        text: "Select Region"
        icon: "crop"
        enabled: !isRecording

        onClicked: {
          if (pluginApi && pluginApi.closePanel) {
            pluginApi.closePanel();
          }
          pluginApi.ipcHandlers.startRegionRecording();
        }
      }

      // Audio toggle
      RowLayout {
        Layout.fillWidth: true
        spacing: Style.marginM

        NText {
          text: "Record Audio"
          pointSize: Style.fontSizeM
          color: Color.mOnSurface
          Layout.fillWidth: true
        }

        NToggle {
          checked: cfg.recordAudio ?? false
          enabled: !isRecording

          onToggled: {
            pluginApi.pluginSettings.recordAudio = checked;
            pluginApi.saveSettings();
          }
        }
      }

      // Monitor selection
      NComboBox {
        Layout.fillWidth: true
        label: "Monitor"
        enabled: !isRecording
        model: {
          var items = [{"key": "", "name": "(Default)"}];
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
        label: "Codec"
        enabled: !isRecording
        model: [
          {"key": "auto", "name": "Auto"},
          {"key": "avc", "name": "H.264"},
          {"key": "hevc", "name": "H.265"},
          {"key": "vp8", "name": "VP8"},
          {"key": "vp9", "name": "VP9"}
        ]
        currentKey: cfg.codec ?? "auto"

        onSelected: function(key) {
          pluginApi.pluginSettings.codec = key;
          pluginApi.saveSettings();
        }
      }

      // Bitrate input
      NTextInput {
        Layout.fillWidth: true
        label: "Bitrate"
        enabled: !isRecording
        placeholderText: "5M"
        text: cfg.bitrate ?? "5M"

        onEditingFinished: {
          pluginApi.pluginSettings.bitrate = text;
          pluginApi.saveSettings();
        }
      }

      // Settings button
      NButton {
        Layout.fillWidth: true
        text: "Settings"
        icon: "settings"
        outlined: true

        onClicked: {
          var scr = pluginApi?.panelOpenScreen;
          if (scr && pluginApi?.manifest) {
            BarService.openPluginSettings(scr, pluginApi.manifest);
          }
        }
      }
    }
  }
}
