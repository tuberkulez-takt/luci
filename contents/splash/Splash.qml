import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
    id: root
    // фон менять тут бля
    color: "#543e4b"
    property int stage: 0
    property bool __fromTimer: false
    onStageChanged: {
        if (!__fromTimer) demoTimer.stop();
        __fromTimer = false;
    }
    Timer {
        id: demoTimer
        interval: 600
        running: true
        repeat: true
        onTriggered: {
            root.__fromTimer = true;
            if (root.stage < 6) root.stage++;
            else root.stage = 0;
        }
    }

    Item {
        id: content
        anchors.fill: parent

        // Список гифок - из него случайно выбирается одна при каждой загрузке
        property var gifList: [
            "images/luci_sleep.gif",
            "images/luci_hight.gif",
            "images/luci_drink.gif"
        ]
        // Случайный индекс: Math.random() * 3 -> 0, 1 или 2
        property string randomGif: gifList[Math.floor(Math.random() * gifList.length)]

        // Контейнер под гифку - центрируем
        Rectangle {
            // Размер гифки на экране. Подбери под свой монитор:
            // 500 - маленькая, 704 - средняя (как в CTOS), 900 - большая
            property int sizeAnim: 600

            id: imageSource
            width: sizeAnim
            height: sizeAnim
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            clip: true

            AnimatedImage {
                id: face
                // Случайная гифка выбирается один раз при старте заставки
                source: content.randomGif
                paused: false
                playing: true
                cache: false  // false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: imageSource.sizeAnim
                height: imageSource.sizeAnim
                fillMode: Image.PreserveAspectFit
                smooth: true
                visible: true
            }
        }

        // Отдельный компонент анимации загрузки
        LoadingBar {
            id: loader
            stage: root.stage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 48
        }
    }
}
