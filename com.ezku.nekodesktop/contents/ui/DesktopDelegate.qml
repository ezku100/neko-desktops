import QtQuick
import org.kde.plasma.plasmoid

Item {
    id: delegateRoot

    property bool isCurrent: false
    property bool hasWindows: false
    property int desktopIndex: 0
    property string desktopName: ""
    
    // View styling properties passed from PagerView
    property bool isCaelestia: false
    property bool isHyrulian: false
    property bool isTriforce: false
    property bool isCreeper: false
    property bool isHearts: false
    property bool isPokeball: false
    property bool isPikachu: false
    property bool isMario: false
    property bool isDragonball: false
    property bool isKirby: false
    property bool isKitty: false

    // Caelestia artistic style (pacman / terminal / dot)
    property real caeActiveSize: 18
    property real caeOccupiedSize: 10
    property real caeEmptySize: 6
    property color caeActiveColor: "transparent"
    property color caeOccupiedColor: "transparent"
    property color caeEmptyColor: "transparent"

    // Hyrulian (espada maestra / rupia / puntito)
    property real hyrActiveSize: 20
    property real hyrOccupiedSize: 10
    property real hyrEmptySize: 6
    property color hyrBladeColor: "#E8E8E8"
    property color hyrGoldColor: "#E8B800"
    property color hyrGripColor: "#3B5BFD"
    property color hyrOccupiedColor: "#00E676"
    property color hyrEmptyColor: "transparent"

    // Triforce (trifuerza / fragmento / puntito)
    property real triActiveSize: 20
    property real triOccupiedSize: 10
    property real triEmptySize: 6
    property color triActiveColor: "transparent"
    property color triOccupiedColor: "transparent"
    property color triEmptyColor: "transparent"

    // Creeper (creeper / TNT / puntito, pixel-art)
    property real creActiveSize: 20
    property real creOccupiedSize: 12
    property real creEmptySize: 6
    property color creSkinColor: "#4CAF50"
    property color creFaceColor: "#141414"
    property color creTntColor: "#E53935"
    property color creBandColor: "#FFFFFF"
    property color creEmptyColor: "transparent"

    // Hearts (lleno / medio / puntito, pixel-art)
    property real heaActiveSize: 20
    property real heaOccupiedSize: 14
    property real heaEmptySize: 6
    property color heaFullColor: "transparent"
    property color heaHalfColor: "transparent"
    property color heaEmptyColor: "transparent"

    // Pokeball (pokébola / mini / puntito)
    property real pokActiveSize: 20
    property real pokOccupiedSize: 12
    property real pokEmptySize: 6
    property color pokBallColor: "transparent"
    property color pokBandColor: "transparent"
    property color pokEmptyColor: "transparent"

    // Pikachu (cara / cola-rayo / puntito)
    property real pikActiveSize: 20
    property real pikOccupiedSize: 12
    property real pikEmptySize: 6
    property color pikFaceColor: "transparent"
    property color pikDetailColor: "transparent"
    property color pikEmptyColor: "transparent"

    // Mario (hongo / moneda / puntito)
    property real marActiveSize: 20
    property real marOccupiedSize: 12
    property real marEmptySize: 6
    property color marCapColor: "transparent"
    property color marSpotColor: "transparent"
    property color marCoinColor: "transparent"
    property color marEmptyColor: "transparent"

    // Dragonball (esfera 4 estrellas / mini 1 estrella / puntito)
    property real draActiveSize: 20
    property real draOccupiedSize: 12
    property real draEmptySize: 6
    property color draBallColor: "transparent"
    property color draStarColor: "transparent"
    property color draEmptyColor: "transparent"

    // Kirby (cara / mini / puntito)
    property real kirActiveSize: 20
    property real kirOccupiedSize: 12
    property real kirEmptySize: 6
    property color kirFaceColor: "transparent"
    property color kirDetailColor: "transparent"
    property color kirEmptyColor: "transparent"

    // Kitty (carita / huellita / puntito)
    property real kitActiveSize: 20
    property real kitOccupiedSize: 12
    property real kitEmptySize: 6
    property color kitFaceColor: "transparent"
    property color kitPawColor: "transparent"
    property color kitEmptyColor: "transparent"

    // Dibuja una pokébola de diámetro S con banda y botón central
    function drawPokeball(ctx, S, ballColor, bandColor) {
        var cx = S / 2, cy = S / 2, r = S / 2 - 0.5;
        if (r <= 0) return;
        ctx.save();
        ctx.beginPath();
        ctx.arc(cx, cy, r, 0, Math.PI * 2, false);
        ctx.fillStyle = ballColor.toString();
        ctx.fill();
        ctx.clip();
        ctx.fillStyle = bandColor.toString();
        var bh = Math.max(2, S * 0.16);
        ctx.fillRect(0, cy - bh / 2, S, bh);
        ctx.restore();
        ctx.beginPath();
        ctx.arc(cx, cy, Math.max(1.5, S * 0.17), 0, Math.PI * 2, false);
        ctx.fillStyle = bandColor.toString();
        ctx.fill();
        ctx.beginPath();
        ctx.arc(cx, cy, Math.max(0.8, S * 0.09), 0, Math.PI * 2, false);
        ctx.fillStyle = ballColor.toString();
        ctx.fill();
    }

    property int animationDuration: 160

    // Celda cuadrada: cada estilo define su tamaño de icono activo
    width: {
        if (isHyrulian) return hyrActiveSize;
        if (isTriforce) return triActiveSize;
        if (isCreeper) return creActiveSize;
        if (isHearts) return heaActiveSize;
        if (isPokeball) return pokActiveSize;
        if (isPikachu) return pikActiveSize;
        if (isMario) return marActiveSize;
        if (isDragonball) return draActiveSize;
        if (isKirby) return kirActiveSize;
        if (isKitty) return kitActiveSize;
        return caeActiveSize;
    }
    height: {
        if (isHyrulian) return hyrActiveSize;
        if (isTriforce) return triActiveSize;
        if (isCreeper) return creActiveSize;
        if (isHearts) return heaActiveSize;
        if (isPokeball) return pokActiveSize;
        if (isPikachu) return pikActiveSize;
        if (isMario) return marActiveSize;
        if (isDragonball) return draActiveSize;
        if (isKirby) return kirActiveSize;
        if (isKitty) return kitActiveSize;
        return caeActiveSize;
    }

    // ═══════════════════════════════════════
    //  CAELESTIA — estilo artístico:
    //  focus = pacman, ocupado = fantasma, vacío = puntito
    //  (inspirado en caelestia-dots/shell Workspace.qml:
    //   focused escala 2/3 con forma aleatoria, ocupado 1/3 cuadrado,
    //   vacío 1/4 círculo)
    // ═══════════════════════════════════════
    property real caeBite: 35
    property int caeRotation: 0

    onIsCurrentChanged: {
        // Pacman siempre de perfil (mirando a la derecha): las rotaciones
        // verticales se veían mal en el panel.
        if (isCaelestia && isCurrent) caeRotation = 0;
    }

    SequentialAnimation on caeBite {
        running: isCaelestia && isCurrent && Plasmoid.configuration.caeAnimate
        loops: Animation.Infinite
        NumberAnimation { from: 12; to: 55; duration: 420; easing.type: Easing.InOutQuad }
        NumberAnimation { from: 55; to: 12; duration: 420; easing.type: Easing.InOutQuad }
    }

    Canvas {
        id: pacman
        visible: isCaelestia && isCurrent
        anchors.centerIn: parent
        width: caeActiveSize
        height: caeActiveSize
        rotation: caeRotation
        property real bite: delegateRoot.caeBite
        property color pacColor: delegateRoot.caeActiveColor
        onBiteChanged: requestPaint()
        onPacColorChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()

        Behavior on rotation {
            RotationAnimation { duration: animationDuration; easing.type: Easing.OutCubic; direction: RotationAnimation.Shortest }
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var cx = width / 2, cy = height / 2;
            var r = Math.min(width, height) / 2 - 1;
            if (r <= 0) return;
            var mouth = (bite * Math.PI / 180) / 2;
            ctx.beginPath();
            ctx.moveTo(cx, cy);
            ctx.arc(cx, cy, r, mouth, Math.PI * 2 - mouth, false);
            ctx.closePath();
            ctx.fillStyle = pacColor.toString();
            ctx.fill();
        }
    }

    // Ocupado: fantasmita con ojos recortados (o cuadradito si se desactiva)
    Canvas {
        id: ghost
        visible: isCaelestia && !isCurrent && hasWindows && Plasmoid.configuration.caeShowGlyph
        anchors.centerIn: parent
        width: caeOccupiedSize + 7
        height: caeOccupiedSize + 9
        property color gColor: delegateRoot.caeOccupiedColor
        onGColorChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var bw = width * 0.72;
            var bx = (width - bw) / 2;
            var cx = width / 2;
            var headCy = 1 + bw / 2;
            var bottomY = height - 1;
            if (bw <= 0 || bottomY <= headCy) return;
            ctx.beginPath();
            ctx.moveTo(bx, bottomY);
            ctx.lineTo(bx, headCy);
            ctx.arc(cx, headCy, bw / 2, Math.PI, 0, false);
            ctx.lineTo(bx + bw, bottomY);
            var steps = 3, sw = bw / steps;
            for (var i = 0; i < steps; i++) {
                ctx.lineTo(bx + bw - sw * (i + 0.5), bottomY - 3);
                ctx.lineTo(bx + bw - sw * (i + 1), bottomY);
            }
            ctx.closePath();
            ctx.fillStyle = gColor.toString();
            ctx.fill();
            // Ojos recortados: se transparentan y dejan ver el panel
            ctx.save();
            ctx.globalCompositeOperation = "destination-out";
            ctx.beginPath();
            var ex = bw * 0.18, er = Math.max(1.2, bw * 0.11), ey = headCy - bw * 0.04;
            ctx.arc(cx - ex, ey, er, 0, Math.PI * 2, false);
            ctx.arc(cx + ex, ey, er, 0, Math.PI * 2, false);
            ctx.fill();
            ctx.restore();
        }
    }
    Rectangle {
        visible: isCaelestia && !isCurrent && hasWindows && !Plasmoid.configuration.caeShowGlyph
        anchors.centerIn: parent
        width: caeOccupiedSize
        height: caeOccupiedSize
        radius: width * 0.3
        color: caeOccupiedColor
        opacity: 0.95
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isCaelestia && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: caeEmptySize
        height: caeEmptySize
        radius: height / 2
        color: caeEmptyColor
        opacity: (Plasmoid.configuration.caeEmptyOpacity || 40) / 100
    }
    
    // ═══════════════════════════════════════
    //  HYRULIAN — espada maestra / rupia / puntito
    // ═══════════════════════════════════════
    Canvas {
        id: sword
        visible: isHyrulian && isCurrent
        anchors.centerIn: parent
        width: hyrActiveSize
        height: hyrActiveSize
        property color blade: delegateRoot.hyrBladeColor
        property color gold: delegateRoot.hyrGoldColor
        property color grip: delegateRoot.hyrGripColor
        property bool glow: Plasmoid.configuration.hyrGlow
        onBladeChanged: requestPaint()
        onGoldChanged: requestPaint()
        onGripChanged: requestPaint()
        onGlowChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var cx = width / 2, S = Math.min(width, height);
            if (S <= 0) return;
            var tipY = 1, guardY = S * 0.56, halfB = Math.max(1.2, S * 0.085);
            ctx.save();
            if (glow) { ctx.shadowColor = gold.toString(); ctx.shadowBlur = 4; }
            // Hoja plateada
            ctx.beginPath();
            ctx.moveTo(cx, tipY);
            ctx.lineTo(cx + halfB, guardY - 2);
            ctx.lineTo(cx + halfB, guardY);
            ctx.lineTo(cx - halfB, guardY);
            ctx.lineTo(cx - halfB, guardY - 2);
            ctx.closePath();
            ctx.fillStyle = blade.toString();
            ctx.fill();
            ctx.restore();
            // Acanaladura central
            ctx.beginPath();
            ctx.moveTo(cx, tipY + 2);
            ctx.lineTo(cx, guardY - 1);
            ctx.strokeStyle = Qt.darker(blade, 1.6).toString();
            ctx.lineWidth = 1;
            ctx.stroke();
            // Guarda dorada
            ctx.fillStyle = gold.toString();
            var gw = S * 0.22, gh = Math.max(2, S * 0.09);
            ctx.fillRect(cx - gw, guardY, gw * 2, gh);
            // Empuñadura azul
            ctx.fillStyle = grip.toString();
            var gripW = Math.max(2, S * 0.1), gripY = guardY + gh, gripH = S * 0.18;
            ctx.fillRect(cx - gripW / 2, gripY, gripW, gripH);
            // Pomo dorado
            ctx.fillStyle = gold.toString();
            ctx.beginPath();
            ctx.arc(cx, gripY + gripH + 1.6, Math.max(1.2, S * 0.07), 0, Math.PI * 2, false);
            ctx.fill();
        }
    }

    // Ocupado: rupia verde facetada
    Canvas {
        id: rupee
        visible: isHyrulian && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: hyrOccupiedSize + 6
        height: hyrOccupiedSize + 8
        property color rColor: delegateRoot.hyrOccupiedColor
        onRColorChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var cx = width / 2, rw = width / 2 - 1, h = height - 2, y0 = 1;
            if (rw <= 0) return;
            ctx.beginPath();
            ctx.moveTo(cx, y0);
            ctx.lineTo(cx + rw, y0 + h * 0.30);
            ctx.lineTo(cx + rw * 0.72, y0 + h * 0.62);
            ctx.lineTo(cx, y0 + h);
            ctx.lineTo(cx - rw * 0.72, y0 + h * 0.62);
            ctx.lineTo(cx - rw, y0 + h * 0.30);
            ctx.closePath();
            ctx.fillStyle = rColor.toString();
            ctx.fill();
            // Faceta de brillo
            ctx.beginPath();
            ctx.moveTo(cx, y0 + 2);
            ctx.lineTo(cx + rw * 0.55, y0 + h * 0.30);
            ctx.lineTo(cx, y0 + h * 0.52);
            ctx.lineTo(cx - rw * 0.55, y0 + h * 0.30);
            ctx.closePath();
            ctx.fillStyle = Qt.lighter(rColor, 1.5).toString();
            ctx.globalAlpha = 0.8;
            ctx.fill();
            ctx.globalAlpha = 1.0;
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isHyrulian && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: hyrEmptySize
        height: hyrEmptySize
        radius: height / 2
        color: hyrEmptyColor
        opacity: (Plasmoid.configuration.hyrEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  TRIFORCE — trifuerza / fragmento / puntito
    // ═══════════════════════════════════════
    Canvas {
        id: triforce
        visible: isTriforce && isCurrent
        anchors.centerIn: parent
        width: triActiveSize
        height: triActiveSize
        property color tColor: delegateRoot.triActiveColor
        property bool glow: Plasmoid.configuration.triGlow
        onTColorChanged: requestPaint()
        onGlowChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var cx = width / 2, y0 = 1, y1 = height - 1, hw = (width - 2) / 2;
            if (hw <= 0 || y1 <= y0) return;
            var Lx = cx - hw, Rx = cx + hw;
            var MLx = (cx + Lx) / 2, MLy = (y0 + y1) / 2;
            var MRx = (cx + Rx) / 2, MRy = (y0 + y1) / 2;
            var MBx = cx, MBy = y1;
            ctx.save();
            if (glow) { ctx.shadowColor = tColor.toString(); ctx.shadowBlur = 4; }
            ctx.fillStyle = tColor.toString();
            ctx.beginPath();
            ctx.moveTo(cx, y0); ctx.lineTo(MLx, MLy); ctx.lineTo(MRx, MRy); ctx.closePath();
            ctx.moveTo(MLx, MLy); ctx.lineTo(Lx, y1); ctx.lineTo(MBx, MBy); ctx.closePath();
            ctx.moveTo(MRx, MRy); ctx.lineTo(MBx, MBy); ctx.lineTo(Rx, y1); ctx.closePath();
            ctx.fill();
            ctx.restore();
        }
    }

    // Ocupado: fragmento (un triangulito de la trifuerza)
    Canvas {
        id: shard
        visible: isTriforce && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: triOccupiedSize + 4
        height: triOccupiedSize + 4
        property color sColor: delegateRoot.triOccupiedColor
        onSColorChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            if (width <= 2 || height <= 2) return;
            ctx.beginPath();
            ctx.moveTo(width / 2, 1);
            ctx.lineTo(width - 1, height - 1);
            ctx.lineTo(1, height - 1);
            ctx.closePath();
            ctx.fillStyle = sColor.toString();
            ctx.fill();
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isTriforce && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: triEmptySize
        height: triEmptySize
        radius: height / 2
        color: triEmptyColor
        opacity: (Plasmoid.configuration.triEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  CREEPER — cara pixelada / TNT / puntito
    // ═══════════════════════════════════════
    Canvas {
        id: creeper
        visible: isCreeper && isCurrent
        anchors.centerIn: parent
        width: creActiveSize
        height: creActiveSize
        property color skin: delegateRoot.creSkinColor
        property color face: delegateRoot.creFaceColor
        property var pixels: ["........", ".XX..XX.", ".XX..XX.", "...XX...", "..XXXX..", "..XXXX..", "..X..X..", "........"]
        onSkinChanged: requestPaint()
        onFaceChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var n = 8, cell = Math.floor(Math.min(width, height) / n);
            if (cell < 1) return;
            var ox = Math.round((width - cell * n) / 2), oy = Math.round((height - cell * n) / 2);
            ctx.fillStyle = skin.toString();
            ctx.fillRect(ox, oy, cell * n, cell * n);
            ctx.fillStyle = face.toString();
            for (var r = 0; r < n; r++) {
                var row = pixels[r];
                for (var c = 0; c < n; c++) {
                    if (row[c] === "X") ctx.fillRect(ox + c * cell, oy + r * cell, cell, cell);
                }
            }
        }
    }

    // Ocupado: bloque de TNT (rojo con banda blanca)
    Canvas {
        id: tnt
        visible: isCreeper && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: creOccupiedSize + 4
        height: creOccupiedSize + 4
        property color tntColor: delegateRoot.creTntColor
        property color band: delegateRoot.creBandColor
        onTntColorChanged: requestPaint()
        onBandChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height);
            if (S < 4) return;
            var ox = Math.round((width - S) / 2), oy = Math.round((height - S) / 2);
            ctx.fillStyle = tntColor.toString();
            ctx.fillRect(ox, oy, S, S);
            ctx.fillStyle = band.toString();
            var bh = Math.max(2, Math.round(S * 0.34));
            ctx.fillRect(ox, oy + Math.round((S - bh) / 2), S, bh);
            ctx.fillStyle = Qt.darker(tntColor, 1.8).toString();
            ctx.fillRect(ox, oy, S, 1);
            ctx.fillRect(ox, oy + S - 1, S, 1);
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isCreeper && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: creEmptySize
        height: creEmptySize
        radius: height / 2
        color: creEmptyColor
        opacity: (Plasmoid.configuration.creEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  HEARTS — corazón lleno / medio / puntito (pixel-art)
    // ═══════════════════════════════════════
    Canvas {
        id: fullHeart
        visible: isHearts && isCurrent
        anchors.centerIn: parent
        width: heaActiveSize
        height: heaActiveSize
        property color full: delegateRoot.heaFullColor
        property var pixels: [".XX...XX.", "XXXXXXXXX", "XXXXXXXXX", "XXXXXXXXX", ".XXXXXXX.", "..XXXXX..", "...XXX...", "....X....", "........."]
        onFullChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var n = 9, cell = Math.floor(Math.min(width, height) / n);
            if (cell < 1) return;
            var ox = Math.round((width - cell * n) / 2), oy = Math.round((height - cell * n) / 2);
            ctx.fillStyle = full.toString();
            for (var r = 0; r < n; r++) {
                var row = pixels[r];
                for (var c = 0; c < n; c++) {
                    if (row[c] === "X") ctx.fillRect(ox + c * cell, oy + r * cell, cell, cell);
                }
            }
        }
    }

    // Ocupado: medio corazón (base tenue + mitad morada)
    Canvas {
        id: halfHeart
        visible: isHearts && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: heaOccupiedSize + 6
        height: heaOccupiedSize + 6
        property color half: delegateRoot.heaHalfColor
        property color base: delegateRoot.heaEmptyColor
        property int baseOpacity: Plasmoid.configuration.heaBaseOpacity
        property var pixels: [".XX...XX.", "XXXXXXXXX", "XXXXXXXXX", "XXXXXXXXX", ".XXXXXXX.", "..XXXXX..", "...XXX...", "....X....", "........."]
        onHalfChanged: requestPaint()
        onBaseChanged: requestPaint()
        onBaseOpacityChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var n = 9, cell = Math.floor(Math.min(width, height) / n);
            if (cell < 1) return;
            var ox = Math.round((width - cell * n) / 2), oy = Math.round((height - cell * n) / 2);
            ctx.globalAlpha = (baseOpacity || 35) / 100;
            ctx.fillStyle = base.toString();
            for (var r = 0; r < n; r++) {
                var row = pixels[r];
                for (var c = 0; c < n; c++) {
                    if (row[c] === "X") ctx.fillRect(ox + c * cell, oy + r * cell, cell, cell);
                }
            }
            ctx.globalAlpha = 1.0;
            ctx.fillStyle = half.toString();
            for (var r2 = 0; r2 < n; r2++) {
                var row2 = pixels[r2];
                for (var c2 = 4; c2 < n; c2++) {
                    if (row2[c2] === "X") ctx.fillRect(ox + c2 * cell, oy + r2 * cell, cell, cell);
                }
            }
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isHearts && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: heaEmptySize
        height: heaEmptySize
        radius: height / 2
        color: heaEmptyColor
        opacity: (Plasmoid.configuration.heaEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  POKEBALL — pokébola / mini / puntito
    //  (la mini invierte los colores: bola morada, banda blanca)
    // ═══════════════════════════════════════
    Canvas {
        id: pokeball
        visible: isPokeball && isCurrent
        anchors.centerIn: parent
        width: pokActiveSize
        height: pokActiveSize
        property color ball: delegateRoot.pokBallColor
        property color band: delegateRoot.pokBandColor
        onBallChanged: requestPaint()
        onBandChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            delegateRoot.drawPokeball(ctx, Math.min(width, height), ball, band);
        }
    }

    Canvas {
        id: miniball
        visible: isPokeball && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: pokOccupiedSize + 4
        height: pokOccupiedSize + 4
        property color ball: delegateRoot.pokBandColor
        property color band: delegateRoot.pokBallColor
        onBallChanged: requestPaint()
        onBandChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            delegateRoot.drawPokeball(ctx, Math.min(width, height), ball, band);
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isPokeball && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: pokEmptySize
        height: pokEmptySize
        radius: height / 2
        color: pokEmptyColor
        opacity: (Plasmoid.configuration.pokEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  PIKACHU — cara / cola-rayo / puntito
    // ═══════════════════════════════════════
    Canvas {
        id: pikachu
        visible: isPikachu && isCurrent
        anchors.centerIn: parent
        width: pikActiveSize
        height: pikActiveSize
        property color face: delegateRoot.pikFaceColor
        property color detail: delegateRoot.pikDetailColor
        onFaceChanged: requestPaint()
        onDetailChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), k = S / 20, cx = width / 2;
            if (k <= 0) return;
            function tri(ax, ay, bx, by, tx, ty) {
                ctx.beginPath();
                ctx.moveTo(ax, ay); ctx.lineTo(bx, by); ctx.lineTo(tx, ty);
                ctx.closePath(); ctx.fill();
            }
            // Orejas blancas con punta morada
            ctx.fillStyle = face.toString();
            tri(cx - 6.2 * k, 9.2 * k, cx - 3.2 * k, 7.6 * k, cx - 7.8 * k, 1.2 * k);
            tri(cx + 6.2 * k, 9.2 * k, cx + 3.2 * k, 7.6 * k, cx + 7.8 * k, 1.2 * k);
            ctx.fillStyle = detail.toString();
            tri(cx - 6.0 * k, 5.6 * k, cx - 4.9 * k, 5.0 * k, cx - 7.8 * k, 1.2 * k);
            tri(cx + 6.0 * k, 5.6 * k, cx + 4.9 * k, 5.0 * k, cx + 7.8 * k, 1.2 * k);
            // Cabeza
            ctx.fillStyle = face.toString();
            ctx.beginPath();
            ctx.arc(cx, 12.8 * k, 6.8 * k, 0, Math.PI * 2, false);
            ctx.fill();
            // Ojos
            ctx.fillStyle = detail.toString();
            ctx.beginPath();
            ctx.arc(cx - 3 * k, 11.5 * k, 1.3 * k, 0, Math.PI * 2, false);
            ctx.arc(cx + 3 * k, 11.5 * k, 1.3 * k, 0, Math.PI * 2, false);
            ctx.fill();
            // Mejillas
            ctx.beginPath();
            ctx.arc(cx - 5.2 * k, 14.6 * k, 1.8 * k, 0, Math.PI * 2, false);
            ctx.arc(cx + 5.2 * k, 14.6 * k, 1.8 * k, 0, Math.PI * 2, false);
            ctx.fill();
            // Sonrisa
            ctx.beginPath();
            ctx.arc(cx, 13.0 * k, 1.6 * k, Math.PI * 0.2, Math.PI * 0.8, false);
            ctx.strokeStyle = detail.toString();
            ctx.lineWidth = Math.max(1, k);
            ctx.stroke();
        }
    }

    // Ocupado: cola en forma de rayo
    Canvas {
        id: tailbolt
        visible: isPikachu && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: pikOccupiedSize + 4
        height: pikOccupiedSize + 6
        property color bolt: delegateRoot.pikDetailColor
        onBoltChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var w = width - 2, h = height - 2, ox = 1, oy = 1;
            if (w <= 2 || h <= 2) return;
            ctx.beginPath();
            ctx.moveTo(ox + w * 0.58, oy);
            ctx.lineTo(ox + w * 0.22, oy + h * 0.56);
            ctx.lineTo(ox + w * 0.44, oy + h * 0.56);
            ctx.lineTo(ox + w * 0.34, oy + h);
            ctx.lineTo(ox + w * 0.78, oy + h * 0.40);
            ctx.lineTo(ox + w * 0.54, oy + h * 0.40);
            ctx.closePath();
            ctx.fillStyle = bolt.toString();
            ctx.fill();
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isPikachu && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: pikEmptySize
        height: pikEmptySize
        radius: height / 2
        color: pikEmptyColor
        opacity: (Plasmoid.configuration.pikEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  MARIO — estrella / bloque ? / puntito
    // ═══════════════════════════════════════
    Canvas {
        id: star
        visible: isMario && isCurrent
        anchors.centerIn: parent
        width: marActiveSize
        height: marActiveSize
        property color starColor: delegateRoot.marCapColor
        property color eyes: delegateRoot.marSpotColor
        onStarColorChanged: requestPaint()
        onEyesChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), cx = width / 2, cy = height / 2;
            var R = S / 2 - 0.5, r = R * 0.45;
            if (R <= 0) return;
            // Estrella de 5 puntas
            ctx.beginPath();
            for (var i = 0; i < 10; i++) {
                var rad = i % 2 === 0 ? R : r;
                var a = -Math.PI / 2 + i * Math.PI / 5;
                var px = cx + rad * Math.cos(a), py = cy + rad * Math.sin(a);
                if (i === 0) ctx.moveTo(px, py); else ctx.lineTo(px, py);
            }
            ctx.closePath();
            ctx.fillStyle = starColor.toString();
            ctx.fill();
            // Ojitos enojados del Starman
            ctx.fillStyle = eyes.toString();
            ctx.beginPath();
            ctx.arc(cx - R * 0.22, cy - R * 0.02, Math.max(0.9, R * 0.11), 0, Math.PI * 2, false);
            ctx.arc(cx + R * 0.22, cy - R * 0.02, Math.max(0.9, R * 0.11), 0, Math.PI * 2, false);
            ctx.fill();
        }
    }

    // Ocupado: bloque ? pixel-art con remaches y bisel
    Canvas {
        id: qblock
        visible: isMario && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: marOccupiedSize + 6
        height: marOccupiedSize + 6
        property color block: delegateRoot.marCoinColor
        property color glyph: delegateRoot.marCapColor
        property var pixels: [".XXX.", "X...X", "....X", "...X.", "..X..", ".....", "..X.."]
        onBlockChanged: requestPaint()
        onGlyphChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height);
            if (S < 6) return;
            var ox = Math.round((width - S) / 2), oy = Math.round((height - S) / 2);
            ctx.fillStyle = block.toString();
            ctx.fillRect(ox, oy, S, S);
            // Bisel
            ctx.fillStyle = Qt.lighter(block, 1.4).toString();
            ctx.fillRect(ox, oy, S, 1);
            ctx.fillRect(ox, oy, 1, S);
            ctx.fillStyle = Qt.darker(block, 1.6).toString();
            ctx.fillRect(ox, oy + S - 1, S, 1);
            ctx.fillRect(ox + S - 1, oy, 1, S);
            // Remaches
            ctx.fillStyle = Qt.darker(block, 1.9).toString();
            var rd = Math.max(1, Math.round(S * 0.07)), ri = Math.round(S * 0.12);
            ctx.fillRect(ox + ri, oy + ri, rd, rd);
            ctx.fillRect(ox + S - ri - rd, oy + ri, rd, rd);
            ctx.fillRect(ox + ri, oy + S - ri - rd, rd, rd);
            ctx.fillRect(ox + S - ri - rd, oy + S - ri - rd, rd, rd);
            // Glifo ?
            var gw = 5, gh = 7, cell = Math.floor(S * 0.62 / gw);
            if (cell < 1) return;
            var gx = Math.round(ox + (S - cell * gw) / 2), gy = Math.round(oy + (S - cell * gh) / 2);
            ctx.fillStyle = glyph.toString();
            for (var r = 0; r < gh; r++) {
                var row = pixels[r];
                for (var c = 0; c < gw; c++) {
                    if (row[c] === "X") ctx.fillRect(gx + c * cell, gy + r * cell, cell, cell);
                }
            }
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isMario && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: marEmptySize
        height: marEmptySize
        radius: height / 2
        color: marEmptyColor
        opacity: (Plasmoid.configuration.marEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  DRAGONBALL — esfera 4 estrellas / mini 1 estrella / puntito
    // ═══════════════════════════════════════
    Canvas {
        id: dragonball
        visible: isDragonball && isCurrent
        anchors.centerIn: parent
        width: draActiveSize
        height: draActiveSize
        property color ball: delegateRoot.draBallColor
        property color stars: delegateRoot.draStarColor
        onBallChanged: requestPaint()
        onStarsChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), cx = width / 2, cy = height / 2;
            var R = S / 2 - 0.5;
            if (R <= 0) return;
            ctx.beginPath();
            ctx.arc(cx, cy, R, 0, Math.PI * 2, false);
            ctx.fillStyle = ball.toString();
            ctx.fill();
            // 4 estrellas en rombo
            var pos = [[0, -0.45], [0.45, 0], [-0.45, 0], [0, 0.45]];
            ctx.fillStyle = stars.toString();
            for (var s = 0; s < 4; s++) {
                var sx = cx + pos[s][0] * R, sy = cy + pos[s][1] * R, sr = R * 0.24;
                ctx.beginPath();
                for (var i = 0; i < 10; i++) {
                    var rad = i % 2 === 0 ? sr : sr * 0.45;
                    var a = -Math.PI / 2 + i * Math.PI / 5;
                    var px = sx + rad * Math.cos(a), py = sy + rad * Math.sin(a);
                    if (i === 0) ctx.moveTo(px, py); else ctx.lineTo(px, py);
                }
                ctx.closePath();
                ctx.fill();
            }
        }
    }

    // Ocupado: mini esfera de 1 estrella (colores invertidos)
    Canvas {
        id: minidragon
        visible: isDragonball && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: draOccupiedSize + 4
        height: draOccupiedSize + 4
        property color ball: delegateRoot.draStarColor
        property color stars: delegateRoot.draBallColor
        onBallChanged: requestPaint()
        onStarsChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), cx = width / 2, cy = height / 2;
            var R = S / 2 - 0.5, sr = R * 0.42;
            if (R <= 0) return;
            ctx.beginPath();
            ctx.arc(cx, cy, R, 0, Math.PI * 2, false);
            ctx.fillStyle = ball.toString();
            ctx.fill();
            ctx.beginPath();
            for (var i = 0; i < 10; i++) {
                var rad = i % 2 === 0 ? sr : sr * 0.45;
                var a = -Math.PI / 2 + i * Math.PI / 5;
                var px = cx + rad * Math.cos(a), py = cy + rad * Math.sin(a);
                if (i === 0) ctx.moveTo(px, py); else ctx.lineTo(px, py);
            }
            ctx.closePath();
            ctx.fillStyle = stars.toString();
            ctx.fill();
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isDragonball && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: draEmptySize
        height: draEmptySize
        radius: height / 2
        color: draEmptyColor
        opacity: (Plasmoid.configuration.draEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  KIRBY — cara / mini / puntito
    // ═══════════════════════════════════════
    Canvas {
        id: kirby
        visible: isKirby && isCurrent
        anchors.centerIn: parent
        width: kirActiveSize
        height: kirActiveSize
        property color face: delegateRoot.kirFaceColor
        property color detail: delegateRoot.kirDetailColor
        onFaceChanged: requestPaint()
        onDetailChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), cx = width / 2, cy = height / 2;
            var R = S / 2 - 0.5;
            if (R <= 0) return;
            // Cara redonda
            ctx.beginPath();
            ctx.arc(cx, cy, R, 0, Math.PI * 2, false);
            ctx.fillStyle = face.toString();
            ctx.fill();
            // Ojos óvalos
            ctx.fillStyle = detail.toString();
            var ex = [-0.3, 0.3];
            for (var e = 0; e < 2; e++) {
                ctx.save();
                ctx.translate(cx + ex[e] * R, cy - 0.08 * R);
                ctx.scale(0.62, 1);
                ctx.beginPath();
                ctx.arc(0, 0, R * 0.2, 0, Math.PI * 2, false);
                ctx.fill();
                ctx.restore();
            }
            // Rubor
            ctx.beginPath();
            ctx.arc(cx - 0.55 * R, cy + 0.22 * R, R * 0.13, 0, Math.PI * 2, false);
            ctx.arc(cx + 0.55 * R, cy + 0.22 * R, R * 0.13, 0, Math.PI * 2, false);
            ctx.fill();
            // Boquita abierta
            ctx.beginPath();
            ctx.arc(cx, cy + 0.3 * R, R * 0.12, 0, Math.PI, false);
            ctx.closePath();
            ctx.fill();
        }
    }

    // Ocupado: mini Kirby (colores invertidos)
    Canvas {
        id: minikirby
        visible: isKirby && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: kirOccupiedSize + 4
        height: kirOccupiedSize + 4
        property color face: delegateRoot.kirDetailColor
        property color detail: delegateRoot.kirFaceColor
        onFaceChanged: requestPaint()
        onDetailChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), cx = width / 2, cy = height / 2;
            var R = S / 2 - 0.5;
            if (R <= 0) return;
            ctx.beginPath();
            ctx.arc(cx, cy, R, 0, Math.PI * 2, false);
            ctx.fillStyle = face.toString();
            ctx.fill();
            ctx.fillStyle = detail.toString();
            ctx.beginPath();
            ctx.arc(cx - R * 0.3, cy - R * 0.05, Math.max(0.8, R * 0.13), 0, Math.PI * 2, false);
            ctx.arc(cx + R * 0.3, cy - R * 0.05, Math.max(0.8, R * 0.13), 0, Math.PI * 2, false);
            ctx.fill();
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isKirby && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: kirEmptySize
        height: kirEmptySize
        radius: height / 2
        color: kirEmptyColor
        opacity: (Plasmoid.configuration.kirEmptyOpacity || 40) / 100
    }

    // ═══════════════════════════════════════
    //  KITTY — carita / huellita / puntito
    // ═══════════════════════════════════════
    // Activo: silueta de cara de gato dibujada (estilo Nerd Fonts)
    Canvas {
        id: catsil
        visible: isKitty && isCurrent
        anchors.centerIn: parent
        width: kitActiveSize
        height: kitActiveSize
        property color face: delegateRoot.kitFaceColor
        onFaceChanged: requestPaint()
        onWidthChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), k = S / 24, cx = width / 2;
            if (k <= 0) return;
            ctx.fillStyle = face.toString();
            // Orejas triangulares (base dentro de la cabeza para unir)
            ctx.beginPath();
            ctx.moveTo(cx - 8 * k, 10 * k);
            ctx.lineTo(cx - 2.8 * k, 7.5 * k);
            ctx.lineTo(cx - 6.5 * k, 1.5 * k);
            ctx.closePath();
            ctx.moveTo(cx + 8 * k, 10 * k);
            ctx.lineTo(cx + 2.8 * k, 7.5 * k);
            ctx.lineTo(cx + 6.5 * k, 1.5 * k);
            ctx.closePath();
            ctx.fill();
            // Cabeza redonda
            ctx.beginPath();
            ctx.arc(cx, 14.2 * k, 7.6 * k, 0, Math.PI * 2, false);
            ctx.fill();
        }
    }

    // Ocupado: huellita dibujada (almohadilla + 4 deditos)
    Canvas {
        id: pawdraw
        visible: isKitty && !isCurrent && hasWindows
        anchors.centerIn: parent
        width: kitOccupiedSize + 4
        height: kitOccupiedSize + 4
        property color paw: delegateRoot.kitPawColor
        onPawChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        Component.onCompleted: requestPaint()
        onVisibleChanged: if (visible) requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var S = Math.min(width, height), k = S / 24, cx = width / 2;
            if (k <= 0) return;
            ctx.fillStyle = paw.toString();
            function blob(bx, by, rx, ry) {
                ctx.save();
                ctx.translate(bx, by);
                ctx.scale(rx / ry, 1);
                ctx.beginPath();
                ctx.arc(0, 0, ry, 0, Math.PI * 2, false);
                ctx.fill();
                ctx.restore();
            }
            // 4 deditos ovalados
            blob(cx - 5.8 * k, 8.6 * k, 2 * k, 2.6 * k);
            blob(cx - 2.1 * k, 6.4 * k, 2 * k, 2.6 * k);
            blob(cx + 2.1 * k, 6.4 * k, 2 * k, 2.6 * k);
            blob(cx + 5.8 * k, 8.6 * k, 2 * k, 2.6 * k);
            // Almohadilla central
            blob(cx, 15 * k, 5.2 * k, 4.2 * k);
        }
    }

    // Vacío: puntito tenue
    Rectangle {
        visible: isKitty && !isCurrent && !hasWindows
        anchors.centerIn: parent
        width: kitEmptySize
        height: kitEmptySize
        radius: height / 2
        color: kitEmptyColor
        opacity: (Plasmoid.configuration.kitEmptyOpacity || 40) / 100
    }

    signal clicked()
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: delegateRoot.clicked()
    }
}
