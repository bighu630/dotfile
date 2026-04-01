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
  property string valueQuality: cfg.quality ?? defaults.quality ?? "high"
  property string valueFramerate: cfg.framerate ?? defaults.framerate ?? "60"
  property var valueStreamDestinations: cfg.streamDestinations ?? {}

  spacing: Style.marginL

  function getStreamDestinationKeys() {
    return Object.keys(valueStreamDestinations || {});
  }

  function addStreamDestination(name, url) {
    if (!name || !url) return;
    var dest = valueStreamDestinations || {};
    dest[name] = url;
    valueStreamDestinations = dest;
    streamDestinationsList.modelChanged();
  }

  function removeStreamDestination(name) {
    var dest = valueStreamDestinations || {};
    delete dest[name];
    valueStreamDestinations = dest;
    streamDestinationsList.modelChanged();
  }

  ColumnLayout {
    spacing: Style.marginM
    Layout.fillWidth: true

    NTextInput {
      Layout.fillWidth: true
      label: pluginApi?.tr("settings.saveDirectory.label") || "Save Directory"
      placeholderText: pluginApi?.tr("settings.saveDirectory.placeholder") || "~/Videos"
      text: root.valueSaveDirectory
      onTextChanged: root.valueSaveDirectory = text
    }

    NTextInput {
      Layout.fillWidth: true
      label: pluginApi?.tr("settings.filePattern.label") || "File Name Pattern"
      description: pluginApi?.tr("settings.filePattern.description") || "Use {datetime} for timestamp"
      placeholderText: pluginApi?.tr("settings.filePattern.placeholder") || "recording_{datetime}"
      text: root.valueFilePattern
      onTextChanged: root.valueFilePattern = text
    }

    NComboBox {
      Layout.fillWidth: true
      label: pluginApi?.tr("settings.videoFormat.label") || "Default Format"
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
      label: pluginApi?.tr("settings.codec.label") || "Default Codec"
      model: [
        {"key": "auto", "name": "Auto"},
        {"key": "h264", "name": "H.264"},
        {"key": "hevc", "name": "H.265/HEVC"},
        {"key": "av1", "name": "AV1"},
        {"key": "vp9", "name": "VP9"}
      ]
      currentKey: root.valueCodec
      onSelected: function(key) { root.valueCodec = key; }
    }

    NComboBox {
      Layout.fillWidth: true
      label: pluginApi?.tr("panel.quality") || "Quality"
      model: [
        {"key": "medium", "name": "Medium"},
        {"key": "high", "name": "High"},
        {"key": "very_high", "name": "Very High"},
        {"key": "ultra", "name": "Ultra"}
      ]
      currentKey: root.valueQuality
      onSelected: function(key) { root.valueQuality = key; }
    }

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
      currentKey: root.valueFramerate
      onSelected: function(key) { root.valueFramerate = key; }
    }

    // Stream Destinations Section
    NText {
      Layout.fillWidth: true
      Layout.topMargin: Style.marginL
      text: pluginApi?.tr("settings.streamDestinations.label") || "Stream Destinations"
      pointSize: Style.fontSizeM
      font.weight: Font.Medium
      color: Color.mOnSurface
    }

    NText {
      Layout.fillWidth: true
      text: pluginApi?.tr("settings.streamDestinations.description") || "Configure RTMP/RTSP streaming destinations"
      pointSize: Style.fontSizeS
      color: Color.mOnSurfaceVariant
    }

    // Add new stream destination
    ColumnLayout {
      Layout.fillWidth: true
      spacing: Style.marginS

      NTextInput {
        id: newStreamName
        Layout.fillWidth: true
        placeholderText: pluginApi?.tr("settings.streamDestinations.namePlaceholder") || "Name (e.g., Twitch, YouTube)"
      }

      NTextInput {
        id: newStreamUrl
        Layout.fillWidth: true
        placeholderText: pluginApi?.tr("settings.streamDestinations.urlPlaceholder") || "Stream URL (e.g., rtmp://live.twitch.tv/app/...)"
      }

      NButton {
        Layout.fillWidth: true
        text: pluginApi?.tr("settings.streamDestinations.addButton") || "Add Destination"
        icon: "add"

        onClicked: {
          if (newStreamName.text && newStreamUrl.text) {
            root.addStreamDestination(newStreamName.text, newStreamUrl.text);
            newStreamName.text = "";
            newStreamUrl.text = "";
          }
        }
      }
    }

    // List of stream destinations
    Repeater {
      id: streamDestinationsList
      model: root.getStreamDestinationKeys()

      delegate: RowLayout {
        Layout.fillWidth: true
        spacing: Style.marginS

        NText {
          Layout.fillWidth: true
          text: modelData + ": " + root.valueStreamDestinations[modelData]
          pointSize: Style.fontSizeS
          color: Color.mOnSurface
          elide: Text.ElideMiddle
        }

        NButton {
          text: pluginApi?.tr("settings.streamDestinations.removeButton") || "Remove"
          icon: "delete"
          backgroundColor: Color.mError
          textColor: Color.mOnError

          onClicked: {
            root.removeStreamDestination(modelData);
          }
        }
      }
    }
  }

  function saveSettings() {
    if (!pluginApi) return;

    pluginApi.pluginSettings.saveDirectory = root.valueSaveDirectory;
    pluginApi.pluginSettings.filePattern = root.valueFilePattern;
    pluginApi.pluginSettings.videoFormat = root.valueVideoFormat;
    pluginApi.pluginSettings.codec = root.valueCodec;
    pluginApi.pluginSettings.quality = root.valueQuality;
    pluginApi.pluginSettings.framerate = root.valueFramerate;
    pluginApi.pluginSettings.streamDestinations = root.valueStreamDestinations;
    pluginApi.saveSettings();
  }
}
