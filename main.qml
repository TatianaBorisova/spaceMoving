import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Item {
    id: root

    property int globalMapScale: 10
    property int rotationAngle: 5

    property int finish: 0

    x: 0
    y: 0

    width: Screen.width * globalMapScale
    height: Screen.height * globalMapScale

    /////////////////////////
    Connections {
        target: flick
        onMapClose: {
            loseText.visible = true
        }
    }

    /////////////////////////
    Player {
        id: playerm

        x: Screen.width/2
        y: Screen.height/2
        z: 10

        mapObject: flick
        parentObject: root
    }

    /////////////////////////
    Text {
        id: loseText

        anchors.top: playerm.bottom
        anchors.left: playerm.left

        z: 100

        wrapMode : Text.WordWrap

        font.pointSize: 48
        text: qsTr("Too much crashes!\nGame over.")

        color: "Red"

        visible: false

        Timer {
            repeat: true
            interval: 2000
            running: loseText.visible

            onTriggered: {
                finish++
                if (finish == 4)
                    RandomGenerator.closeApp()
            }
        }
    }

    AdviceElement {
        id: adv
        property int hideText: 0

        x: 0 //Screen.width - adv.width
        y: 0

        z: 100

        Timer {
            repeat: true
            interval: 60000
            running: true

            onTriggered: {
                hideText++
                if (hideText == 2)
                    adv.visible = false
            }
        }
    }

    /////////////////////////
    MapField {
        id: flick

        x: -(root.width/4)
        y: -(root.height/4)

        width: root.width
        height: root.height

        focus: true

        player: playerm

        mapObject: flick
        parentObject: root

        Keys.onPressed: {
            if (event.key === Qt.Key_Up)
            {
                playerm.keyPressed = true

                if (!flick.mapMovingTimer.running)
                    flick.mapMovingTimer.start()
            }

            if(event.key === Qt.Key_Left && (event.modifiers & Qt.ShiftModifier)) {
                playerm.rotation = playerm.rotation - rotationAngle
                if (playerm.rotation < -360)
                    playerm.rotation = 0

            } else if (event.key === Qt.Key_Left)
            {
                if (!flick.mapMovingTimer.running)
                    flick.mapMovingTimer.start()

                playerm.keyPressed = true
            }

            if (event.key === Qt.Key_Down)
            {
                if (!flick.mapMovingTimer.running)
                    flick.mapMovingTimer.start()

                playerm.keyPressed = true
            }

            if(event.key === Qt.Key_Right && (event.modifiers & Qt.ShiftModifier)) {
                playerm.rotation = playerm.rotation + rotationAngle
                if (Math.abs(playerm.rotation) > 360)
                    playerm.rotation = 0

            } else if (event.key === Qt.Key_Right)
            {
                if (!flick.mapMovingTimer.running)
                    flick.mapMovingTimer.start()

                playerm.keyPressed = true
            }
            event.accepted = true;
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Up
                    || event.key === Qt.Key_Right
                    || event.key === Qt.Key_Down
                    || event.key === Qt.Key_Left)
            {
                if(!event.isAutoRepeat) {
                    event.accepted = true;

                    // can stop ship after button releasing
                    //                    if (flick.mapMovingTimer.running)
                    //                        flick.mapMovingTimer.stop()

                    playerm.keyPressed = false
                }
            }
        }
    }
}
