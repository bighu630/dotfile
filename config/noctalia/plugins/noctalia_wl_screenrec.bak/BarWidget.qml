import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets

Item {
  id: root

  property var pluginApi: null
  property ShellScreen screen
  property string widgetId: ""
  property string section: ""

  property var cfg: pluginApi?.pluginSettings || ({})
  readonly property bool isRecording: cfg.isRecording ?? false
  readonly property bool recordAudio: cfg.recordAudio ?? false

  readonly property real ch: Style.getCapsuleHeightForScreen(screen?.name)

  implicitWidth: Math.max(ch, row.width + ch * 0.3)
  implicitHeight: ch

  Rectangle {
    anchors.fill: parent
    radius: height / 2
    color: root.isRecording ? Color.mError : Style.capsuleColor
    border.color: Style.capsuleBorderColor
    border.width: Style.capsuleBorderWidth

    RowLayout {
      id: row
      anchors.centerIn: parent
      spacing: 4

      Rectangle {
        visible: root.isRecording
        width: 6; height: 6; radius: 3
        color: "#fff"
        Layout.alignment: Qt.AlignVCenter
        SequentialAnimation on opacity {
          running: root.isRecording; loops: Animation.Infinite
          NumberAnimation { from: 1.0; to: 0.3; duration: 800 }
          NumberAnimation { from: 0.3; to: 1.0; duration: 800 }
        }
      }

      NIcon {
        icon: root.isRecording ? "stop" : "video"
        pointSize: root.ch * 0.4
        color: root.isRecording ? "#fff" : Color.mOnSurface
        Layout.alignment: Qt.AlignVCenter
      }

      NText {
        visible: root.isRecording
        text: root.formatElapsed()
        pointSize: Style.fontSizeXS
        color: "#fff"
        font.weight: Font.Bold
        Layout.alignment: Qt.AlignVCenter
      }

      NIcon {
        visible: root.isRecording && root.recordAudio
        icon: "microphone"
        pointSize: root.ch * 0.3
        color: "#fff"
        Layout.alignment: Qt.AlignVCenter
      }
    }

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      hoverEnabled: true
      onEntered: TooltipService.show(root, root.isRecording ? "Recording..." : "Screen Recorder", BarService.getTooltipDirection(screen?.name))
      onExited: TooltipService.hide()
      onClicked: function(mouse) {
        TooltipService.hide()
        if (mouse.button === Qt.LeftButton) {
          if (pluginApi) pluginApi.openPanel(root.screen, root)
        } else {
          PanelService.showContextMenu(contextMenu, root, screen)
        }
      }
    }
  }

  Timer {
    running: root.isRecording
    interval: 1000; repeat: true; triggeredOnStart: true
    onTriggered: root.elapsedChanged()
  }

  property int _elapsed: 0
  function elapsedChanged() {
    var t = cfg.recordingStartTime || 0
    _elapsed = t ? Math.floor((Date.now() - t) / 1000) : 0
  }
  function formatElapsed() {
    var h = Math.floor(_elapsed / 3600)
    var m = Math.floor((_elapsed % 3600) / 60)
    var s = _elapsed % 60
    return h > 0 ? h + ":" + m.toString().padStart(2,'0') + ":" + s.toString().padStart(2,'0')
                 : m + ":" + s.toString().padStart(2,'0')
  }

  NPopupContextMenu {
    id: contextMenu
    model: [{ "label": "Settings", "action": "settings", "icon": "settings" }]
    onTriggered: function(action) {
      contextMenu.close()
      PanelService.closeContextMenu(screen)
      if (action === "settings") BarService.openPluginSettings(root.screen, pluginApi.manifest)
    }
  }
}
