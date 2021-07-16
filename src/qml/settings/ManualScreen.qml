/*
 * Copyright 2011 Intel Corporation.
 * Copyright (C) 2018-2021 Chupligin Sergey <neochapay@gmail.com>
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

Page {
    id: manualSettingsPage
    property string message

    property var emailAccount

    headerTools:  HeaderToolsLayout {
        id: hTools
        title: qsTr("Receiving settings")
        showBackButton: true
    }

    Component.onCompleted: {
        autoCompliteTable();
    }

    function autoCompliteTable() {
        var userName = emailAccount.address.split("@")[0];
        var serverName = emailAccount.address.split("@")[1];
// PORT FIELD
        if(recvPortField.text == "") {
            if(serverType.currentIndex == 0) {
                //POP
                recvPortField.text = 995
            } else {
                recvPortField.text = 993
            }
        }
//SERVER NAME
        if(recvServerField.text == "") {
            if(serverType.currentIndex) {
                recvServerField.text = "pop."+serverName;
            } else {
                recvServerField.text = "imap."+serverName;
            }
        }
//USER NAME
        if(recvUsernameField.text == "") {
            recvUsernameField.text = userName
        }
//USER PASSWORD
        if(recvPasswordField.text == "") {
            recvPasswordField.text = emailAccount.password
        }

//SEND SERVER
        if(sendServerField.text == "") {
            sendServerField.text = "smtp."+serverName
        }
//SEND USER
        if(sendUsernameField.text == "") {
            sendUsernameField.text = userName
        }
//SEND PASSWORD
        if(sendPasswordField.text == "") {
            sendPasswordField.text = emailAccount.password
        }
    }

    ScrollDecorator{
        id: decorator
        flickable: manualFlick
    }

    Flickable {
        id: manualFlick
        clip: true

        width: parent.width
        height: parent.height-buttonBar.height

        flickableDirection: Flickable.VerticalFlick
        contentHeight: settingsColumn.height

        Column {
            id: settingsColumn
            width: parent.width
            spacing: Theme.itemSpacingMedium

            Label{
                text: qsTr("Server settings")
            }

            GlacierRoller {
                id: serverType
                label: qsTr("Server type")
                width: parent.width - Theme.itemSpacingMedium*2
                model: Settings.serviceModel
                currentIndex: 0 //emailAccount.recvType
                onSelect: emailAccount.recvType = index
                delegate: GlacierRollerItem{
                    Text{
                        height: Theme.itemHeightMedium
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                        color: Theme.textColor
                        font.pixelSize: Theme.fontSizeMedium
                        font.bold: (serverType.activated && serverType.currentIndex === index)
                    }
                }
            }

            TextField {
                id: recvServerField
                placeholderText: qsTr("Server address")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.recvServer
                inputMethodHints: Qt.ImhNoAutoUppercase
                onTextChanged: emailAccount.recvServer = text
            }
            TextField {
                id: recvPortField
                placeholderText: qsTr("Port")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.recvPort
                inputMethodHints: Qt.ImhDigitsOnly
                onTextChanged: emailAccount.recvPort = text
            }
            GlacierRoller {
                id: security
                label: qsTr("Security")
                width: parent.width - Theme.itemSpacingMedium*2
                model: Settings.encryptionModel
                currentIndex: emailAccount.recvSecurity
                onSelect: emailAccount.recvSecurity = index
                delegate: GlacierRollerItem{
                    Text{
                        height: Theme.itemHeightMedium
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                        color: Theme.textColor
                        font.pixelSize: Theme.fontSizeMedium
                        font.bold: (security.activated && security.currentIndex === index)
                    }
                }
            }
            TextField {
                id: recvUsernameField
                placeholderText: qsTr("Username")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.recvUsername
                inputMethodHints: Qt.ImhNoAutoUppercase
                onTextChanged: emailAccount.recvUsername = text
            }
            TextField {
                id: recvPasswordField
                placeholderText: qsTr("Password")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.recvPassword
                onTextChanged: emailAccount.recvPassword = text
                echoMode: TextInput.Password
            }

            Label {
                text: qsTr("Sending settings")
            }

            TextField {
                id: sendServerField
                placeholderText: qsTr("Server address")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.sendServer
                inputMethodHints: Qt.ImhNoAutoUppercase
                onTextChanged: emailAccount.sendServer = text
            }
            TextField {
                id: sendPortField
                placeholderText: qsTr("Port")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.sendPort != "" ? emailAccount.sendPort : "465"
                inputMethodHints: Qt.ImhDigitsOnly
                onTextChanged: emailAccount.sendPort = text
            }
            GlacierRoller {
                id: sendAuthField
                label: qsTr("Authentication")
                width: parent.width - Theme.itemSpacingMedium*2
                model: Settings.authenticationModel
                currentIndex: emailAccount.sendAuth
                onSelect: emailAccount.sendAuth = index
                delegate: GlacierRollerItem{
                    Text{
                        height: Theme.itemHeightLarge
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                        color: Theme.textColor
                        font.pixelSize: Theme.fontSizeMedium
                        font.bold: (sendAuthField.activated && sendAuthField.currentIndex === index)
                    }
                }
            }
            GlacierRoller {
                id: sendingSecurity
                label: qsTr("Security")
                width: parent.width - Theme.itemSpacingMedium*2
                model: Settings.encryptionModel
                currentIndex: emailAccount.sendSecurity
                onSelect: emailAccount.sendSecurity = index
                delegate: GlacierRollerItem{
                    Text{
                        height: Theme.itemHeightMedium
                        verticalAlignment: Text.AlignVCenter
                        text: modelData
                        color: Theme.textColor
                        font.pixelSize: Theme.fontSizeMedium
                        font.bold: (sendingSecurity.activated && sendingSecurity.currentIndex === index)
                    }
                }
            }
            TextField {
                id: sendUsernameField
                width: parent.width - Theme.itemSpacingMedium*2
                placeholderText: qsTr("Username")
                text: emailAccount.sendUsername
                inputMethodHints: Qt.ImhNoAutoUppercase
                onTextChanged: emailAccount.sendUsername = text
            }
            TextField {
                id: sendPasswordField
                width: parent.width - Theme.itemSpacingMedium*2
                placeholderText: qsTr("Password")
                text: emailAccount.sendPassword
                onTextChanged: emailAccount.sendPassword = text
                echoMode: TextInput.Password
            }
        }
    }


    /* ModalMessageBox {
        id: verifyCancel
        acceptButtonText: qsTr ("Yes")
        cancelButtonText: qsTr ("No")
        title: qsTr ("Discard changes")
        text: qsTr ("You have made changes to your settings, are you sure you want to cancel?")
        onAccepted: {
            settingsPage.state = settingsPage.getHomescreen()
        }
    }*/

    //FIXME use standard action bar here
    Rectangle {
        id: buttonBar
        anchors.bottom: parent.bottom
        width: parent.width
        height: Theme.itemHeightLarge

        Button {
            height: parent.height
            width: parent.width/2
            anchors.right: parent.right
            primary: true

            text: qsTr("Next")
            function validate() {
                var errors = 0;
                if (recvServerField.text.length === 0) {
                    errors++;
                }
                if (recvPortField.text.length === 0) {
                    errors++;
                }
                if (recvUsernameField.text.length === 0) {
                    errors++;
                }
                if (recvPasswordField.text.length === 0) {
                    errors++;
                }
                if (sendServerField.text.length === 0) {
                    errors++;
                }
                if (sendPortField.text.length === 0) {
                    errors++;
                }
                return errors === 0;
            }
            onClicked: {
                if (validate()) {
                    pageStack.push(Qt.resolvedUrl("DetailsScreen.qml"));
                }
            }
        }
        Button {
            height: parent.height
            width: parent.width/2
            anchors.left: parent.left

            text: qsTr("Cancel")
            onClicked: {
                verifyCancel.show();
            }
        }
    }
}
