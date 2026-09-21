import QtQuick 2.5

Item {
    id: bar
    width: 440
    height: 64

    // Настройки
    property int stage: 0
    property int stageCount: 6
    property color trackColor: "#c4c4c4"   // фон-дорожка полосы
    property color fillColor: "#2b2b2b"    // заливка прогресса
    property color glowColor: "#ffffff"    // блик, бегущий по полосе
    property string label: {
        if (stage <= 1) return "RRRAFF...";
        if (stage === 2) return "AUFCh...";
        if (stage === 3) return "Waff Wuff...";
        if (stage === 4) return "Waff Waff...";
        return "WAUFFF!!";
    }

    property real progress: stageCount > 0 ? Math.min(1, Math.max(0, stage / stageCount)) : 0

    Column {
        anchors.centerIn: parent
        spacing: 12

        // Полоса
        Rectangle {
            id: track
            width: bar.width
            height: 10
            radius: 5
            color: bar.trackColor
            clip: true

            // Заливка по прогрессу
            Rectangle {
                id: fill
                height: parent.height
                radius: 5
                color: bar.fillColor
                width: track.width * bar.progress
                Behavior on width { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
            }

            // Бегущий блик поверх
            Rectangle {
                id: shine
                width: 90
                height: parent.height
                radius: 5
                color: bar.glowColor
                opacity: 0.55
                x: -width
                SequentialAnimation on x {
                    loops: Animation.Infinite
                    NumberAnimation { from: -shine.width; to: track.width; duration: 1400; easing.type: Easing.InOutSine }
                    PauseAnimation { duration: 300 }
                }
                // Пульсация блика
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { from: 0.25; to: 0.6; duration: 700; easing.type: Easing.InOutSine }
                    NumberAnimation { from: 0.6; to: 0.25; duration: 700; easing.type: Easing.InOutSine }
                }
            }
        }

        // Подпись стадии
        Text {
            width: bar.width
            horizontalAlignment: Text.AlignHCenter
            text: bar.label
            color: "#360920"
            font.pixelSize: 20
            font.bold: true
        }
    }
}
