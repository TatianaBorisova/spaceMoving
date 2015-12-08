#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include "QQmlContext.h"
#include "QtQml"

#include "randomgenerator.h"
#include <QObject>
#include <QQuickView>
#include <QQuickItem>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView *mainView = new QQuickView();

    QQmlContext *rootContext = mainView->rootContext();

    RandomGenerator *generator = new RandomGenerator();

    QObject::connect(generator, SIGNAL(closeApp()),
            mainView, SLOT(close()));

    rootContext->setContextProperty("RandomGenerator", generator);

    mainView->setSource(QUrl("qrc:/main.qml"));
    //    mainView->setWidth(800);
    //    mainView->setHeight(600);
    //  mainView->show();

    mainView->showFullScreen();

    return app.exec();
}
