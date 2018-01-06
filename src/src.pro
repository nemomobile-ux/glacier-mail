TARGET = glacier-mail
TEMPLATE = app
QT += qml quick webkit network

CONFIG += link_pkgconfig

PKGCONFIG += glacierapp

LIBS += -lglacierapp

packagesExist(mlite) {
    PKGCONFIG += mlite
    DEFINES += HAS_MLITE
} else {
    warning("mlite not available. Some functionality may not work as expected.")
}

QML_FILES = qml/*.qml


qml.files = qml/*
qml.path = /usr/share/glacier-mail/qml
INSTALLS += qml

OTHER_FILES += $${QML_FILES}

SOURCES += \
    main.cpp

target.path = /usr/bin
INSTALLS += target
