import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Item {
    id: root

    property bool keyPressed: false

    property int healthRepairing: 0
    property int waitForRepearing: 0

    property alias healthTimer: repearing

    property var parentObject
    property var mapObject

    signal changeTrigger();
    signal playerDead();

    width: 50
    height: 100

    Image {
        id: mainPictiure

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: 50
        height: 50

        source: keyPressed ? "res/spaceRocket_moving.png" : "res/spaceRocket.png"

        Rectangle
        {
            id: warningColor

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: parent.height * 0.12

            width: parent.width * 0.45
            height: parent.height * 0.7

            radius: 100

            opacity: 0.4

            color: "red"

            visible: false
        }

    }

    Image {
        id: turbo

        anchors.top: mainPictiure.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: 50
        height: 50

        source: "res/fire.png"

        Timer {
            id: tirboFire

            interval: 150
            running: true
            repeat: true

            onTriggered:
            {
                turbo.visible = !turbo.visible
            }
        }
    }

    Timer {
        id: repearing

        interval: 500

        repeat: true

        onTriggered:
        {
            warningColor.visible = !warningColor.visible

            healthRepairing++

            if (healthRepairing > 10)
            {
                repearing.stop()
                healthRepairing = 0
                warningColor.visible = false
            }
        }
    }
}
