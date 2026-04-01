import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Widgets
import qs.Services.UI

Item {
    id: root

    property var pluginApi: null
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    property var cfg: pluginApi?.pluginSettings || ({})
    property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})

    // ── Resolved settings ──────────────────────────────────────────────────
    readonly property string filePath:        cfg.filePath        ?? defaults.filePath        ?? ""
    readonly property int    refreshInterval: Math.max(100, parseInt(cfg.refreshInterval ?? defaults.refreshInterval ?? 1000))
    readonly property string textColorKey:    cfg.textColor       ?? defaults.textColor       ?? "none"
    readonly property color  textColor:       Color.resolveColorKey(textColorKey)
    readonly property string fontFamily:      cfg.fontFamily      ?? defaults.fontFamily      ?? ""
    readonly property int    maxWidth:        parseInt(cfg.maxWidth ?? defaults.maxWidth ?? 200)

    // ── Screen / style helpers ─────────────────────────────────────────────
    readonly property string screenName:    screen ? screen.name : ""
    readonly property real   barFontSize:   Style.getBarFontSizeForScreen(screenName)
    readonly property real   capsuleHeight: Style.getCapsuleHeightForScreen(screenName)

    // ── Displayed text (updated on every successful file load) ─────────────
    property string displayText: ""

    // ── Scroll logic ───────────────────────────────────────────────────────
    // Measure pixel width of full text to determine if scrolling is needed
    TextMetrics {
        id: fullTextMetrics
        font.pointSize: root.barFontSize
        font.family:    root.fontFamily !== "" ? root.fontFamily : font.family
        text: root.displayText
    }

    readonly property bool shouldScroll: maxWidth > 0 && fullTextMetrics.advanceWidth > maxWidth

    readonly property real contentContainerWidth: root.shouldScroll
        ? maxWidth
        : textDisplay.implicitWidth

    // ── Widget geometry ────────────────────────────────────────────────────
    implicitWidth:  Math.max(contentContainerWidth + Style.marginM * 2, capsuleHeight)
    implicitHeight: capsuleHeight

    // ── File reader ────────────────────────────────────────────────────────
    FileView {
        id: fileView
        path:         root.filePath !== "" ? root.filePath : ""
        watchChanges: false
        preload:      root.filePath !== ""

        onLoaded: {
            root.displayText = (fileView.text() ?? "").trim()
        }
        onLoadFailed: (error) => {
            Logger.w("TextSync", "Load failed [" + root.filePath + "]: " + error)
            root.displayText = ""
        }
    }

    // ── Periodic refresh timer ─────────────────────────────────────────────
    Timer {
        id: refreshTimer
        interval: root.refreshInterval
        running:  root.filePath !== ""
        repeat:   true
        onTriggered: {
            if (root.filePath !== "")
                fileView.reload()
        }
    }

    // Force an immediate reload when the file path changes in settings
    onFilePathChanged: {
        if (filePath !== "")
            fileView.reload()
        else
            root.displayText = ""
    }

    // Reset and restart scroll animation when text changes
    onDisplayTextChanged: {
        textDisplay.x = 0
        if (root.shouldScroll)
            scrollAnimation.restart()
        else
            scrollAnimation.stop()
    }

    // ── Visual capsule ─────────────────────────────────────────────────────
    Rectangle {
        id: capsule
        x:      Style.pixelAlignCenter(parent.width,  width)
        y:      Style.pixelAlignCenter(parent.height, height)
        width:  root.implicitWidth
        height: root.capsuleHeight
        color:  mouseArea.containsMouse ? Color.mHover : Style.capsuleColor
        radius: Style.radiusL
        border.color: Style.capsuleBorderColor
        border.width: Style.capsuleBorderWidth
        clip: true

        Item {
            id: scrollContainer
            anchors.centerIn: parent
            width:  root.contentContainerWidth
            height: parent.height

            NText {
                id: textDisplay
                anchors.verticalCenter: parent.verticalCenter
                x: 0

                color:       root.textColor
                pointSize:   root.barFontSize
                font.family: root.fontFamily !== "" ? root.fontFamily : font.family
                text: {
                    if (root.filePath === "") return pluginApi?.tr("widget.noFile") ?? ""
                    if (root.displayText === "") return "…"
                    return root.displayText
                }

                SequentialAnimation {
                    id: scrollAnimation
                    running: root.shouldScroll && root.displayText !== ""

                    PauseAnimation { duration: 1500 }
                    NumberAnimation {
                        target:   textDisplay
                        property: "x"
                        from: 0
                        to:   -(textDisplay.implicitWidth - root.contentContainerWidth)
                        duration: Math.max(0, textDisplay.implicitWidth - root.contentContainerWidth) * 15
                        easing.type: Easing.Linear
                    }
                }
            }
        }
    }

    // ── Right-click context menu ───────────────────────────────────────────
    NPopupContextMenu {
        id: contextMenu
        model: [
            {
                "label": pluginApi?.tr("menu.settings") ?? "",
                "action": "settings",
                "icon":   "settings"
            }
        ]
        onTriggered: (action) => {
            contextMenu.close()
            PanelService.closeContextMenu(screen)
            if (action === "settings")
                BarService.openPluginSettings(root.screen, pluginApi.manifest)
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill:  parent
        hoverEnabled:  true
        cursorShape:   Qt.PointingHandCursor
        acceptedButtons: Qt.RightButton

        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton)
                PanelService.showContextMenu(contextMenu, root, screen)
        }
    }
}
