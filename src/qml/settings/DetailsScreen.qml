/*
 * Copyright 2011 Intel Corporation.
 * Copyright (C) 2021 Chupligin Sergey <neochapay@gmail.com>
 *
 * This program is licensed under the terms and conditions of the
 * Apache License, version 2.0.  The full text of the Apache License is at 	
 * http://www.apache.org/licenses/LICENSE-2.0
 */

import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import "settings.js" as Settings

import Nemo.Dialogs 1.0

Page {
    id: detailScreen
    property variant overlay: null
    property var emailAccount

    headerTools:  HeaderToolsLayout {
        id: hTools
        title: qsTr("Account Details")
        showBackButton: true
    }

    Flickable {
        id: detailFlick
        clip: true
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: buttonBar.top
        contentWidth: content.width
        contentHeight: content.height
        flickableDirection: Flickable.VerticalFlick
        Item {
            width: detailScreen.width
            Column {
                id: content
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 20
                spacing: 10
                Text {
                    font.weight: Font.Bold
                    text: qsTr("Account details")
                }
                Text {
                    text: qsTr("Account: %1").arg(emailAccount.description)
                }
                Text {
                    text: qsTr("Name: %1").arg(emailAccount.name)
                }
                Text {
                    text: qsTr("Email address: %1").arg(emailAccount.address)
                }
                Item {
                    width: 1
                    height: 20
                }
                Text {
                    text: qsTr("Receiving:")
                }
                Text {
                    text: qsTr("Server type: %1").arg(Settings.serviceName(emailAccount.recvType))
                }
                Text {
                    text: qsTr("Server address: %1").arg(emailAccount.recvServer)
                }
                Text {
                    text: qsTr("Port: %1").arg(emailAccount.recvPort)
                }
                Text {
                    text: qsTr("Security: %1").arg(Settings.encryptionName(emailAccount.recvSecurity))
                }
                Text {
                    text: qsTr("Username: %1").arg(emailAccount.recvUsername)
                }
                Item {
                    width: 1
                    height: 20
                }
                Text {
                    text: qsTr("Sending:")
                }
                Text {
                    text: qsTr("Server address: %1").arg(emailAccount.sendServer)
                }
                Text {
                    text: qsTr("Port: %1").arg(emailAccount.sendPort)
                }
                Text {
                    text: qsTr("Authentication: %1").arg(Settings.authenticationName(emailAccount.sendAuth))
                }
                Text {
                    text: qsTr("Security: %1").arg(Settings.encryptionName(emailAccount.sendSecurity))
                }
                Text {
                    text: qsTr("Username: %1").arg(emailAccount.sendUsername)
                }
            }
        }

        Component.onCompleted: {
/*            contentY = detailsSaveRestoreState.restoreRequired ?
                        detailsSaveRestoreState.value("email-details-detailFlick-contentY") : 0;*/
        }
    }
    QueryDialog {
        id: verifyCancel
        acceptText: qsTr ("Yes")
        cancelText: qsTr ("No")
        headingText: qsTr ("Discard changes")
        subLabelText: qsTr ("You have made changes to your settings. Are you sure you want to cancel?")
        onAccepted: { settingsPage.state = settingsPage.getHomescreen() }
    }

    Dialog {
        id: errorDialog
        acceptText: qsTr("OK")
        headingText: qsTr("Error")
        subLabelText: qsTr("Error %1: %2").arg(emailAccount.errorCode).arg(emailAccount.errorMessage)
        onAccepted: {
            pageStack.pop(0)
            //loader.item.message = qsTr("Sorry, we can't automatically set up your account. Please fill in account details:");
        }
    }

    // spinner overlay
    Spinner {
        id: spinner
        anchors.centerIn: parent
        visible: false
    }

    //FIXME use standard action bar here
    Rectangle {
        id: buttonBar
        anchors.bottom: parent.bottom
        width: parent.width
        height: 70
        color: "grey"
        Button {
            id: next
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: 45
            anchors.margins: 10
            //color: "white"
            text: qsTr("Next")
            onClicked: {
                emailAccount.save();
                emailAccount.test();
                spinner.start();
            }
            Connections {
                target: emailAccount
                onTestSucceeded: {
                    spinner.stop();
                    settingsPage.state = "ConfirmScreen";
                }
                onTestFailed: {
                    spinner.stop();
                    errorDialog.show();
                    emailAccount.remove();
                }
            }
        }
        Button {
            anchors.left: next.right
            anchors.verticalCenter: parent.verticalCenter
            height: 45
            anchors.margins: 10
            //color: "white"
            text: qsTr("Manual Edit")
            onClicked: {
                settingsPage.state = "ManualScreen";
                loader.item.message = qsTr("Please fill in account details:");
            }
        }
        Button {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: 45
            anchors.margins: 10
            //color: "white"
            text: qsTr("Cancel")
            onClicked: {
                verifyCancel.open();
            }
        }
    }

/*    SaveRestoreState {
        id: detailsSaveRestoreState
        onSaveRequired: {
            setValue("email-details-detailFlick-contentY",detailFlick.contentY);
            setValue("email-details-verifyCancel-visible",verifyCancel.visible);
            setValue("email-details-errorDialog-visible",errorDialog.visible);
            sync();
        }
    }*/

    Component.onCompleted: {
        /*if(detailsSaveRestoreState.restoreRequired) {
            if(detailsSaveRestoreState.value("email-details-verifyCancel-visible") == "true") {
                verifyCancel.open();
            } else if(detailsSaveRestoreState.value("email-details-errorDialog-visible") == "true") {
                errorDialog.show();
            }
        }*/
    }
}
