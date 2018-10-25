/*
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

Column {
    id: root
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: 90
    anchors.rightMargin: 90
    property alias label: label.text
    property alias model: dropdown.model
    property string title
    property string selectedTitle
    property string selectedIndex

    signal triggered (int index)
    Text {
        id: label
        height: 30
        font.pixelSize: theme.fontPixelSizeLarge
        font.italic: true
        color: "grey"
    }
    GlacierRoller {
        id: dropdown
        width: 400
    }
}
