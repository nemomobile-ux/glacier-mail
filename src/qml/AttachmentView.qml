/* Copyright (C) 2018-2021 Chupligin Sergey <neochapay@gmail.com>
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

import Nemo.Email 0.1

Flickable {
    id: container

    property int topicHeight: 39
    signal attachmentSelected(string uri, int mX, int mY, int mIndex);

    //property alias currentTopic: attachmentListView.currentIndex
    property alias model: repeater.model

    contentWidth: row.width
    contentHeight: row.height
    flickableDirection: Flickable.HorizontalFlick
    interactive: contentWidth > width
    clip: true

    Row {
        id: row

        spacing: 10

        Repeater {
            id: repeater

            AttachmentPill {
                uri: modelData
                parent: container

                onLongPress: {
                   container.attachmentSelected (uri, mX, mY, mIndex);
                }
            }
        }
    }
}
