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
    id: folderListContainer

    headerTools:  HeaderToolsLayout {
        id: hTools
        title: currentAccountDisplayName + " " + currentFolderName
        showBackButton: true

        tools: [
            ToolButton{
                iconSource: "image://theme/refresh"
                onClicked: {
                    // TODO: a spinner in the PageHeader would be neat
                    if (window.refreshInProgress == true) {
                        emailAgent.cancelSync();
                        window.refreshInProgress = false;
                    } else {
                        emailAgent.synchronize(window.currentMailAccountId);
                        window.refreshInProgress = true;
                    }
                }
            },
            ToolButton{
                iconSource: "image://theme/plus"
                onClicked: {
                    mailAttachmentModel.clear();
                    window.composeInTextMode = true;
                    pageStack.push(Qt.resolvedUrl("ComposerSheet.qml"))
                }
            }

        ]
    }

    Component.onCompleted: {
        //mailFolderListModel.setAccountKey (currentMailAccountId);
        window.currentFolderId = emailAgent.inboxFolderId(currentMailAccountId);
        //window.folderListViewTitle = currentAccountDisplayName + " Inbox";
        folderServerCount = mailFolderListModel.folderServerCount(window.currentFolderId);
        gettingMoreMessages = false;
    }

    property int dateSortKey: 1
    property int senderSortKey: 1
    property int subjectSortKey: 1
    property string chooseFolder: qsTr("Choose folder:")
    property string attachments: qsTr("Attachments")
    property bool gettingMoreMessages: false
    property bool inSelectMode: false
    property int numOfSelectedMessages: 0
    property int folderServerCount: 0

    ListModel {
        id: toModel
    }

    ListModel {
        id: ccModel
    }

    ListModel {
        id: attachmentsModel
    }

    function isDraftFolder()
    {
        return false;
        //        return folderListView.pageTitle.indexOf( qsTr("Drafts") ) != -1 ;
    }

    /*PageHeader {
        MouseArea {
            anchors.fill: parent
            onClicked: {
                pageStack.openDialog(Qt.resolvedUrl("FolderSelectionDialog.qml"))
            }
        }
    }*/

    Label {
        text: qsTr("No messages in this folder")
        visible: messageListView.count == 0 && !emailAgent.synchronizing
        anchors.centerIn: parent
    }

    ListView {
        id: messageListView
        anchors.fill: parent
        clip: true
        cacheBuffer: height
        model: messageListModel

        visible: !emailAgent.synchronizing

        footer: Item {
            id: getMoreMessageRect
            height: 90
            width: messageListView.width
            visible: messageListView.count < folderServerCount

            Button {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                height: 45
                width: 300
                text: {
                    if(gettingMoreMessages)
                        return  qsTr("Getting more messages")
                    else
                        return  qsTr("Get more messages")
                }
                onClicked: {
                    gettingMoreMessages = true;
                    emailAgent.getMoreMessages(window.currentFolderId);
                }
            }
        }

        delegate: ListViewItemWithActions {
            id: dinstance
            icon: readStatus ? "image://theme/envelope-open-o" : "image://theme/envelope-o"
            label: senderDisplayName != "" ? senderDisplayName : senderEmailAddress
            description:  subject

            Image{
                id: attachIcon
                visible: numberOfAttachments
                source: "image://theme/paperclip"
                height: parent.height/3
                width: height
                anchors{
                    left: parent.left
                    leftMargin: height/2
                    top: parent.top
                }
            }

            onClicked: {
                if (inSelectMode)
                {
                    if (selected)
                    {
                        messageListModel.deSelectMessage(index);
                        --folderListContainer.numOfSelectedMessages;
                    }
                    else
                    {
                        messageListModel.selectMessage(index);
                        ++folderListContainer.numOfSelectedMessages;
                    }
                }
                else
                {
                    window.mailId = messageId;
                    window.mailSubject = subject;
                    window.mailSender = sender;
                    window.mailTimeStamp = timeStamp;
                    window.mailBody = body;
                    window.mailQuotedBody = quotedBody;
                    window.mailHtmlBody = htmlBody;
                    window.mailAttachments = listOfAttachments;
                    window.numberOfMailAttachments = numberOfAttachments;
                    window.mailRecipients = recipients;
                    toListModel.init();
                    window.mailCc = cc;
                    ccListModel.init();
                    window.mailBcc = bcc;
                    bccListModel.init();
                    window.currentMessageIndex = index;
                    mailAttachmentModel.init();
                    emailAgent.markMessageAsRead (messageId);
                    window.mailReadFlag = true;

                    if ( isDraftFolder() )
                    {   window.editableDraft= true
                        window.addPage(composer);
                    }
                    else
                        pageStack.push(Qt.resolvedUrl("ReadingView.qml"))

                }
            }
            /*onPressAndHold: {
                if (inSelectMode)
                    return;
                window.mailId = messageId;
                window.mailReadFlag = readStatus;
                window.currentMessageIndex = index;
                pageStack.openDialog(Qt.resolvedUrl("MessageContextMenu.qml"))
            }*/
        }

        ScrollDecorator {
            flickable: parent
        }
    }

    Spinner{
        id: syncSpiner
        visible: emailAgent.synchronizing
        anchors.centerIn: parent
    }
}
