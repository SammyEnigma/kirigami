/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.1
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0 as Controls

import org.kde.kirigami 2.4

Controls.ToolButton {
    id: button

    icon.name: (LayoutMirroring.enabled ? "go-previous-symbolic-rtl" : "go-previous-symbolic")

    enabled: applicationWindow().pageStack.layers.depth > 1 || (applicationWindow().pageStack.depth > 1 && (applicationWindow().pageStack.currentIndex > 0 || applicationWindow().pageStack.contentItem.contentX > 0))

    property var showNavButtons: {
        try {
            return globalToolBar.showNavigationButtons
        } catch (_) {
            return false
        }
    }
    // The gridUnit wiggle room is used to not flicker the button visibility during an animated resize for instance due to a sidebar collapse
    visible: applicationWindow().pageStack.layers.depth > 1 || (applicationWindow().pageStack.contentItem.contentWidth > applicationWindow().pageStack.width + Units.gridUnit && (button.showNavButtons === true || (button.showNavButtons & ApplicationHeaderStyle.ShowBackButton)))

    onClicked: {
        applicationWindow().pageStack.goBack();
    }

    Controls.ToolTip {
        visible: button.hovered
        text: qsTr("Navigate Back")
        delay: Units.toolTipDelay
        timeout: 5000
        y: button.height
    }
}
