/*
 * Copyright 2011 Intel Corporation.
 * Copyright (C) 2017-2021 Chupligin Sergey <neochapay@gmail.com>
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
import Nemo.Dialogs 1.0

Page {
    id: registerPage
    headerTools:  HeaderToolsLayout {
        id: hTools
        title: qsTr("Add mail account")
        showBackButton: true
    }

    property int preset: 0
    property string description: qsTr("Generic mail account")

    Component.onCompleted: {
        /*TODO ADD PERSETS FOR POPPULAR SERVICES*/
        emailAccount.description = registerPage.description;
    }

    EmailAccount { id: emailAccount }

    Flickable {
        id: flickForm
        clip: true
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: content
            width: parent.width
            height:  childrenRect.height

            spacing: Theme.itemSpacingMedium

            TextField {
                id: descriptField
                placeholderText: qsTr("Account description:")
                text: emailAccount.description;
                enabled: visible
                width: parent.width - Theme.itemSpacingMedium*2
                // hide this field for "other" type accounts
                visible: registerPage.preset == 0
            }

            TextField {
                id: nameField
                placeholderText: qsTr("Your name:")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.name //done to supress onTextChanged
                onTextChanged: emailAccount.name = text
            }

            TextField {
                id: addressField
                placeholderText: qsTr("Email address:")
                width: parent.width - Theme.itemSpacingMedium*2
                text: emailAccount.address
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhEmailCharactersOnly
                onTextChanged: emailAccount.address = text
            }

            TextField {
                id: passwordField
                placeholderText: qsTr("Password:")
                width: parent.width - Theme.itemSpacingMedium*2
                onTextChanged: emailAccount.password = text
                echoMode: TextInput.Password
            }

        }
    }
    /*ModalMessageBox {
        id: verifyCancel
        acceptButtonText: qsTr ("Yes")
        cancelButtonText: qsTr ("No")
        title: qsTr ("Discard changes")
        text: qsTr ("You have made changes to your settings. Are you sure you want to cancel?")
        onAccepted: {
            settingsPage.state = settingsPage.getHomescreen();
        }
    }*/

    Dialog{
        id: errorDialog
        acceptText: qsTr("Return")
        headingText: qsTr("Error")

        inline: false

        icon: "image://theme/exclamation-triangle"

        onAccepted: {
            errorDialog.close();
        }
    }

    // Added By Daewon.Park
    EmailAccountListModel {
        id : accountListModel
    }

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
                if (nameField.text.length === 0) {
                    errors++;
                }
                if (addressField.text.length === 0) {
                    errors++;
                }
                if (passwordField.text.length === 0) {
                    errors++;
                }

                // Added By Daewon.Park
                var accountList = accountListModel.allEmailAddresses();
                for(var i = 0; i < accountList.length; i++) {
                    console.log("Account : " + addressField.text + " : " + accountList[i]);
                    if(addressField.text === accountList[i]) {
                        errorDialog.subLabelText = qsTr("Same account is already registered");
                        errorDialog.open()
                        errors++;
                        break;
                    }
                }

                return errors === 0;
            }
            onClicked: {
                if (validate()) {
                    if (registerPage.preset != 0) {
                        pageStack.push(Qt.resolvedUrl("DetailsScreen.qml"));
                    } else {
                        pageStack.push(Qt.resolvedUrl("ManualScreen.qml"), {emailAccount: emailAccount});
                    }
                } else {
                    errorDialog.subLabelText = qsTr("All fields are required!")
                    errorDialog.open()
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
