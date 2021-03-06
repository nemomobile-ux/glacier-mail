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
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 90
    anchors.rightMargin: 90
    property alias label: label.text
    property alias text: textentry.text
    property alias inputMethodHints: textentry.inputMethodHints
    property alias errorText: inlineNotification.text

    // BUG: setting echoMode appears to cause a spurious
    // textChanged signal, suppress is a workaround to
    // prevent clearing the password fields

    // private
    property bool suppress: true

//    signal textChanged()

    function setText(text) {
        suppress = true;
        textentry.text = text;
        suppress = false;
    }

    Text {
        id: label
        height: 30
        font.pixelSize: Theme.fontSizeLarge
        font.italic: true
        color: "grey"
    }

    TextField {
        id: textentry
        anchors.left: parent.left
        anchors.right: parent.right
        echoMode: TextInput.Password
        onTextChanged: {
            if (!suppress) {
                root.textChanged();
            }
        }
    }

    InlineNotification {
        id: inlineNotification
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
        visible: text.length > 0
    }
}
