/* Copyright (C) 2018 Chupligin Sergey <neochapay@gmail.com>
 * Copyright 2011 Intel Corporation.
 *
 * This program is licensed under the terms and conditions of the
 * Apache License, version 2.0.  The full text of the Apache License is at 	
 * http://www.apache.org/licenses/LICENSE-2.0
 */

import QtQuick 2.6

import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

BorderImage {
    id: addAttachmentToolbar

    width: parent.width
    height: addAttachmentButton.height
    verticalTileMode: BorderImage.Stretch
    source: "image://theme/navigationBar_l"

    signal okay

    ToolbarButton {
        id: addAttachmentButton
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        width: 90
        iconName: "mail-compose"
        onClicked: {
            addAttachmentToolbar.okay ();
        }
    }

    ToolbarDivider {
        id: division1
        anchors.left: addAttachmentButton.right
        height: parent.height
    }

    ToolbarDivider {
        id: division3
        anchors.right: cancelButton.left
        anchors.rightMargin: 10
        height: parent.height
    }

    ToolbarButton {
        id: cancelButton

        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        width: 90
        height: parent.height

        iconName: "mail-editlist-cancel"

        onClicked: {
            window.popPage ();
        }
    }
}

