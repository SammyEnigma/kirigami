/*
 *   Copyright 2015 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 1.0

ScrollablePage {
    id: page
    Layout.fillWidth: true
    implicitWidth: Units.gridUnit * (Math.floor(Math.random() * 35) + 8)

    title: "Multiple Columns"

    ColumnLayout {
        width: page.width
        spacing: Units.smallSpacing

        Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: "This page is used to test multiple columns: you can push and pop an arbitrary number of pages, each new page will have a random implicit width between 8 and 35 grid units.\nIf you enlarge the window enough, you can test how the application behaves with multiple columns."
        }
        Item {
            Layout.minimumWidth: Units.gridUnit *2
            Layout.minimumHeight: Layout.minimumWidth
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Page implicitWidth: " + page.implicitWidth
        }
        Controls.Button {
            text: "Push Another Page"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: pageStack.push(Qt.resolvedUrl("MultipleColumnsGallery.qml"));
        }
        Controls.Button {
            text: "Pop A Page"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: pageStack.pop();
        }
    }
 
    
}
