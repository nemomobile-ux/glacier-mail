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

Page {
    id: container

    signal topicTriggered(int index)
    property alias currentTopic: listView.currentIndex
    property alias interactive: listView.interactive
    property alias model: listView.model

    headerTools:  HeaderToolsLayout {
        id: hTools
        title: qsTr("Mail")
        tools: [
            ToolButton{
                iconSource: "image://theme/refresh"
                active: emailAgent.synchronizing

                onClicked: {
                    if (window.refreshInProgress == true) {
                        emailAgent.cancelSync();
                        window.refreshInProgress = false;
                    } else {
                        emailAgent.accountsSyncInbox();
//                        emailAgent.accountsSyncAllFolders();
                        window.refreshInProgress = true;
                    }
                }
            },
            ToolButton{
                iconSource: "image://theme/plus"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("settings/WelcomeScreen.qml"))
                }
            }
        ]
    }

    Label {
        id: noAccountLabel
        text: qsTr("No accounts configured")
        visible: listView.count == 0
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
    }

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        model: mailAccountListModel

        onCurrentIndexChanged: container.topicTriggered(currentIndex)

        delegate: ListViewItemWithActions {
            id: accountItem

            Component.onCompleted: {
                if (index == 0) {
                    window.currentAccountDisplayName = displayName;
                    window.currentMailAccountId = mailAccountId;
                }
            }

            label: formatLabel()
            description:
                 (emailAgent.currentSynchronizingAccountId === mailAccountListModel.accountId(index)) ? qsTr("Synchronizing") :
                (model.lastSynchronized === 0) ? qsTr("Not synchronized") : model.lastSynchronized
            iconVisible: false

            function formatLabel() {

                if(unreadCount > 0) {
                    return qsTr("%1 (unread %2)").arg(emailAddress, unreadCount)
                }
                return emailAddress

            }

            onClicked: {
                listView.currentIndex = index;
                window.currentMailAccountId = mailAccountId;
                window.currentMailAccountIndex = index;
                window.currentAccountDisplayName = displayName;
                //messageListModel.setAccountKey (mailAccountId);
                //mailFolderListModel.setAccountKey(mailAccountId);
                window.folderListViewTitle = window.currentAccountDisplayName + " Inbox";
                window.currentFolderId = emailAgent.inboxFolderId(window.currentMailAccountId);
                window.currentFolderName = "Inbox";
                pageStack.push(Qt.resolvedUrl("FolderListView.qml"))
            }
        }
    }
}
