import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami

Item {
    id: pagerViewRoot

    property int currentIndex: 0
    property int numberOfDesktops: 1
    property var desktopsWithWindows: ({})
    property var desktopNames: []
    property var desktopIds: []

    // Scale modifier: 0 = compact, 1 = full padding
    property int scaleModifier: 0

    readonly property real smallSpacing: Kirigami.Units.smallSpacing

    // Neko Desktop: solo estilos de iconos (0-10)
    readonly property int indicatorStyle: Plasmoid.configuration.indicatorStyle
    readonly property bool isCaelestia: indicatorStyle === 0
    readonly property bool isHyrulian: indicatorStyle === 1
    readonly property bool isTriforce: indicatorStyle === 2
    readonly property bool isCreeper: indicatorStyle === 3
    readonly property bool isHearts: indicatorStyle === 4
    readonly property bool isPokeball: indicatorStyle === 5
    readonly property bool isPikachu: indicatorStyle === 6
    readonly property bool isMario: indicatorStyle === 7
    readonly property bool isDragonball: indicatorStyle === 8
    readonly property bool isKirby: indicatorStyle === 9
    readonly property bool isKitty: indicatorStyle === 10
    readonly property bool useSysColors: Plasmoid.configuration.useSystemColors

    // Computed properties for Caelestia (estilo artístico: pacman / ocupado / vacío)
    readonly property real caeActiveSize: Math.max(10, Plasmoid.configuration.caeActiveSize + scaleModifier * 2)
    readonly property real caeOccupiedSize: Math.max(6, Plasmoid.configuration.caeOccupiedSize + scaleModifier)
    readonly property real caeEmptySize: Math.max(4, Plasmoid.configuration.caeEmptySize)
    readonly property real caeGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.caeGap + scaleModifier))
    readonly property real caeMargin: smallSpacing * Math.max(0, Plasmoid.configuration.caeMargin + scaleModifier)
    // Caelestia en monocromo (color de texto: blanco en tema oscuro,
    // negro en claro). Los 3 estados se distinguen por forma/tamaño.
    readonly property color caeActiveColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.caeActiveColor
    readonly property color caeOccupiedColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.caeOccupiedColor
    readonly property color caeEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.caeEmptyColor

    // Computed properties for Hyrulian (espada / rupia / puntito)
    readonly property real hyrActiveSize: Math.max(12, Plasmoid.configuration.hyrActiveSize + scaleModifier * 2)
    readonly property real hyrOccupiedSize: Math.max(6, Plasmoid.configuration.hyrOccupiedSize + scaleModifier)
    readonly property real hyrEmptySize: Math.max(4, Plasmoid.configuration.hyrEmptySize)
    readonly property real hyrGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.hyrGap + scaleModifier))
    readonly property real hyrMargin: smallSpacing * Math.max(0, Plasmoid.configuration.hyrMargin + scaleModifier)
    // Hyrulian en monocromo a juego con Caelestia: espada blanca
    // (color de texto), rupia morada (highlight), puntito tenue.
    readonly property color hyrBladeColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.hyrBladeColor
    readonly property color hyrGoldColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.hyrGoldColor
    readonly property color hyrGripColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.hyrGripColor
    readonly property color hyrOccupiedColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.hyrOccupiedColor
    readonly property color hyrEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.hyrEmptyColor

    // Computed properties for Triforce (trifuerza / fragmento / puntito,
    // en monocromo como Caelestia: blanca, fragmento morado, punto tenue)
    readonly property real triActiveSize: Math.max(12, Plasmoid.configuration.triActiveSize + scaleModifier * 2)
    readonly property real triOccupiedSize: Math.max(6, Plasmoid.configuration.triOccupiedSize + scaleModifier)
    readonly property real triEmptySize: Math.max(4, Plasmoid.configuration.triEmptySize)
    readonly property real triGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.triGap + scaleModifier))
    readonly property real triMargin: smallSpacing * Math.max(0, Plasmoid.configuration.triMargin + scaleModifier)
    readonly property color triActiveColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.triActiveColor
    readonly property color triOccupiedColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.triOccupiedColor
    readonly property color triEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.triEmptyColor

    // Computed properties for Creeper (creeper / TNT / puntito, colores clásicos)
    readonly property real creActiveSize: Math.max(12, Plasmoid.configuration.creActiveSize + scaleModifier * 2)
    readonly property real creOccupiedSize: Math.max(8, Plasmoid.configuration.creOccupiedSize + scaleModifier)
    readonly property real creEmptySize: Math.max(4, Plasmoid.configuration.creEmptySize)
    readonly property real creGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.creGap + scaleModifier))
    readonly property real creMargin: smallSpacing * Math.max(0, Plasmoid.configuration.creMargin + scaleModifier)
    // Creeper en monocromo como el resto: piel blanca, cara morada,
    // TNT morado con banda blanca, puntito tenue.
    readonly property color creSkinColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.creSkinColor
    readonly property color creFaceColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.creFaceColor
    readonly property color creTntColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.creTntColor
    readonly property color creBandColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.creBandColor
    readonly property color creEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.creEmptyColor

    // Computed properties for Hearts (lleno / medio / puntito, monocromo)
    readonly property real heaActiveSize: Math.max(12, Plasmoid.configuration.heaActiveSize + scaleModifier * 2)
    readonly property real heaOccupiedSize: Math.max(8, Plasmoid.configuration.heaOccupiedSize + scaleModifier)
    readonly property real heaEmptySize: Math.max(4, Plasmoid.configuration.heaEmptySize)
    readonly property real heaGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.heaGap + scaleModifier))
    readonly property real heaMargin: smallSpacing * Math.max(0, Plasmoid.configuration.heaMargin + scaleModifier)
    readonly property color heaFullColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.heaFullColor
    readonly property color heaHalfColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.heaHalfColor
    readonly property color heaEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.heaEmptyColor

    // Computed properties for Pokeball (pokébola / mini / puntito, monocromo:
    // bola blanca con banda morada, mini morada con banda blanca)
    readonly property real pokActiveSize: Math.max(12, Plasmoid.configuration.pokActiveSize + scaleModifier * 2)
    readonly property real pokOccupiedSize: Math.max(8, Plasmoid.configuration.pokOccupiedSize + scaleModifier)
    readonly property real pokEmptySize: Math.max(4, Plasmoid.configuration.pokEmptySize)
    readonly property real pokGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.pokGap + scaleModifier))
    readonly property real pokMargin: smallSpacing * Math.max(0, Plasmoid.configuration.pokMargin + scaleModifier)
    readonly property color pokBallColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.pokBallColor
    readonly property color pokBandColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.pokBandColor
    readonly property color pokEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.pokEmptyColor

    // Computed properties for Pikachu (cara / cola-rayo / puntito, monocromo:
    // cara blanca con detalles morados, cola morada)
    readonly property real pikActiveSize: Math.max(12, Plasmoid.configuration.pikActiveSize + scaleModifier * 2)
    readonly property real pikOccupiedSize: Math.max(8, Plasmoid.configuration.pikOccupiedSize + scaleModifier)
    readonly property real pikEmptySize: Math.max(4, Plasmoid.configuration.pikEmptySize)
    readonly property real pikGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.pikGap + scaleModifier))
    readonly property real pikMargin: smallSpacing * Math.max(0, Plasmoid.configuration.pikMargin + scaleModifier)
    readonly property color pikFaceColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.pikFaceColor
    readonly property color pikDetailColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.pikDetailColor
    readonly property color pikEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.pikEmptyColor

    // Computed properties for Mario (estrella / bloque ? / puntito, monocromo:
    // estrella blanca con ojos morados, bloque morado con ? blanca)
    readonly property real marActiveSize: Math.max(12, Plasmoid.configuration.marActiveSize + scaleModifier * 2)
    readonly property real marOccupiedSize: Math.max(8, Plasmoid.configuration.marOccupiedSize + scaleModifier)
    readonly property real marEmptySize: Math.max(4, Plasmoid.configuration.marEmptySize)
    readonly property real marGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.marGap + scaleModifier))
    readonly property real marMargin: smallSpacing * Math.max(0, Plasmoid.configuration.marMargin + scaleModifier)
    readonly property color marCapColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.marCapColor
    readonly property color marSpotColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.marSpotColor
    readonly property color marCoinColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.marCoinColor
    readonly property color marEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.marEmptyColor

    // Computed properties for Dragonball (esfera 4 estrellas / mini 1 estrella /
    // puntito, monocromo: bola blanca con estrellas moradas, mini invertida)
    readonly property real draActiveSize: Math.max(12, Plasmoid.configuration.draActiveSize + scaleModifier * 2)
    readonly property real draOccupiedSize: Math.max(8, Plasmoid.configuration.draOccupiedSize + scaleModifier)
    readonly property real draEmptySize: Math.max(4, Plasmoid.configuration.draEmptySize)
    readonly property real draGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.draGap + scaleModifier))
    readonly property real draMargin: smallSpacing * Math.max(0, Plasmoid.configuration.draMargin + scaleModifier)
    readonly property color draBallColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.draBallColor
    readonly property color draStarColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.draStarColor
    readonly property color draEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.draEmptyColor

    // Computed properties for Kirby (cara / mini / puntito, monocromo:
    // cara blanca con detalles morados, mini morada con ojos blancos)
    readonly property real kirActiveSize: Math.max(12, Plasmoid.configuration.kirActiveSize + scaleModifier * 2)
    readonly property real kirOccupiedSize: Math.max(8, Plasmoid.configuration.kirOccupiedSize + scaleModifier)
    readonly property real kirEmptySize: Math.max(4, Plasmoid.configuration.kirEmptySize)
    readonly property real kirGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.kirGap + scaleModifier))
    readonly property real kirMargin: smallSpacing * Math.max(0, Plasmoid.configuration.kirMargin + scaleModifier)
    readonly property color kirFaceColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.kirFaceColor
    readonly property color kirDetailColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.kirDetailColor
    readonly property color kirEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.kirEmptyColor

    // Computed properties for Kitty (gato + huella dibujados,
    // monocromo: gato blanco, huella morada)
    readonly property real kitActiveSize: Math.max(12, Plasmoid.configuration.kitActiveSize + scaleModifier * 2)
    readonly property real kitOccupiedSize: Math.max(8, Plasmoid.configuration.kitOccupiedSize + scaleModifier)
    readonly property real kitEmptySize: Math.max(4, Plasmoid.configuration.kitEmptySize)
    readonly property real kitGap: Math.round(smallSpacing * Math.max(0, Plasmoid.configuration.kitGap + scaleModifier))
    readonly property real kitMargin: smallSpacing * Math.max(0, Plasmoid.configuration.kitMargin + scaleModifier)
    readonly property color kitFaceColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.kitFaceColor
    readonly property color kitPawColor: useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.kitPawColor
    readonly property color kitEmptyColor: useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.kitEmptyColor

    // Celda cuadrada del estilo activo: todos los iconos comparten medidas
    readonly property real cellSize: isCaelestia ? caeActiveSize : (isHyrulian ? hyrActiveSize : (isTriforce ? triActiveSize : (isCreeper ? creActiveSize : (isHearts ? heaActiveSize : (isPokeball ? pokActiveSize : (isPikachu ? pikActiveSize : (isMario ? marActiveSize : (isDragonball ? draActiveSize : (isKirby ? kirActiveSize : kitActiveSize)))))))))
    readonly property real gap: isCaelestia ? caeGap : (isHyrulian ? hyrGap : (isTriforce ? triGap : (isCreeper ? creGap : (isHearts ? heaGap : (isPokeball ? pokGap : (isPikachu ? pikGap : (isMario ? marGap : (isDragonball ? draGap : (isKirby ? kirGap : kitGap)))))))))
    readonly property real margin: isCaelestia ? caeMargin : (isHyrulian ? hyrMargin : (isTriforce ? triMargin : (isCreeper ? creMargin : (isHearts ? heaMargin : (isPokeball ? pokMargin : (isPikachu ? pikMargin : (isMario ? marMargin : (isDragonball ? draMargin : (isKirby ? kirMargin : kitMargin)))))))))

    readonly property real exactWidth: numberOfDesktops * cellSize + (numberOfDesktops - 1) * gap + margin * 2

    implicitWidth: exactWidth
    Layout.minimumWidth: exactWidth
    Layout.preferredWidth: exactWidth

    implicitHeight: cellSize + margin * 2

    visible: numberOfDesktops > 1

    signal requestSwitchDesktop(int index)

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        enabled: Plasmoid.configuration.enableScroll
        onWheel: function (wheel) {
            if (wheel.angleDelta.y > 0) {
                var nextIdx = currentIndex - 1;
                if (nextIdx < 0) {
                    if (Plasmoid.configuration.scrollCyclic)
                        nextIdx = numberOfDesktops - 1;
                    else
                        return;
                }
                requestSwitchDesktop(nextIdx);
            } else if (wheel.angleDelta.y < 0) {
                var nextIdx = currentIndex + 1;
                if (nextIdx >= numberOfDesktops) {
                    if (Plasmoid.configuration.scrollCyclic)
                        nextIdx = 0;
                    else
                        return;
                }
                requestSwitchDesktop(nextIdx);
            }
        }
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: pagerViewRoot.gap

        Repeater {
            model: pagerViewRoot.numberOfDesktops

            delegate: DesktopDelegate {
                isCurrent: model.index === pagerViewRoot.currentIndex
                hasWindows: pagerViewRoot.desktopIds && model.index < pagerViewRoot.desktopIds.length && pagerViewRoot.desktopsWithWindows[pagerViewRoot.desktopIds[model.index]] === true
                desktopIndex: model.index
                desktopName: pagerViewRoot.desktopNames && model.index < pagerViewRoot.desktopNames.length ? pagerViewRoot.desktopNames[model.index] : ""

                isCaelestia: pagerViewRoot.isCaelestia
                caeActiveSize: pagerViewRoot.caeActiveSize
                caeOccupiedSize: pagerViewRoot.caeOccupiedSize
                caeEmptySize: pagerViewRoot.caeEmptySize
                caeActiveColor: pagerViewRoot.caeActiveColor
                caeOccupiedColor: pagerViewRoot.caeOccupiedColor
                caeEmptyColor: pagerViewRoot.caeEmptyColor

                isHyrulian: pagerViewRoot.isHyrulian
                hyrActiveSize: pagerViewRoot.hyrActiveSize
                hyrOccupiedSize: pagerViewRoot.hyrOccupiedSize
                hyrEmptySize: pagerViewRoot.hyrEmptySize
                hyrBladeColor: pagerViewRoot.hyrBladeColor
                hyrGoldColor: pagerViewRoot.hyrGoldColor
                hyrGripColor: pagerViewRoot.hyrGripColor
                hyrOccupiedColor: pagerViewRoot.hyrOccupiedColor
                hyrEmptyColor: pagerViewRoot.hyrEmptyColor

                isTriforce: pagerViewRoot.isTriforce
                triActiveSize: pagerViewRoot.triActiveSize
                triOccupiedSize: pagerViewRoot.triOccupiedSize
                triEmptySize: pagerViewRoot.triEmptySize
                triActiveColor: pagerViewRoot.triActiveColor
                triOccupiedColor: pagerViewRoot.triOccupiedColor
                triEmptyColor: pagerViewRoot.triEmptyColor

                isCreeper: pagerViewRoot.isCreeper
                creActiveSize: pagerViewRoot.creActiveSize
                creOccupiedSize: pagerViewRoot.creOccupiedSize
                creEmptySize: pagerViewRoot.creEmptySize
                creSkinColor: pagerViewRoot.creSkinColor
                creFaceColor: pagerViewRoot.creFaceColor
                creTntColor: pagerViewRoot.creTntColor
                creBandColor: pagerViewRoot.creBandColor
                creEmptyColor: pagerViewRoot.creEmptyColor

                isHearts: pagerViewRoot.isHearts
                heaActiveSize: pagerViewRoot.heaActiveSize
                heaOccupiedSize: pagerViewRoot.heaOccupiedSize
                heaEmptySize: pagerViewRoot.heaEmptySize
                heaFullColor: pagerViewRoot.heaFullColor
                heaHalfColor: pagerViewRoot.heaHalfColor
                heaEmptyColor: pagerViewRoot.heaEmptyColor

                isPokeball: pagerViewRoot.isPokeball
                pokActiveSize: pagerViewRoot.pokActiveSize
                pokOccupiedSize: pagerViewRoot.pokOccupiedSize
                pokEmptySize: pagerViewRoot.pokEmptySize
                pokBallColor: pagerViewRoot.pokBallColor
                pokBandColor: pagerViewRoot.pokBandColor
                pokEmptyColor: pagerViewRoot.pokEmptyColor

                isPikachu: pagerViewRoot.isPikachu
                pikActiveSize: pagerViewRoot.pikActiveSize
                pikOccupiedSize: pagerViewRoot.pikOccupiedSize
                pikEmptySize: pagerViewRoot.pikEmptySize
                pikFaceColor: pagerViewRoot.pikFaceColor
                pikDetailColor: pagerViewRoot.pikDetailColor
                pikEmptyColor: pagerViewRoot.pikEmptyColor

                isMario: pagerViewRoot.isMario
                marActiveSize: pagerViewRoot.marActiveSize
                marOccupiedSize: pagerViewRoot.marOccupiedSize
                marEmptySize: pagerViewRoot.marEmptySize
                marCapColor: pagerViewRoot.marCapColor
                marSpotColor: pagerViewRoot.marSpotColor
                marCoinColor: pagerViewRoot.marCoinColor
                marEmptyColor: pagerViewRoot.marEmptyColor

                isDragonball: pagerViewRoot.isDragonball
                draActiveSize: pagerViewRoot.draActiveSize
                draOccupiedSize: pagerViewRoot.draOccupiedSize
                draEmptySize: pagerViewRoot.draEmptySize
                draBallColor: pagerViewRoot.draBallColor
                draStarColor: pagerViewRoot.draStarColor
                draEmptyColor: pagerViewRoot.draEmptyColor

                isKirby: pagerViewRoot.isKirby
                kirActiveSize: pagerViewRoot.kirActiveSize
                kirOccupiedSize: pagerViewRoot.kirOccupiedSize
                kirEmptySize: pagerViewRoot.kirEmptySize
                kirFaceColor: pagerViewRoot.kirFaceColor
                kirDetailColor: pagerViewRoot.kirDetailColor
                kirEmptyColor: pagerViewRoot.kirEmptyColor

                isKitty: pagerViewRoot.isKitty
                kitActiveSize: pagerViewRoot.kitActiveSize
                kitOccupiedSize: pagerViewRoot.kitOccupiedSize
                kitEmptySize: pagerViewRoot.kitEmptySize
                kitFaceColor: pagerViewRoot.kitFaceColor
                kitPawColor: pagerViewRoot.kitPawColor
                kitEmptyColor: pagerViewRoot.kitEmptyColor

                animationDuration: scaleModifier === 0 ? 160 : 200

                onClicked: requestSwitchDesktop(model.index)
            }
        }
    }
}
