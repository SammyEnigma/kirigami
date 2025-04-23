/*
 *  SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import org.kde.kirigami as Kirigami

NavigationButton {
    id: button

    icon.name: (LayoutMirroring.enabled ? "go-previous-symbolic-rtl" : "go-previous-symbolic")
    text: qsTr("Navigate Back")

    enabled: {
        const pageStack = applicationWindow().pageStack;

        if (pageStack.layers.depth > 1) {
            return true;
        }

        if (pageStack.depth > 1) {
            if (pageStack.currentIndex > 0) {
                return true;
            }

            const view = pageStack.columnView;
            if (LayoutMirroring.enabled) {
                return view.contentWidth - view.width < view.contentX
            } else {
                return view.contentX > 0;
            }
        }

        return false;
    }

    onClicked: {
        applicationWindow().pageStack.goBack();
    }

    // The gridUnit wiggle room is used to not flicker the button visibility during an animated resize for instance due to a sidebar collapse
    state: {
        const pageStack = applicationWindow().pageStack;
        const showNavButtons = globalToolBar?.showNavigationButtons ?? Kirigami.ApplicationHeaderStyle.NoNavigationButtons;
        if (pageStack.layers.depth > 1
            || (pageStack.contentItem.contentWidth > pageStack.width + Kirigami.Units.gridUnit
            && (showNavButtons & Kirigami.ApplicationHeaderStyle.ShowBackButton))) {
            return ""
        }
        return "invisible"
    }
}
