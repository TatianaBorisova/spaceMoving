#ifndef RANDOMGENERATOR_H
#define RANDOMGENERATOR_H

#include <QObject>

class RandomGenerator : public QObject
{
    Q_OBJECT
public:
    RandomGenerator(QObject *parent = 0);
    ~RandomGenerator(){}

    Q_INVOKABLE int getRandValue();
    Q_INVOKABLE int getRandValueInRange(int min, int max);

signals:
    Q_INVOKABLE void upPressed();
    Q_INVOKABLE void upReleased();
    Q_INVOKABLE void closeApp();

private:
    long long m_value;
};

#endif // RANDOMGENERATOR_H
