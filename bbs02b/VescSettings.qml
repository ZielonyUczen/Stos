import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Vedder.vesc.commands 1.0
import Vedder.vesc.configparams 1.0
import Vedder.vesc.utility 1.0

Item {
    id: root

    property ConfigParams mcConf: VescIf.mcConfig()
    property Commands commands: VescIf.commands()
    property int pendingReads: 0
    property bool hasRead: false
    property string statusText: "Read settings from the connected controller before editing."

    readonly property var motorParameters: [
        { name: "l_current_max", label: "Motor current limit" },
        { name: "l_current_min", label: "Motor braking current limit" },
        { name: "l_in_current_max", label: "Battery current limit" },
        { name: "l_in_current_min", label: "Battery braking current limit" },
        { name: "l_battery_cut_start", label: "Battery cutoff start" },
        { name: "l_battery_cut_end", label: "Battery cutoff end" },
        { name: "l_temp_fet_start", label: "MOSFET temperature start" },
        { name: "l_temp_fet_end", label: "MOSFET temperature end" }
    ]

    ListModel {
        id: settingsModel
    }

    function readSettings() {
        hasRead = false
        pendingReads = 1
        statusText = "Reading motor settings..."
        commands.getMcconf()
    }

    function onConfigUpdated() {
        if (pendingReads > 0) {
            pendingReads -= 1
            refreshSettings()
        }
    }

    function appendParameters(config, kind, parameters) {
        for (var i = 0; i < parameters.length; ++i) {
            var parameter = parameters[i]
            if (!config.hasParam(parameter.name)) {
                continue
            }

            var isDouble = config.isParamDouble(parameter.name)
            var isInt = config.isParamInt(parameter.name)
            if (!isDouble && !isInt) {
                continue
            }

            var value = isDouble ? config.getParamDouble(parameter.name)
                                 : config.getParamInt(parameter.name)
            var minimum = isDouble ? config.getParamMinDouble(parameter.name)
                                   : config.getParamMinInt(parameter.name)
            var maximum = isDouble ? config.getParamMaxDouble(parameter.name)
                                   : config.getParamMaxInt(parameter.name)

            settingsModel.append({
                "kind": kind,
                "name": parameter.name,
                "label": parameter.label,
                "value": value,
                "draft": String(value),
                "minimum": minimum,
                "maximum": maximum,
                "isInt": isInt
            })
        }
    }

    function refreshSettings() {
        settingsModel.clear()
        appendParameters(mcConf, "motor", motorParameters)
        hasRead = true
        statusText = settingsModel.count > 0
                ? "Values are staged locally until you confirm WRITE."
                : "No supported motor parameters were found in this firmware configuration."
    }

    function stageValue(index, text) {
        var value = Number(text)
        if (!isFinite(value)) {
            statusText = "Enter a valid number."
            return
        }

        settingsModel.setProperty(index, "draft", String(value))
        statusText = "Values are staged locally until you confirm WRITE."
    }

    function hasChanges() {
        for (var i = 0; i < settingsModel.count; ++i) {
            var item = settingsModel.get(i)
            if (Number(item.draft) !== Number(item.value)) {
                return true
            }
        }
        return false
    }

    function writeSettings() {
        for (var i = 0; i < settingsModel.count; ++i) {
            var item = settingsModel.get(i)
            var value = Number(item.draft)
            if (!isFinite(value) || value < item.minimum || value > item.maximum
                    || (item.isInt && Math.floor(value) !== value)) {
                statusText = "Write cancelled: a value is outside its firmware-defined range."
                return
            }
        }

        for (var j = 0; j < settingsModel.count; ++j) {
            var setting = settingsModel.get(j)
            var nextValue = Number(setting.draft)
            if (setting.isInt) {
                mcConf.updateParamInt(setting.name, nextValue, root)
            } else {
                mcConf.updateParamDouble(setting.name, nextValue, root)
            }
        }

        commands.setMcconf()
        hasRead = false
        statusText = "WRITE sent for the motor configuration. Read again to confirm stored values."
    }

    Connections {
        target: root.mcConf
        function onUpdated() { root.onConfigUpdated() }
    }

    Dialog {
        id: writeConfirmation
        title: "Confirm controller changes"
        modal: true
        standardButtons: Dialog.Yes | Dialog.Cancel
        anchors.centerIn: parent

        Label {
            width: 360
            wrapMode: Text.WordWrap
            text: "Write the staged motor limits to the controller? VESC Tool writes the complete motor configuration, not only these fields. These values affect motor and battery current limits; read immediately before writing and ensure the full configuration is correct."
        }

        onAccepted: root.writeSettings()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 10

        Label {
            Layout.fillWidth: true
            text: "BBS02B / MKS 75200 V2 — VESC motor settings"
            font.bold: true
            font.pixelSize: 20
        }

        RowLayout {
            Layout.fillWidth: true

            Button {
                text: "READ"
                onClicked: root.readSettings()
            }

            Button {
                text: "WRITE"
                enabled: root.hasRead && root.hasChanges()
                onClicked: writeConfirmation.open()
            }

            Label {
                Layout.fillWidth: true
                text: root.statusText
                wrapMode: Text.WordWrap
            }
        }

        Label {
            Layout.fillWidth: true
            text: "The BBS02B preset is withheld until approved target values are documented. No hardware or sensor mapping is assumed."
            wrapMode: Text.WordWrap
            color: "#9a5b00"
        }

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width

                Repeater {
                    model: settingsModel

                    delegate: RowLayout {
                        required property int index
                        required property string label
                        required property string draft
                        required property real minimum
                        required property real maximum

                        Layout.fillWidth: true
                        spacing: 12

                        Label {
                            Layout.fillWidth: true
                            text: label
                        }

                        TextField {
                            Layout.preferredWidth: 150
                            text: draft
                            selectByMouse: true
                            validator: DoubleValidator {
                                bottom: minimum
                                top: maximum
                            }
                            onEditingFinished: root.stageValue(index, text)
                        }
                    }
                }
            }
        }
    }
}
