/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami

NavigationButton {
    id: button

    icon.name: (LayoutMirroring.enabled ? "go-next-symbolic-rtl" : "go-next-symbolic")
    text: qsTr("Navigate Forward")

    enabled: applicationWindow().pageStack.currentIndex < applicationWindow().pageStack.depth-1

    onClicked: applicationWindow().pageStack.goForward();

    state: {
        const pageStack = applicationWindow().pageStack;
        const showNavButtons = globalToolBar?.showNavigationButtons ?? Kirigami.ApplicationHeaderStyle.NoNavigationButtons;
        if (pageStack.layers.depth === 1
            && pageStack.contentItem.contentWidth > pageStack.width + Kirigami.Units.gridUnit
            && (showNavButtons & Kirigami.ApplicationHeaderStyle.ShowForwardButton)) {
            return ""
        } else {
            return "invisible"
        }
    }
}
