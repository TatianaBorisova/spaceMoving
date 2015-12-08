import QtQuick 2.0
import QtQuick.Window 2.2

Rectangle {
    id: root

    color: "#000029"

    property alias mapMovingTimer: time

    property Player player;

    property var parentObject
    property var mapObject

    property int playerVelocity: (player.keyPressed) ? 25 : 15

    property int modelCount: 150

    signal mapClose()

    Timer {
        id: time

        interval: 90

        repeat: true

        onTriggered: {
            //switch trigger state
            player.changeTrigger()

            //make rotation always positive
            if (player.rotation < 0)
                player.rotation = 360 + player.rotation

            //up
            if (player.rotation >= 350 ||
                    player.rotation <= 10)
                root.y += playerVelocity

            //up-right
            if (player.rotation > 10
                    && player.rotation <= 80) {
                root.y += playerVelocity
                root.x -= playerVelocity
            }

            //right
            if(player.rotation > 80
                    && player.rotation <= 100) {
                root.x -= playerVelocity
            }

            //right-down
            if(player.rotation > 100
                    && player.rotation < 170) {
                root.y -= playerVelocity
                root.x -= playerVelocity
            }

            //down
            if (player.rotation >= 170
                    && player.rotation <= 190) {
                root.y -= playerVelocity
            }

            //down-left
            if (player.rotation > 190
                    && player.rotation <= 260) {
                root.y -= playerVelocity
                root.x += playerVelocity
            }

            //left
            if (player.rotation > 260
                    && player.rotation <= 280) {
                root.x += playerVelocity
            }

            //left-up
            if (player.rotation > 280
                    && player.rotation < 350) {
                root.x += playerVelocity
                root.y += playerVelocity
            }
        }
    }

    Item {
        id: field

        anchors.fill: parent

        Repeater {
            id: rep
            model: modelCount
            delegate: GameObject {
                id: game
                parent: root

                playerPtr: player

                parentObject1: root.parentObject
                mapObject1: root.mapObject

                movingTimer: mapMovingTimer.running
            }
        }
    }

    Connections {
        target: player
        onPlayerDead: {
            console.log("signal dead was caught")
            mapClose()
        }
    }

    Component.onCompleted: refreshDataLoop();

    function refreshDataLoop()
    {
        var angle = 0;

        var spaceCentexX = root.width/2
        var spaceCenterY = root.height/2

        for (var i = 0; i < root.modelCount; i++) {
            angle = getAngle(i)
            var radiusX = (((root.width/2)/modelCount) * i) + rep.itemAt(i).width
            var radiusY = (((root.height/2)/modelCount) * i) + rep.itemAt(i).height

            if(i % 2) {
                rep.itemAt(i).x = spaceCentexX + Math.cos(angle)*radiusX
                rep.itemAt(i).y = spaceCenterY + Math.sin(angle)*radiusY
            } else {
                rep.itemAt(i).x = spaceCentexX - Math.cos(angle)*radiusX
                rep.itemAt(i).y = spaceCenterY - Math.sin(angle)*radiusY
            }

            console.log("x = " + rep.itemAt(i).x + " y = " + rep.itemAt(i).y)

            //            rep.itemAt(i).maxX = getMaxX(i, root.modelCount)
            //            rep.itemAt(i).minX = getMinX(i, root.modelCount)

            //            rep.itemAt(i).maxY = getMaxY(i, root.modelCount)
            //            rep.itemAt(i).minY = getMinY(i, root.modelCount)

            //            console.log("min x = " + rep.itemAt(i).minX + " min y = " + rep.itemAt(i).minY)
            //            console.log("max x = " + rep.itemAt(i).maxX + " max y = " + rep.itemAt(i).maxY)

            //            rep.itemAt(i).x = RandomGenerator.getRandValueInRange(rep.itemAt(i).minX, rep.itemAt(i).maxX)
            //            rep.itemAt(i).y = RandomGenerator.getRandValueInRange(rep.itemAt(i).minY, rep.itemAt(i).maxY)
        }
    }

    function getAngle(index)
    {
        return RandomGenerator.getRandValueInRange((360/index) * (index - 1), (360/index) * (index))
//        if (index <= modelCount/4) {
//            return RandomGenerator.getRandValueInRange(0, 90)
//        } else if (index > modelCount/4 && index <= modelCount/2) {
//            return RandomGenerator.getRandValueInRange(90, 180)
//        } else if (index > modelCount/2 && index <= (modelCount - modelCount/4)) {
//            return RandomGenerator.getRandValueInRange(180, 270)
//        } else {
//            return RandomGenerator.getRandValueInRange(270, 360)
//        }
    }

//    function getMaxX(index, modelCount)
//    {
//        var result = 0;

//        if (root.width > 0) {
//            if(index <= modelCount/4) {
//                result = root.width/4
//            } else if(index <= modelCount/2) {
//                result = root.width/2
//            } else if(index >= modelCount/2 && index <= (modelCount - modelCount/4)) {
//                result = root.width - (root.width/4)
//            }else {
//                result = root.width
//            }
//            console.log("getMaxX w = " + result)
//        } else {
//            console.log("getMaxX root w = " + root.width)
//            result = root.width
//        }
//        return result;
//    }

//    function getMinX(index, modelCount)
//    {
//        var result = 0;

//        if (root.width > 0) {
//            if(index <= modelCount/4) {
//                result = 0
//            } else if(index <= modelCount/2 && index >= modelCount/4) {
//                result = root.width/4
//            } else if(index >= modelCount/2
//                      && index <= (modelCount - modelCount/4)) {
//                result = root.width/2
//            } else {
//                result = root.width - (root.width/4)
//            }
//            console.log("getMinX w = " + result)
//        } else {
//            console.log("getMinX root w = " + root.width)
//            result = 0;
//        }
//        return result;
//    }

//    function getMaxY(index, modelCount)
//    {
//        var result = 0;

//        if (root.height > 0) {
//            if(index <= modelCount/4) {
//                result = (root.height/4)
//            } else if(index <= modelCount/2) {
//                result = root.height/2
//            } else if(index >= modelCount/2 && index <= (modelCount - modelCount/4)) {
//                result = root.height - (root.height/4)
//            }else {
//                result = root.height
//            }
//            console.log("getMaxY h = " + result)
//        } else {
//            console.log("getMaxY root h = " + root.height)
//            result = root.height
//        }
//        return result;
//    }

//    function getMinY(index, modelCount)
//    {
//        var result = 0;

//        if (root.height > 0) {
//            if(index <= modelCount/4) {
//                result = 0
//            } else if(index <= modelCount/2 && index >= modelCount/4) {
//                result = root.height/4
//            } else if(index >= modelCount/2 && index <= (modelCount - modelCount/4)) {
//                result = root.height/2
//            } else {
//                result = root.height - (root.height/4)
//            }
//            console.log("getMaxY h = " + result)
//        } else {
//            result = 0;
//            console.log("getMaxY root h = " + root.height)
//        }
//        return result;
//    }
}
