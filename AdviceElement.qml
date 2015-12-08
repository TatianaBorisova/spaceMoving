import QtQuick 2.0

Rectangle {
    width: 100
    height: 100

    color: "transparent"

    border.width: 1
    border.color: "yellow"

    Column {
        anchors.centerIn: parent

        width: parent.width * 0.6
        height: parent.height * 0.9

        spacing: 5

        Text {
            text: qsTr("For moving\nuse arrows.\n\nFor turns:")

            color: "lightblue"
        }

        Text {
            text: qsTr("Shift <-")

            color: "lightblue"
        }

        Text {
            wrapMode : Text.WordWrap

            text: qsTr("Shift ->")

            color: "lightblue"
        }
    }
}

