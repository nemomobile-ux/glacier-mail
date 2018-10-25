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

Column {
    property alias title: titleText.text
    property alias subtitle: subtitleText.text
    property alias children: column2.children
    anchors.left: parent.left
    anchors.right: parent.right

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        visible: titleText.text.length > 0
        Item { width: 1; height: 30; }
        Text {
            id: titleText
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            font.pixelSize: Theme.fontSizeLarge
            visible: text.length > 0
        }
        Item { width: 1; height: 10; }
        Text {
            id: subtitleText
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            font.pixelSize: Theme.fontSizeMedium
            wrapMode: Text.WordWrap
            visible: text.length > 0
        }
        Item { width: 1; height: 10; }
    }
    Rectangle {
        color: "transparent"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        height: column2.height
        Column {
            id: column2
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 20
        }
    }
}
