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

QueryDialog {
    property string uri

    // TODO: are all these required?
    // @todo Remove if these are no longer relevant.
    property string progressBarText: ""
    property bool progressBarVisible: false
    property real progressBarPercentage: 0
    property bool downloadInProgress: false
    property string attachmentSavedLabel: qsTr("Attachment saved.")
    property string downloadingAttachmentLabel: qsTr("Downloading Attachment...")
    property string downloadingContentLabel: qsTr("Downloading Content...")

    //: Message displayed when downloading an attachment.  Arg 1 is the name of the attachment.
    property string savingAttachmentLabel: qsTr("Saving %1")

    //: Attachment has been saved message, where arg 1 is the name of the attachment.
    property string attachmentHasBeenSavedLabel: qsTr("%1 saved")


    // TODO: use a Loader
    Dialog {
        id: unsupportedFileFormat
        title: qsTr ("Warning")
        content: Text {
            text: qsTr("File format is not supported.");
            wrapMode: Text.Wrap
        }

        onAccepted: {}
    } 

    id: attachmentContextMenu
    titleText: qsTr("Download?")
    message: qsTr("Do you want to download %1").arg(uri)
    onAccepted: {
        emailAgent.downloadAttachment(messageListModel.messageId(window.currentMessageIndex), uri);
    }
    Connections {
        target: emailAgent
        onAttachmentDownloadStarted: {
            downloadInProgress = true;
            progressBarText = downloadingAttachmentLabel;
            progressBarVisible = true;
        }

        onProgressUpdate: {
            progressBarPercentage = percent;
        }

        onAttachmentDownloadCompleted: {
            progressBarVisible = false;
            downloadInProgress = false;
           var status = emailAgent.openAttachment(uri);
           if (status == false) {
               unsupportedFileFormat.show();
           }
        }
    }
}  // end of attachmentContextMenu

