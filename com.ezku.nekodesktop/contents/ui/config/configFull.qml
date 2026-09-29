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

    property alias cfg_indicatorStyle: indicatorStyle.currentIndex

    property alias cfg_enableScroll: enableScroll.checked
    property alias cfg_scrollCyclic: scrollCyclic.checked
    property alias cfg_useSystemColors: useSystemColors.checked

    property alias cfg_caeActiveSize: caeActiveSize.value
    property alias cfg_caeOccupiedSize: caeOccupiedSize.value
    property alias cfg_caeEmptySize: caeEmptySize.value
    property alias cfg_caeGap: caeGap.value
    property alias cfg_caeMargin: caeMargin.value
    property alias cfg_caeMouthAngle: caeMouthAngle.value
    property alias cfg_caeAnimate: caeAnimate.checked
    property alias cfg_caeShowGlyph: caeShowGlyph.checked
    property alias cfg_caeEmptyOpacity: caeEmptyOpacity.value
    property string cfg_caeActiveColor: "#FFFFFF"
    property string cfg_caeOccupiedColor: "#FFFFFF"
    property string cfg_caeEmptyColor: "#FFFFFF"

    property alias cfg_hyrActiveSize: hyrActiveSize.value
    property alias cfg_hyrOccupiedSize: hyrOccupiedSize.value
    property alias cfg_hyrEmptySize: hyrEmptySize.value
    property alias cfg_hyrGap: hyrGap.value
    property alias cfg_hyrMargin: hyrMargin.value
    property alias cfg_hyrGlow: hyrGlow.checked
    property alias cfg_hyrEmptyOpacity: hyrEmptyOpacity.value
    property string cfg_hyrBladeColor: "#E8E8E8"
    property string cfg_hyrGoldColor: "#E8B800"
    property string cfg_hyrGripColor: "#3B5BFD"
    property string cfg_hyrOccupiedColor: "#00E676"
    property string cfg_hyrEmptyColor: "#FFFFFF"

    property alias cfg_triActiveSize: triActiveSize.value
    property alias cfg_triOccupiedSize: triOccupiedSize.value
    property alias cfg_triEmptySize: triEmptySize.value
    property alias cfg_triGap: triGap.value
    property alias cfg_triMargin: triMargin.value
    property alias cfg_triGlow: triGlow.checked
    property alias cfg_triEmptyOpacity: triEmptyOpacity.value
    property string cfg_triActiveColor: "#FFFFFF"
    property string cfg_triOccupiedColor: "#FFFFFF"
    property string cfg_triEmptyColor: "#FFFFFF"

    property alias cfg_creActiveSize: creActiveSize.value
    property alias cfg_creOccupiedSize: creOccupiedSize.value
    property alias cfg_creEmptySize: creEmptySize.value
    property alias cfg_creGap: creGap.value
    property alias cfg_creMargin: creMargin.value
    property alias cfg_creEmptyOpacity: creEmptyOpacity.value
    property string cfg_creSkinColor: "#4CAF50"
    property string cfg_creFaceColor: "#141414"
    property string cfg_creTntColor: "#E53935"
    property string cfg_creBandColor: "#FFFFFF"
    property string cfg_creEmptyColor: "#FFFFFF"

    property alias cfg_heaActiveSize: heaActiveSize.value
    property alias cfg_heaOccupiedSize: heaOccupiedSize.value
    property alias cfg_heaEmptySize: heaEmptySize.value
    property alias cfg_heaGap: heaGap.value
    property alias cfg_heaMargin: heaMargin.value
    property alias cfg_heaBaseOpacity: heaBaseOpacity.value
    property alias cfg_heaEmptyOpacity: heaEmptyOpacity.value
    property string cfg_heaFullColor: "#FFFFFF"
    property string cfg_heaHalfColor: "#FFFFFF"
    property string cfg_heaEmptyColor: "#FFFFFF"

    property alias cfg_pokActiveSize: pokActiveSize.value
    property alias cfg_pokOccupiedSize: pokOccupiedSize.value
    property alias cfg_pokEmptySize: pokEmptySize.value
    property alias cfg_pokGap: pokGap.value
    property alias cfg_pokMargin: pokMargin.value
    property alias cfg_pokEmptyOpacity: pokEmptyOpacity.value
    property string cfg_pokBallColor: "#FFFFFF"
    property string cfg_pokBandColor: "#FFFFFF"
    property string cfg_pokEmptyColor: "#FFFFFF"

    property alias cfg_pikActiveSize: pikActiveSize.value
    property alias cfg_pikOccupiedSize: pikOccupiedSize.value
    property alias cfg_pikEmptySize: pikEmptySize.value
    property alias cfg_pikGap: pikGap.value
    property alias cfg_pikMargin: pikMargin.value
    property alias cfg_pikEmptyOpacity: pikEmptyOpacity.value
    property string cfg_pikFaceColor: "#FFFFFF"
    property string cfg_pikDetailColor: "#FFFFFF"
    property string cfg_pikEmptyColor: "#FFFFFF"

    property alias cfg_marActiveSize: marActiveSize.value
    property alias cfg_marOccupiedSize: marOccupiedSize.value
    property alias cfg_marEmptySize: marEmptySize.value
    property alias cfg_marGap: marGap.value
    property alias cfg_marMargin: marMargin.value
    property alias cfg_marEmptyOpacity: marEmptyOpacity.value
    property string cfg_marCapColor: "#FFFFFF"
    property string cfg_marSpotColor: "#FFFFFF"
    property string cfg_marCoinColor: "#FFFFFF"
    property string cfg_marEmptyColor: "#FFFFFF"

    property alias cfg_draActiveSize: draActiveSize.value
    property alias cfg_draOccupiedSize: draOccupiedSize.value
    property alias cfg_draEmptySize: draEmptySize.value
    property alias cfg_draGap: draGap.value
    property alias cfg_draMargin: draMargin.value
    property alias cfg_draEmptyOpacity: draEmptyOpacity.value
    property string cfg_draBallColor: "#FFFFFF"
    property string cfg_draStarColor: "#FFFFFF"
    property string cfg_draEmptyColor: "#FFFFFF"

    property alias cfg_kirActiveSize: kirActiveSize.value
    property alias cfg_kirOccupiedSize: kirOccupiedSize.value
    property alias cfg_kirEmptySize: kirEmptySize.value
    property alias cfg_kirGap: kirGap.value
    property alias cfg_kirMargin: kirMargin.value
    property alias cfg_kirEmptyOpacity: kirEmptyOpacity.value
    property string cfg_kirFaceColor: "#FFFFFF"
    property string cfg_kirDetailColor: "#FFFFFF"
    property string cfg_kirEmptyColor: "#FFFFFF"

    property alias cfg_kitActiveSize: kitActiveSize.value
    property alias cfg_kitOccupiedSize: kitOccupiedSize.value
    property alias cfg_kitEmptySize: kitEmptySize.value
    property alias cfg_kitGap: kitGap.value
    property alias cfg_kitMargin: kitMargin.value
    property alias cfg_kitEmptyOpacity: kitEmptyOpacity.value
    property string cfg_kitFaceColor: "#FFFFFF"
    property string cfg_kitPawColor: "#FFFFFF"
    property string cfg_kitEmptyColor: "#FFFFFF"

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

        QtControls.ComboBox {
            id: indicatorStyle
            Kirigami.FormData.label: i18n("Indicator style:")
            model: [
                i18n("Caelestia — pacman / fantasma / punto"),
                i18n("Hyrulian — espada / rupia / punto"),
                i18n("Triforce — trifuerza / fragmento / punto"),
                i18n("Creeper — creeper / TNT / punto"),
                i18n("Hearts — lleno / medio / punto"),
                i18n("Pokeball — pokébola / mini / punto"),
                i18n("Pikachu — cara / rayo / punto"),
                i18n("Mario — estrella / bloque ? / punto"),
                i18n("Dragonball — esfera / mini / punto"),
                i18n("Kirby — cara / mini / punto"),
                i18n("Kitty — carita / huellita / punto")
            ]
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
        //  CAELESTIA (pacman / terminal / dot)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Caelestia")
        }

        QtControls.SpinBox {
            id: caeActiveSize; from: 10; to: 40
            Kirigami.FormData.label: i18n("Focused size:")
        }
        QtControls.SpinBox {
            id: caeOccupiedSize; from: 6; to: 32
            Kirigami.FormData.label: i18n("Occupied size:")
        }
        QtControls.SpinBox {
            id: caeEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: caeGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: caeMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: caeMouthAngle; from: 0; to: 90
            Kirigami.FormData.label: i18n("Mouth angle:")
        }
        QtControls.CheckBox {
            id: caeAnimate
            Kirigami.FormData.label: i18n("Animate:")
            text: i18n("Pacman bite animation")
        }
        QtControls.CheckBox {
            id: caeShowGlyph
            Kirigami.FormData.label: i18n("Ghosts:")
            text: i18n("Ghost on occupied (off = square)")
        }
        QtControls.SpinBox {
            id: caeEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Focused color:")
            KQControls.ColorButton {
                id: caeActiveColor
                color: cfg_caeActiveColor
                onColorChanged: cfg_caeActiveColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Occupied color:")
            KQControls.ColorButton {
                id: caeOccupiedColor
                color: cfg_caeOccupiedColor
                onColorChanged: cfg_caeOccupiedColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: caeEmptyColor
                color: cfg_caeEmptyColor
                onColorChanged: cfg_caeEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  HYRULIAN (espada / rupia / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Hyrulian")
        }

        QtControls.SpinBox {
            id: hyrActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Sword size:")
        }
        QtControls.SpinBox {
            id: hyrOccupiedSize; from: 6; to: 32
            Kirigami.FormData.label: i18n("Rupee size:")
        }
        QtControls.SpinBox {
            id: hyrEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: hyrGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: hyrMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.CheckBox {
            id: hyrGlow
            Kirigami.FormData.label: i18n("Glow:")
            text: i18n("Golden glow on sword")
        }
        QtControls.SpinBox {
            id: hyrEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Blade color:")
            KQControls.ColorButton {
                id: hyrBladeColor
                color: cfg_hyrBladeColor
                onColorChanged: cfg_hyrBladeColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Gold color:")
            KQControls.ColorButton {
                id: hyrGoldColor
                color: cfg_hyrGoldColor
                onColorChanged: cfg_hyrGoldColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Grip color:")
            KQControls.ColorButton {
                id: hyrGripColor
                color: cfg_hyrGripColor
                onColorChanged: cfg_hyrGripColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Rupee color:")
            KQControls.ColorButton {
                id: hyrOccupiedColor
                color: cfg_hyrOccupiedColor
                onColorChanged: cfg_hyrOccupiedColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: hyrEmptyColor
                color: cfg_hyrEmptyColor
                onColorChanged: cfg_hyrEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  TRIFORCE (trifuerza / fragmento / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Triforce")
        }

        QtControls.SpinBox {
            id: triActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Triforce size:")
        }
        QtControls.SpinBox {
            id: triOccupiedSize; from: 6; to: 32
            Kirigami.FormData.label: i18n("Shard size:")
        }
        QtControls.SpinBox {
            id: triEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: triGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: triMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.CheckBox {
            id: triGlow
            Kirigami.FormData.label: i18n("Glow:")
            text: i18n("Glow on triforce")
        }
        QtControls.SpinBox {
            id: triEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Triforce color:")
            KQControls.ColorButton {
                id: triActiveColor
                color: cfg_triActiveColor
                onColorChanged: cfg_triActiveColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Shard color:")
            KQControls.ColorButton {
                id: triOccupiedColor
                color: cfg_triOccupiedColor
                onColorChanged: cfg_triOccupiedColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: triEmptyColor
                color: cfg_triEmptyColor
                onColorChanged: cfg_triEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  CREEPER (creeper / TNT / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Creeper")
        }

        QtControls.SpinBox {
            id: creActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Creeper size:")
        }
        QtControls.SpinBox {
            id: creOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("TNT size:")
        }
        QtControls.SpinBox {
            id: creEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: creGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: creMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: creEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Skin color:")
            KQControls.ColorButton {
                id: creSkinColor
                color: cfg_creSkinColor
                onColorChanged: cfg_creSkinColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Face color:")
            KQControls.ColorButton {
                id: creFaceColor
                color: cfg_creFaceColor
                onColorChanged: cfg_creFaceColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("TNT color:")
            KQControls.ColorButton {
                id: creTntColor
                color: cfg_creTntColor
                onColorChanged: cfg_creTntColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("TNT band:")
            KQControls.ColorButton {
                id: creBandColor
                color: cfg_creBandColor
                onColorChanged: cfg_creBandColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: creEmptyColor
                color: cfg_creEmptyColor
                onColorChanged: cfg_creEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  HEARTS (lleno / medio / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Hearts")
        }

        QtControls.SpinBox {
            id: heaActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Full heart size:")
        }
        QtControls.SpinBox {
            id: heaOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("Half heart size:")
        }
        QtControls.SpinBox {
            id: heaEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: heaGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: heaMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: heaBaseOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Half base opacity:")
        }
        QtControls.SpinBox {
            id: heaEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Full heart color:")
            KQControls.ColorButton {
                id: heaFullColor
                color: cfg_heaFullColor
                onColorChanged: cfg_heaFullColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Half heart color:")
            KQControls.ColorButton {
                id: heaHalfColor
                color: cfg_heaHalfColor
                onColorChanged: cfg_heaHalfColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: heaEmptyColor
                color: cfg_heaEmptyColor
                onColorChanged: cfg_heaEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  POKEBALL (pokébola / mini / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Pokeball")
        }

        QtControls.SpinBox {
            id: pokActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Pokeball size:")
        }
        QtControls.SpinBox {
            id: pokOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("Mini size:")
        }
        QtControls.SpinBox {
            id: pokEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: pokGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: pokMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: pokEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Ball color:")
            KQControls.ColorButton {
                id: pokBallColor
                color: cfg_pokBallColor
                onColorChanged: cfg_pokBallColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Band color:")
            KQControls.ColorButton {
                id: pokBandColor
                color: cfg_pokBandColor
                onColorChanged: cfg_pokBandColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: pokEmptyColor
                color: cfg_pokEmptyColor
                onColorChanged: cfg_pokEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  PIKACHU (cara / rayo / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Pikachu")
        }

        QtControls.SpinBox {
            id: pikActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Face size:")
        }
        QtControls.SpinBox {
            id: pikOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("Bolt size:")
        }
        QtControls.SpinBox {
            id: pikEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: pikGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: pikMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: pikEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Face color:")
            KQControls.ColorButton {
                id: pikFaceColor
                color: cfg_pikFaceColor
                onColorChanged: cfg_pikFaceColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Details color:")
            KQControls.ColorButton {
                id: pikDetailColor
                color: cfg_pikDetailColor
                onColorChanged: cfg_pikDetailColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: pikEmptyColor
                color: cfg_pikEmptyColor
                onColorChanged: cfg_pikEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  MARIO (estrella / bloque ? / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Mario")
        }

        QtControls.SpinBox {
            id: marActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Star size:")
        }
        QtControls.SpinBox {
            id: marOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("Block size:")
        }
        QtControls.SpinBox {
            id: marEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: marGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: marMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: marEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Cap color:")
            KQControls.ColorButton {
                id: marCapColor
                color: cfg_marCapColor
                onColorChanged: cfg_marCapColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Eyes color:")
            KQControls.ColorButton {
                id: marSpotColor
                color: cfg_marSpotColor
                onColorChanged: cfg_marSpotColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Block color:")
            KQControls.ColorButton {
                id: marCoinColor
                color: cfg_marCoinColor
                onColorChanged: cfg_marCoinColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: marEmptyColor
                color: cfg_marEmptyColor
                onColorChanged: cfg_marEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  DRAGONBALL (esfera / mini / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Dragonball")
        }

        QtControls.SpinBox {
            id: draActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Ball size:")
        }
        QtControls.SpinBox {
            id: draOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("Mini size:")
        }
        QtControls.SpinBox {
            id: draEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: draGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: draMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: draEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Ball color:")
            KQControls.ColorButton {
                id: draBallColor
                color: cfg_draBallColor
                onColorChanged: cfg_draBallColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Stars color:")
            KQControls.ColorButton {
                id: draStarColor
                color: cfg_draStarColor
                onColorChanged: cfg_draStarColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: draEmptyColor
                color: cfg_draEmptyColor
                onColorChanged: cfg_draEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  KIRBY (cara / mini / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Kirby")
        }

        QtControls.SpinBox {
            id: kirActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Face size:")
        }
        QtControls.SpinBox {
            id: kirOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("Mini size:")
        }
        QtControls.SpinBox {
            id: kirEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: kirGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: kirMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: kirEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Face color:")
            KQControls.ColorButton {
                id: kirFaceColor
                color: cfg_kirFaceColor
                onColorChanged: cfg_kirFaceColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Details color:")
            KQControls.ColorButton {
                id: kirDetailColor
                color: cfg_kirDetailColor
                onColorChanged: cfg_kirDetailColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: kirEmptyColor
                color: cfg_kirEmptyColor
                onColorChanged: cfg_kirEmptyColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }

        // ═══════════════════════════════════════
        //  KITTY (carita / huellita / punto)
        // ═══════════════════════════════════════
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Kitty")
        }

        QtControls.SpinBox {
            id: kitActiveSize; from: 12; to: 44
            Kirigami.FormData.label: i18n("Face size:")
        }
        QtControls.SpinBox {
            id: kitOccupiedSize; from: 8; to: 32
            Kirigami.FormData.label: i18n("Paw size:")
        }
        QtControls.SpinBox {
            id: kitEmptySize; from: 4; to: 24
            Kirigami.FormData.label: i18n("Empty dot size:")
        }
        QtControls.SpinBox {
            id: kitGap; from: 0; to: 8
            Kirigami.FormData.label: i18n("Gap:")
        }
        QtControls.SpinBox {
            id: kitMargin; from: 0; to: 6
            Kirigami.FormData.label: i18n("Margin:")
        }
        QtControls.SpinBox {
            id: kitEmptyOpacity; from: 10; to: 100
            Kirigami.FormData.label: i18n("Empty opacity:")
        }

        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Cat color:")
            KQControls.ColorButton {
                id: kitFaceColor
                color: cfg_kitFaceColor
                onColorChanged: cfg_kitFaceColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Paw color:")
            KQControls.ColorButton {
                id: kitPawColor
                color: cfg_kitPawColor
                onColorChanged: cfg_kitPawColor = color.toString()
                showAlphaChannel: false
                enabled: !useSystemColors.checked
            }
        }
        QtLayouts.RowLayout {
            Kirigami.FormData.label: i18n("Empty color:")
            KQControls.ColorButton {
                id: kitEmptyColor
                color: cfg_kitEmptyColor
                onColorChanged: cfg_kitEmptyColor = color.toString()
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
                    indicatorStyle.currentIndex = 0
                    enableScroll.checked = true
                    scrollCyclic.checked = false
                    useSystemColors.checked = true
                    caeActiveSize.value = 18
                    caeOccupiedSize.value = 10
                    caeEmptySize.value = 6
                    caeGap.value = 2
                    caeMargin.value = 2
                    caeMouthAngle.value = 35
                    caeAnimate.checked = true
                    caeShowGlyph.checked = true
                    caeEmptyOpacity.value = 40
                    caeActiveColor.color = "#FFFFFF"
                    caeOccupiedColor.color = "#FFFFFF"
                    caeEmptyColor.color = "#FFFFFF"
                    hyrActiveSize.value = 20
                    hyrOccupiedSize.value = 10
                    hyrEmptySize.value = 6
                    hyrGap.value = 2
                    hyrMargin.value = 2
                    hyrGlow.checked = true
                    hyrEmptyOpacity.value = 40
                    hyrBladeColor.color = "#E8E8E8"
                    hyrGoldColor.color = "#E8B800"
                    hyrGripColor.color = "#3B5BFD"
                    hyrOccupiedColor.color = "#00E676"
                    hyrEmptyColor.color = "#FFFFFF"
                    triActiveSize.value = 20
                    triOccupiedSize.value = 10
                    triEmptySize.value = 6
                    triGap.value = 2
                    triMargin.value = 2
                    triGlow.checked = true
                    triEmptyOpacity.value = 40
                    triActiveColor.color = "#FFFFFF"
                    triOccupiedColor.color = "#FFFFFF"
                    triEmptyColor.color = "#FFFFFF"
                    creActiveSize.value = 20
                    creOccupiedSize.value = 12
                    creEmptySize.value = 6
                    creGap.value = 2
                    creMargin.value = 2
                    creEmptyOpacity.value = 40
                    creSkinColor.color = "#4CAF50"
                    creFaceColor.color = "#141414"
                    creTntColor.color = "#E53935"
                    creBandColor.color = "#FFFFFF"
                    creEmptyColor.color = "#FFFFFF"
                    heaActiveSize.value = 20
                    heaOccupiedSize.value = 14
                    heaEmptySize.value = 6
                    heaGap.value = 2
                    heaMargin.value = 2
                    heaBaseOpacity.value = 35
                    heaEmptyOpacity.value = 40
                    heaFullColor.color = "#FFFFFF"
                    heaHalfColor.color = "#FFFFFF"
                    heaEmptyColor.color = "#FFFFFF"
                    pokActiveSize.value = 20
                    pokOccupiedSize.value = 12
                    pokEmptySize.value = 6
                    pokGap.value = 2
                    pokMargin.value = 2
                    pokEmptyOpacity.value = 40
                    pokBallColor.color = "#FFFFFF"
                    pokBandColor.color = "#FFFFFF"
                    pokEmptyColor.color = "#FFFFFF"
                    pikActiveSize.value = 20
                    pikOccupiedSize.value = 12
                    pikEmptySize.value = 6
                    pikGap.value = 2
                    pikMargin.value = 2
                    pikEmptyOpacity.value = 40
                    pikFaceColor.color = "#FFFFFF"
                    pikDetailColor.color = "#FFFFFF"
                    pikEmptyColor.color = "#FFFFFF"
                    marActiveSize.value = 20
                    marOccupiedSize.value = 12
                    marEmptySize.value = 6
                    marGap.value = 2
                    marMargin.value = 2
                    marEmptyOpacity.value = 40
                    marCapColor.color = "#FFFFFF"
                    marSpotColor.color = "#FFFFFF"
                    marCoinColor.color = "#FFFFFF"
                    marEmptyColor.color = "#FFFFFF"
                    draActiveSize.value = 20
                    draOccupiedSize.value = 12
                    draEmptySize.value = 6
                    draGap.value = 2
                    draMargin.value = 2
                    draEmptyOpacity.value = 40
                    draBallColor.color = "#FFFFFF"
                    draStarColor.color = "#FFFFFF"
                    draEmptyColor.color = "#FFFFFF"
                    kirActiveSize.value = 20
                    kirOccupiedSize.value = 12
                    kirEmptySize.value = 6
                    kirGap.value = 2
                    kirMargin.value = 2
                    kirEmptyOpacity.value = 40
                    kirFaceColor.color = "#FFFFFF"
                    kirDetailColor.color = "#FFFFFF"
                    kirEmptyColor.color = "#FFFFFF"
                    kitActiveSize.value = 20
                    kitOccupiedSize.value = 12
                    kitEmptySize.value = 6
                    kitGap.value = 2
                    kitMargin.value = 2
                    kitEmptyOpacity.value = 40
                    kitFaceColor.color = "#FFFFFF"
                    kitPawColor.color = "#FFFFFF"
                    kitEmptyColor.color = "#FFFFFF"
                }
            }
            Item { QtLayouts.Layout.fillWidth: true }
        }
    }
}
