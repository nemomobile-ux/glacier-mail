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

SelectionDialog {
    id: selectFolderDialog
    model: mailFolderListModel

    delegate: MouseArea {
        id: folderItem
        height: 50
        width: parent.width

        Label {
            id: folderLabel
            height: 50
            text: folderName + (folderUnreadCount ? (" (" + folderUnreadCount +")") : "")
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: 15
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        onClicked: {
            window.currentFolderId = folderId;
            window.currentFolderName = folderName;
            window.folderListViewTitle = currentAccountDisplayName + " " + folderName;
            messageListModel.setFolderKey(folderId);
            reject()
        }
    }
}

