TARGET = glacier-mail
TEMPLATE = app
QT += qml quick webengine network

CONFIG += link_pkgconfig

PKGCONFIG += glacierapp

LIBS += -lglacierapp

packagesExist(mlite) {
    PKGCONFIG += mlite
    DEFINES += HAS_MLITE
} else {
    warning("mlite not available. Some functionality may not work as expected.")
}

QML_FILES += qml/*.qml
QML_FILES += qml/settings/*.qml

qml.files = qml/*
qml.path = /usr/share/glacier-mail/qml
INSTALLS += qml

settings.files = qml/settings/*
settings.path = /usr/share/glacier-mail/qml/settings
INSTALLS += settings

icon.files = icon/glacier-mail.png
icon.path = /usr/share/glacier-mail

INSTALLS += icon

OTHER_FILES += $${QML_FILES}

SOURCES += \
    main.cpp

target.path = /usr/bin
INSTALLS += target

DISTFILES += \
    qml/settings/settings.js
