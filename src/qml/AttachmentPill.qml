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


Item {
    id: pill

    property string uri: ""
    property string name: "test"
    property int mX: 0
    property int mY: 0

    signal longPress (string uri, int mouseX, int mouseY, int mIndex);

    width: parent.width
    height: Theme.itemHeightSmall

    onUriChanged: {
        name = uri.slice (uri.lastIndexOf ('/') + 1);
    }

    Image {
        id: leftImage
        anchors{
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        source: "image://theme/file-o"
        height: parent.height*0.8
        width: height
    }

    Label {
        id: text
        anchors{
            left: leftImage.right
            leftMargin: Theme.itemSpacingSmall
            verticalCenter: parent.verticalCenter
        }
        text: name
    }

    MouseArea {
        anchors.fill: parent

/*        onPressAndHold: {
            var map = mapToItem(topItem.topItem , mouseX, mouseY);
            mX = map.x;
            mY = map.y;
            pill.longPress (uri, mX, mY, index);
        }*/
    }
}

