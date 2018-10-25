/*
 * Copyright 2011 Intel Corporation.
 * Copyright (C) 2017-2018 Chupligin Sergey <neochapay@gmail.com>
 *
 * This program is licensed under the terms and conditions of the
 * Apache License, version 2.0.  The full text of the Apache License is at
 * http://www.apache.org/licenses/LICENSE-2.0
 */

import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Page {
    id: welcomePage

    headerTools:  HeaderToolsLayout {
        id: hTools
        title: qsTr("Add email account")
        showBackButton: true
    }

    ListModel{
        id: accountsListModels
        ListElement{
            label: qsTr("Gmail")
            icon: "image://theme/google"
            preset: 2
            description: qsTr("Google mail");
        }
        ListElement{
            label:  qsTr("Microsoft Live Hotmail")
            icon: "image://theme/microsoft"
            preset: 5
            description: qsTr("Microsoft Live Hotmail");
        }
        ListElement{
            label:  qsTr("Yahoo!")
            icon: "image://theme/yahoo"
            preset: 3
            description: "";
        }
        ListElement{
            label:  qsTr("Other")
            icon: "image://theme/envelope-open"
            preset: 0
            description: qsTr("generic mail account")
        }
    }

    ListView {
        id: accountsList
        anchors.fill: parent
        model: accountsListModels
        delegate: ListViewItemWithActions {
            width: parent.width
            height: Theme.itemHeightLarge
            showNext: true
            label: model.label
            icon: model.icon
            description: model.description

            onClicked: {
                pageStack.push(Qt.resolvedUrl("RegisterScreen.qml"), {preset: 0})
            }
        }
    }

}
