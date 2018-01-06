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

Dialog {
    title: qsTr("Error")

    content: Item {
        anchors.fill: parent
        anchors.margins: 10
        Text {
            text: window.errMsg;
            anchors.fill: parent
            color: "white"
            wrapMode: Text.Wrap
        }
    }
}

