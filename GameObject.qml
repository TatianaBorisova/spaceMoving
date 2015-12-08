import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

Item {
    id: root

    property int maxX: parent.width
    property int maxY: parent.height

    property int minX: 0
    property int minY: 0

    property int _minWidth: Screen.width/20
    property int _maxWidth: Screen.width/10

    property Player playerPtr

    property var parentObject1
    property var mapObject1

    property bool movingTimer: false

    signal dead()

    x: RandomGenerator.getRandValueInRange(minX, maxX)
    y: RandomGenerator.getRandValueInRange(minY, maxY)

    width: RandomGenerator.getRandValueInRange(_minWidth, _maxWidth)
    height: width

    //    MouseArea {
    //        anchors.fill: parent

    //        onClicked: {
    //            var gameObjCoordinates = parentObject1.mapToItem(mapObject1, mouseX, mouseY);
    //            console.log("root object coords x = " + gameObjCoordinates.x + " y = " + gameObjCoordinates.y)

    //            var gameObjCoordinates2 = parentObject1.mapToItem(mapObject1, root.x, root.y);
    //            console.log("game object coords x = " + root.x + " y = " + root .y)

    //            var gameObjCoordinates1 = parentObject1.mapToItem(mapObject1, playerPtr.x, playerPtr.y);
    //            console.log("player object coords x = " + gameObjCoordinates1.x + " y = " + gameObjCoordinates1.y)
    //        }
    //    }

    Timer {
        repeat: true
        interval: 100
        running: movingTimer

        onTriggered: {
            var playerCoordinates = parentObject1.mapToItem(mapObject1, playerPtr.x, playerPtr.y)

            checkCoords(playerCoordinates.x,
                        playerCoordinates.y,
                        playerPtr.width,
                        root.x,
                        root.y,
                        root.width)
        }
    }

    Image {
        property int pictureType: RandomGenerator.getRandValueInRange(-2, 3)

        anchors.fill: parent

        source: images(pictureType)
    }

    WorkerScript {
        id: myWorker

        property int touchCounter: 0

        source: "workerscript.js"

        onTouchCounterChanged:
        {
            if (touchCounter > 0) {
                if(!playerPtr.healthTimer.running)
                    playerPtr.healthTimer.start()
            }
            if (touchCounter > 8 && playerPtr.healthTimer.running) {
                console.log("almost dead")
                playerPtr.playerDead()
            }
        }

        onMessage: {
            if (messageObject.result)
                myWorker.touchCounter += messageObject.result
            else
                myWorker.touchCounter = 0
        }
    }

    function checkCoords(playerX, PlayerY, PlayerW, rootX, rootY, rootW)
    {
        myWorker.sendMessage( { '_meteorX':  playerX,
                                 '_meteorY': PlayerY,
                                 '_meteorW': PlayerW,
                                 '_coordX':  rootX,
                                 '_coordY':  rootY,
                                 '_coordW':  rootW
                             } )
    }

    function images(type)
    {
        switch(type)
        {
        case -2:
            return "res/meteor1.png"
        case -1:
            return "res/planet.png"
        case 0:
        case 1:
        default:
            return "res/hotplanet.png"
        }
    }
}
