#include "randomgenerator.h"

#include <QGuiApplication>
#include <QScreen>
#include <QTime>
#include <QThread>
#include <QDebug>
#include <QDesktopServices>

RandomGenerator::RandomGenerator(QObject *parent)
    :QObject(parent)
    ,m_value(0)
{
}

int RandomGenerator::getRandValue()
{
    QTime midnight(0,0,0);
    qsrand(midnight.msecsTo(QTime::currentTime()));
    return qrand();
}

int RandomGenerator::getRandValueInRange(int min, int max)
{
   // qDebug() << "getRandValueInRange" << min << max;
    QTime midnight(0,0,0);

    //    QThread::sleep(1);

    qsrand(midnight.msecsTo(QTime::currentTime()));

    if (max)
        return min + qrand() % max;
    else
        return 0;
}
