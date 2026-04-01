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
    readonly property bool hasAudio: cfg.audioSource && cfg.audioSource !== "none"
    readonly property real capsuleHeight: Style.getCapsuleHeightForScreen(screen?.name)
    readonly property color contentColor: mouseArea.containsMouse ? Color.mOnHover : Color.mOnSurface

    readonly property real contentWidth: Math.max(capsuleHeight, horizontalRow.implicitWidth + Style.marginM * 2)

    implicitWidth: contentWidth
    implicitHeight: capsuleHeight

    Rectangle {
        id: visualCapsule
        x: Style.pixelAlignCenter(parent.width, width)
        y: Style.pixelAlignCenter(parent.height, height)
        width: root.contentWidth
        height: root.capsuleHeight
        radius: Style.radiusL
        color: root.isRecording ? Color.mError : (mouseArea.containsMouse ? Color.mHover : Style.capsuleColor)
        border.color: Style.capsuleBorderColor
        border.width: Style.capsuleBorderWidth

        Behavior on color { ColorAnimation { duration: 200 } }
        Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

        RowLayout {
            id: horizontalRow
            anchors.centerIn: parent
            spacing: Style.marginS

            Rectangle {
                visible: root.isRecording
                width: 6; height: 6; radius: 3
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignVCenter
                SequentialAnimation on opacity {
                    running: root.isRecording; loops: Animation.Infinite
                    NumberAnimation { from: 1.0; to: 0.3; duration: 800 }
                    NumberAnimation { from: 0.3; to: 1.0; duration: 800 }
                }
            }

            Rectangle {
                visible: root.isRecording
                width: root.capsuleHeight * 0.35
                height: root.capsuleHeight * 0.35
                radius: root.capsuleHeight * 0.08
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignVCenter
            }

            NIcon {
                visible: !root.isRecording
                icon: "circle"
                pointSize: root.capsuleHeight * 0.4
                color: root.contentColor
                Layout.alignment: Qt.AlignVCenter
            }

            NText {
                visible: root.isRecording
                text: root.formatElapsed()
                pointSize: Style.getBarFontSizeForScreen(screen?.name)
                color: "#FFFFFF"
                font.weight: Font.Bold
                Layout.alignment: Qt.AlignVCenter
            }

            NIcon {
                visible: root.isRecording && root.hasAudio
                icon: "microphone"
                pointSize: root.capsuleHeight * 0.3
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                if (pluginApi) pluginApi.openPanel(root.screen, root)
            } else if (mouse.button === Qt.RightButton) {
                PanelService.showContextMenu(contextMenu, root, screen)
            }
        }
        onEntered: TooltipService.show(root, root.isRecording ? pluginApi?.tr("widget.tooltipRecording") : pluginApi?.tr("widget.tooltip"), BarService.getTooltipDirection(screen?.name))
        onExited: TooltipService.hide()
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
        return h > 0 ? h + ":" + m.toString().padStart(2, '0') + ":" + s.toString().padStart(2, '0')
                     : m + ":" + s.toString().padStart(2, '0')
    }

    NPopupContextMenu {
        id: contextMenu
        model: [{ "label": pluginApi?.tr("panel.settings") || "Settings", "action": "settings", "icon": "settings" }]
        onTriggered: action => {
            contextMenu.close()
            PanelService.closeContextMenu(screen)
            if (action === "settings") BarService.openPluginSettings(screen, pluginApi.manifest)
        }
    }
}
