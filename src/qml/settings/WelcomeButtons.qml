/*
 * Copyright 2011 Intel Corporation.
 * Copyright (C) 2017-2018 Chupligin Sergey <neochapay@gmail.com>
 *
 * This program is licensed under the terms and conditions of the
 * Apache License, version 2.0.  The full text of the Apache License is at 	
 * http://www.apache.org/licenses/LICENSE-2.0
 */

import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    spacing: 1

    ListModel{
        id: accountsListModels
        ListElement{
            label: qsTr("Gmail")
            icon: "image://theme/google"
            preset: 2
            description: qsTr("Google mail");
        }
        ListElement{
            label:  qsTr("Microsoft Live Hotmail")
            icon: "image://theme/microsoft"
            preset: 5
            description: qsTr("Microsoft Live Hotmail");
        }
        ListElement{
            label:  qsTr("Yahoo!")
            icon: "image://theme/yahoo"
            preset: 3
            description: "";
        }
        ListElement{
            label:  qsTr("Other")
            icon: "image://theme/envelope-open"
            preset: 0
            description: qsTr("generic mail account")
        }
    }

    ListView {
        anchors.fill: parent
        model: accountsListModels
        delegate: ListViewItemWithActions {
            showNext: true
        }
    }

/*    WelcomeButton {
        title: qsTr("Gmail")
        icon: "image://theme/google"
        onClicked: {
            emailAccount.clear();
            emailAccount.preset = 2; // Gmail
            emailAccount.description = qsTr("Gmail");
            savePreset();
            settingsPage.state = "RegisterScreen";
        }
    }
    WelcomeButton {
        title: qsTr("Microsoft Live Hotmail")
        icon: "image://theme/microsoft"
        onClicked: {
            emailAccount.clear();
            emailAccount.preset = 5; // Microsoft Live
            emailAccount.description = qsTr("Microsoft Live Hotmail");
            savePreset();
            settingsPage.state = "RegisterScreen";
        }
    }
    WelcomeButton {
        title: qsTr("Yahoo!")
        icon: "image://theme/yahoo"
        onClicked: {
            emailAccount.clear();
            emailAccount.preset = 3; // Yahoo
            emailAccount.description = qsTr("Yahoo!");
            savePreset();
            settingsPage.state = "RegisterScreen";
        }
    }
    WelcomeButton {
        title: qsTr("Other")
        icon: "image://theme/envelope-open"
        onClicked: {
            emailAccount.clear();
            emailAccount.recvSecurity = "0"; // None
            emailAccount.sendAuth = "0";     // None
            emailAccount.sendSecurity = "0"; // None
            saveZero();
            settingsPage.state = "RegisterScreen";
        }
    }

    function savePreset() { //Called by other items' signal
        welcomeButtonsSave.setValue("email-account-preset",emailAccount.preset);
        welcomeButtonsSave.setValue("email-account-description",emailAccount.description);
        welcomeButtonsSave.sync();
    }

    function saveZero() { //Called by other items' signal
        welcomeButtonsSave.setValue("email-account-preset","-1");
        welcomeButtonsSave.setValue("email-account-recvSecurity",emailAccount.recvSecurity);
        welcomeButtonsSave.setValue("email-account-sendAuth",emailAccount.sendAuth);
        welcomeButtonsSave.setValue("email-account-sendSecurity",emailAccount.sendSecurity);
        welcomeButtonsSave.sync();
    }*/
}
