import QtQuick
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami

Item {
    id: delegateRoot

    property bool isCurrent: false
    property bool hasWindows: false
    property int desktopIndex: 0
    property string desktopName: ""
    
    // View styling properties passed from PagerView
    property bool isPills: false
    property bool isBox: false
    property bool isLabels: false
    property bool useSysColors: true
    property color indicatorColor: "transparent"

    property real pillDotSize: 0
    property real pillLineSize: 0
    property real boxWidth: 0
    property real boxHeight: 0
    property real gridUnit: Kirigami.Units.gridUnit

    property color activeTextColor: "transparent"
    property color inactiveTextColor: "transparent"
    property int numberFormat: 0
    property bool showBgEff: true
    property bool showBorderEff: true
    
    property int animationDuration: 160

    function toRoman(num) {
        if (num < 1 || num > 3999) return String(num);
        var vals = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        var syms = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        var res = "";
        for (var i = 0; i < vals.length; i++) {
            while (num >= vals[i]) {
                res += syms[i];
                num -= vals[i];
            }
        }
        return res;
    }

    function toHiragana(num) {
        if (num < 1) return String(num);
        var ones = ["", "いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう"];
        if (num <= 10) {
            return num === 10 ? "じゅう" : ones[num];
        }
        if (num < 20) {
            return num === 10 ? "じゅう" : "じゅう" + ones[num - 10];
        }
        if (num < 100) {
            var ten = Math.floor(num / 10);
            var one = num % 10;
            var tenPart = ten === 1 ? "じゅう" : ones[ten] + "じゅう";
            return one === 0 ? tenPart : tenPart + ones[one];
        }
        return String(num);
    }

    function toKanji(num) {
        if (num < 1) return String(num);
        var digits = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九"];
        if (num <= 10) {
            return num === 10 ? "十" : digits[num];
        }
        if (num < 20) {
            return "十" + (num % 10 === 0 ? "" : digits[num - 10]);
        }
        if (num < 100) {
            var ten = Math.floor(num / 10);
            var one = num % 10;
            var tenPart = digits[ten] + "十";
            return one === 0 ? tenPart : tenPart + digits[one];
        }
        return String(num);
    }

    function toFullwidth(num) {
        var digits = ["０", "１", "２", "３", "４", "５", "６", "７", "８", "９"];
        var s = String(num);
        var res = "";
        for (var i = 0; i < s.length; i++) {
            var d = parseInt(s[i], 10);
            res += isNaN(d) ? s[i] : digits[d];
        }
        return res;
    }

    function toDice(num) {
        var faces = ["⚀", "⚁", "⚂", "⚃", "⚄", "⚅"];
        if (num >= 1 && num <= 6) return faces[num - 1];
        return String(num);
    }

    function formatDesktopNumber(idx) {
        var n = idx + 1;
        if (numberFormat === 1) return toRoman(n);
        if (numberFormat === 2) return toHiragana(n);
        if (numberFormat === 3) return toKanji(n);
        if (numberFormat === 4) return toFullwidth(n);
        if (numberFormat === 5) return toDice(n);
        return String(n);
    }

    width: {
        if (isPills) return isCurrent ? pillLineSize : pillDotSize;
        if (isLabels) return Math.max(labelText.implicitWidth + boxWidth * 2, boxWidth);
        // Numbers: solo texto, pegado al contenido
        var fSize = Plasmoid.configuration.numFontSize > 0 ? Plasmoid.configuration.numFontSize : Math.round(gridUnit * 0.65);
        return Math.max(10, formatDesktopNumber(desktopIndex).length * fSize * 0.9 + 6);
    }
    height: {
        if (isPills) return pillDotSize;
        if (isLabels) return Math.max(labelText.implicitHeight + boxHeight * 2, boxHeight);
        var fh = Plasmoid.configuration.numFontSize > 0 ? Plasmoid.configuration.numFontSize : Math.round(gridUnit * 0.65);
        return fh + 8;
    }

    Behavior on width {
        enabled: isPills
        NumberAnimation {
            duration: animationDuration
            easing.type: Easing.OutCubic
        }
    }

    // Pills styling
    Rectangle {
        visible: isPills
        anchors.centerIn: parent
        width: parent.width
        height: isCurrent ? pillDotSize * 0.6 : pillDotSize
        radius: height / 2
        
        color: isCurrent 
            ? (useSysColors ? Kirigami.Theme.highlightColor : Plasmoid.configuration.pillsActiveColor) 
            : (useSysColors ? Kirigami.Theme.textColor : Plasmoid.configuration.pillsInactiveColor)
        
        opacity: (isCurrent ? Plasmoid.configuration.pillsActiveOpacity : Plasmoid.configuration.pillsInactiveOpacity) / 100

        border.width: (!isCurrent && hasWindows && Plasmoid.configuration.showWindowIndicator) ? 3 : 0
        border.color: indicatorColor

        Behavior on height {
            NumberAnimation {
                duration: animationDuration
                easing.type: Easing.OutCubic
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: animationDuration
                easing.type: Easing.OutCubic
            }
        }
    }

    // Box/Labels styling — Numbers es solo texto, sin caja
    Rectangle {
        visible: isBox && isLabels
        anchors.fill: parent

        property real cornerRadiusRatio: Plasmoid.configuration.lblBoxRadius
        radius: Math.round(height * cornerRadiusRatio / 100)

        property string confActiveBg: Plasmoid.configuration.lblActiveBgColor
        property string confInactiveBg: Plasmoid.configuration.lblInactiveBgColor

        color: isCurrent
            ? (useSysColors ? Kirigami.Theme.highlightColor : confActiveBg)
            : (useSysColors ? "transparent" : confInactiveBg)

        opacity: (isCurrent ? Plasmoid.configuration.lblActiveOpacity
                            : Plasmoid.configuration.lblInactiveOpacity) / 100

        property bool showBorder: Plasmoid.configuration.lblShowBorder
        property int borderThickness: Plasmoid.configuration.lblBorderThickness
        property color confBorderColor: Plasmoid.configuration.lblBorderColor

        border {
            width: showBorder ? borderThickness : 0
            color: showBorder ? (useSysColors ? Kirigami.Theme.textColor : confBorderColor) : "transparent"
        }

        Text {
            id: labelText
            anchors.fill: parent
            anchors.margins: 2
            text: desktopName !== "" ? desktopName : formatDesktopNumber(desktopIndex)
            color: isCurrent ? activeTextColor : inactiveTextColor
            opacity: 1.0

            font.pixelSize: {
                var confSize = Plasmoid.configuration.lblFontSize;
                if (confSize > 0) return confSize;
                return Math.round(gridUnit * 0.65);
            }
            font.bold: isCurrent && Plasmoid.configuration.lblFontBold

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.FixedSize
        }
    }

    // Numbers: texto suelto sin fondo ni borde.
    // - Focus: color activo + bold (si está activado)
    // - Con ventanas: mismo color que el focus pero sin bold
    // - Inactivo sin ventanas: gris desaturado translúcido
    Text {
        id: numberText
        visible: isBox && !isLabels
        anchors.centerIn: parent
        text: formatDesktopNumber(desktopIndex)
        color: {
            if (isCurrent) return activeTextColor;
            if (hasWindows) return activeTextColor;
            return Qt.darker(inactiveTextColor, 2.6);
        }
        opacity: {
            if (isCurrent) return 1.0;
            if (hasWindows) return 0.85;
            return 0.35;
        }

        font.pixelSize: {
            if (Plasmoid.configuration.numFontSize > 0) return Plasmoid.configuration.numFontSize;
            return Math.round(gridUnit * 0.65);
        }
        font.bold: isCurrent && Plasmoid.configuration.numFontBold

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    // Window Indicator: solo en Labels (en Numbers el color ya indica ventanas)
    Rectangle {
        visible: isBox && isLabels && !isCurrent && hasWindows && Plasmoid.configuration.showWindowIndicator
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.5
        height: isLabels ? 4 : (parent.height > 16 ? 4 : 2)
        radius: height / 2
        color: indicatorColor
    }
    
    signal clicked()
    MouseArea {
        anchors.fill: parent
        anchors.margins: isPills ? -Kirigami.Units.smallSpacing : 0
        cursorShape: Qt.PointingHandCursor
        onClicked: delegateRoot.clicked()
    }
}
