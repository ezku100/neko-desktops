import QtQuick
import QtQuick.Controls as QtControls
import QtQuick.Layouts as QtLayouts
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQControls
import org.kde.kcmutils as KCM
import org.kde.taskmanager
import org.kde.plasma.workspace.dbus as DBus

KCM.SimpleKCM {
    id: pageAll

    property alias cfg_numFormat: numFormat.currentIndex

    property alias cfg_enableScroll: enableScroll.checked
    property alias cfg_scrollCyclic: scrollCyclic.checked
    property alias cfg_useSystemColors: useSystemColors.checked

    property alias cfg_numFontSize: numFontSize.value
    property alias cfg_numFontBold: numFontBold.checked
    property alias cfg_numGap: numGap.value
    property alias cfg_numMargin: numMargin.value
    property string cfg_numActiveColor: "#000000"
    property string cfg_numInactiveColor: "#FFFFFF"

    readonly property int st: 1

    VirtualDesktopInfo { id: deskInfo }

    function renameDesktop(idx, newName) {
        if (!newName.trim()) return
        var id = deskInfo.desktopIds[idx]
        if (!id) return
        DBus.SessionBus.asyncCall({
            service: "org.kde.KWin",
            path: "/VirtualDesktopManager",
            iface: "org.kde.KWin.VirtualDesktopManager",
            member: "setDesktopName",
            arguments: [new DBus.string(id), new DBus.string(newName.trim())]
        })
    }

    Kirigami.FormLayout {
        // ═══════════════════════════════════════
        //  GENERAL
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("General")
        }

        QtControls.CheckBox {
            id: enableScroll
            Kirigami.FormData.label: i18n("Scroll:")
            text: i18n("Change desktops on scroll")
        }

        QtControls.CheckBox {
            id: scrollCyclic
            Kirigami.FormData.label: i18n("Cyclic:")
            text: i18n("Wrap around on scroll")
            enabled: enableScroll.checked
        }

        QtControls.CheckBox {
            id: useSystemColors
            Kirigami.FormData.label: i18n("Colors:")
            text: i18n("Use system colors")
        }

        // ═══════════════════════════════════════
        //  NUMBERS
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Numbers")
        }

        QtControls.ComboBox {
            id: numFormat
            Kirigami.FormData.label: i18n("Number format:")
            model: [
                i18n("Arabic — 1, 2, 3"),
                i18n("Roman — I, II, III"),
                i18n("Japanese — いち, に, さん"),
                i18n("Kanji — 一, 二, 三"),
                i18n("Fullwidth — １, ２, ３"),
                i18n("Dice — ⚀, ⚁, ⚂")
            ]
        }

        QtControls.SpinBox {
            id: numFontSize; from: 0; to: 40
            Kirigami.FormData.label: i18n("Font size:")
        }
        QtControls.CheckBox {
            id: numFontBold
            Kirigami.FormData.label: i18n("Bold:")
            text: i18n("Focused desktop only")
        }
        QtControls.SpinBox {
            id: numGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: numMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Active text color:")
            KQControls.ColorButton {
                id: numActiveColor
                color: cfg_numActiveColor
                onColorChanged: cfg_numActiveColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Inactive text color:")
            KQControls.ColorButton {
                id: numInactiveColor
                color: cfg_numInactiveColor
                onColorChanged: cfg_numInactiveColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  RESET
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Reset")
        }

        QtLayouts.RowLayout {
            QtLayouts.Layout.fillWidth: true

            QtControls.Button {
                text: i18n("Restore Defaults")
                icon.name: "edit-undo"
                onClicked: {
                    numFormat.currentIndex = 0
                    enableScroll.checked = true
                    scrollCyclic.checked = false
                    useSystemColors.checked = true
                    numFontSize.value = 0
                    numFontBold.checked = false
                    numGap.value = 2
                    numMargin.value = 2
                    numActiveColor.color = "#000000"
                    numInactiveColor.color = "#FFFFFF"
                }
            }
            Item { QtLayouts.Layout.fillWidth: true }
        }
    }
}
