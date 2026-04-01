import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
    id: root

    property var pluginApi: null

    property var cfg:      pluginApi?.pluginSettings || ({})
    property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})

    // ── Local editable copies ──────────────────────────────────────────────
    property string valueFilePath:        cfg.filePath        ?? defaults.filePath        ?? ""
    property int    valueRefreshInterval: parseInt(cfg.refreshInterval ?? defaults.refreshInterval ?? 1000)
    property string valueTextColor:       cfg.textColor       ?? defaults.textColor       ?? "none"
    property string valueFontFamily:      cfg.fontFamily      ?? defaults.fontFamily      ?? ""
    property int    valueMaxWidth:        parseInt(cfg.maxWidth ?? defaults.maxWidth ?? 0)

    spacing: Style.marginL

    Component.onCompleted: {
        Logger.d("TextSync", "Settings UI loaded")
    }

    // ── File path ──────────────────────────────────────────────────────────
    ColumnLayout {
        spacing: Style.marginM
        Layout.fillWidth: true

        NTextInput {
            Layout.fillWidth: true
            label:           pluginApi?.tr("settings.filePath.label")       ?? ""
            description:     pluginApi?.tr("settings.filePath.desc")        ?? ""
            placeholderText: pluginApi?.tr("settings.filePath.placeholder") ?? ""
            text:            root.valueFilePath
            onTextChanged:   root.valueFilePath = text
        }
    }

    // ── Refresh interval ───────────────────────────────────────────────────
    ColumnLayout {
        spacing: Style.marginM
        Layout.fillWidth: true

        NTextInput {
            Layout.fillWidth: true
            label:           pluginApi?.tr("settings.refreshInterval.label")       ?? ""
            description:     pluginApi?.tr("settings.refreshInterval.desc")        ?? ""
            placeholderText: "1000"
            text:            root.valueRefreshInterval.toString()
            inputMethodHints: Qt.ImhDigitsOnly
            onTextChanged: {
                const n = parseInt(text)
                if (!isNaN(n) && n > 0)
                    root.valueRefreshInterval = Math.max(100, n)
            }
        }
    }

    // ── Text colour ────────────────────────────────────────────────────────
    ColumnLayout {
        spacing: Style.marginM
        Layout.fillWidth: true

        NComboBox {
            label:       pluginApi?.tr("settings.textColor.label") ?? ""
            description: pluginApi?.tr("settings.textColor.desc")  ?? ""
            model:       Color.colorKeyModel
            currentKey:  root.valueTextColor
            onSelected:  key => root.valueTextColor = key
        }
    }

    // ── Font family ────────────────────────────────────────────────────────
    ColumnLayout {
        spacing: Style.marginM
        Layout.fillWidth: true

        NTextInput {
            Layout.fillWidth: true
            label:           pluginApi?.tr("settings.fontFamily.label")       ?? ""
            description:     pluginApi?.tr("settings.fontFamily.desc")        ?? ""
            placeholderText: pluginApi?.tr("settings.fontFamily.placeholder") ?? ""
            text:            root.valueFontFamily
            onTextChanged:   root.valueFontFamily = text
        }
    }

    // ── Max width ──────────────────────────────────────────────────────────
    ColumnLayout {
        spacing: Style.marginM
        Layout.fillWidth: true

        NTextInput {
            Layout.fillWidth: true
            label:           pluginApi?.tr("settings.maxWidth.label")       ?? ""
            description:     pluginApi?.tr("settings.maxWidth.desc")        ?? ""
            placeholderText: "30"
            text:            root.valueMaxWidth.toString()
            inputMethodHints: Qt.ImhDigitsOnly
            onTextChanged: {
                const n = parseInt(text)
                root.valueMaxWidth = (!isNaN(n) && n >= 0) ? n : 0
            }
        }
    }

    // ── Save ───────────────────────────────────────────────────────────────
    function saveSettings() {
        if (!pluginApi) {
            Logger.e("TextSync", "Cannot save: pluginApi is null")
            return
        }

        pluginApi.pluginSettings.filePath        = root.valueFilePath
        pluginApi.pluginSettings.refreshInterval = root.valueRefreshInterval
        pluginApi.pluginSettings.textColor       = root.valueTextColor
        pluginApi.pluginSettings.fontFamily      = root.valueFontFamily
        pluginApi.pluginSettings.maxWidth        = root.valueMaxWidth
        pluginApi.saveSettings()

        Logger.d("TextSync", "Settings saved")
    }
}
