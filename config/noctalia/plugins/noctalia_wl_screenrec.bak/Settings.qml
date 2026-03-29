import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root

  property var pluginApi: null

  property var cfg: pluginApi?.pluginSettings || ({})
  property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})

  property string valueSaveDirectory: cfg.saveDirectory ?? defaults.saveDirectory ?? "~/Videos"
  property string valueFilePattern: cfg.filePattern ?? defaults.filePattern ?? "recording_{datetime}"
  property string valueVideoFormat: cfg.videoFormat ?? defaults.videoFormat ?? "mp4"
  property string valueCodec: cfg.codec ?? defaults.codec ?? "auto"
  property string valueBitrate: cfg.bitrate ?? defaults.bitrate ?? "5M"

  spacing: Style.marginL

  ColumnLayout {
    spacing: Style.marginM
    Layout.fillWidth: true

    NTextInput {
      Layout.fillWidth: true
      label: "Save Directory"
      placeholderText: "~/Videos"
      text: root.valueSaveDirectory
      onTextChanged: root.valueSaveDirectory = text
    }

    NTextInput {
      Layout.fillWidth: true
      label: "File Name Pattern"
      description: "Use {datetime} for timestamp"
      placeholderText: "recording_{datetime}"
      text: root.valueFilePattern
      onTextChanged: root.valueFilePattern = text
    }

    NComboBox {
      Layout.fillWidth: true
      label: "Default Format"
      model: [
        {"key": "mp4", "name": "MP4"},
        {"key": "mkv", "name": "MKV"},
        {"key": "webm", "name": "WebM"}
      ]
      currentKey: root.valueVideoFormat
      onSelected: function(key) { root.valueVideoFormat = key; }
    }

    NComboBox {
      Layout.fillWidth: true
      label: "Default Codec"
      model: [
        {"key": "auto", "name": "Auto"},
        {"key": "avc", "name": "H.264 (AVC)"},
        {"key": "hevc", "name": "H.265 (HEVC)"},
        {"key": "vp8", "name": "VP8"},
        {"key": "vp9", "name": "VP9"}
      ]
      currentKey: root.valueCodec
      onSelected: function(key) { root.valueCodec = key; }
    }

    NTextInput {
      Layout.fillWidth: true
      label: "Default Bitrate"
      description: "e.g. 5M, 10M, 2500K"
      placeholderText: "5M"
      text: root.valueBitrate
      onTextChanged: root.valueBitrate = text
    }
  }

  function saveSettings() {
    if (!pluginApi) return;

    pluginApi.pluginSettings.saveDirectory = root.valueSaveDirectory;
    pluginApi.pluginSettings.filePattern = root.valueFilePattern;
    pluginApi.pluginSettings.videoFormat = root.valueVideoFormat;
    pluginApi.pluginSettings.codec = root.valueCodec;
    pluginApi.pluginSettings.bitrate = root.valueBitrate;
    pluginApi.saveSettings();
  }
}
