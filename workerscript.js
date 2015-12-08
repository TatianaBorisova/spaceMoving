WorkerScript.onMessage = function(message) {

    if (((message._meteorX >= message._coordX)
         && ((message._coordX + message._coordW) >= message._meteorX + message._meteorW))
            && ((message._meteorY >= message._coordY)
                && ((message._coordY + message._coordW) >= message._meteorY + message._meteorW)))
    {
        console.log("player x = " + message._meteorX
                    //                        + " game x = " + message._coordX
                    //                        + " game W1 = " + message._coordW
                    + " player W = " + message._meteorW
                    + " player w + x " + (message._meteorX + message._meteorW)
                    /*   + " game w  + x " + (message._coordX + message._coordW)*/)
        //            if (i > message._coordW)
        //                return;

        WorkerScript.sendMessage({'result': 1})
    } else
        WorkerScript.sendMessage({'result': 0})
}
