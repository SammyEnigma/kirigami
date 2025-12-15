/*
 *  SPDX-FileCopyrightText: 2018 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import QtQuick.Controls as QQC
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kirigami.templates as KT
import "../" as P

P.PrivateActionToolButton {
    id: root
    property KT.OverlayDrawer drawer

    icon.name: drawer?.position === 1 ? (drawer?.handleOpenIcon.name ?? "") : (drawer?.handleClosedIcon.name ?? "")
    icon.source: drawer?.position === 1 ? (drawer?.handleOpenIcon.source ?? "") : (drawer?.handleClosedIcon.source ?? "")

    action: Kirigami.Action {
        children: root.drawer && root.drawer instanceof Kirigami.GlobalDrawer && root.drawer.isMenu ? root.drawer.actions : []
        tooltip: {
            if (root.drawer && root.drawer.isMenu) {
                return checked ? qsTr("Close menu") : qsTr("Open menu");
            }

            return root.QQC.ApplicationWindow.window?.globalDrawer?.handleClosedToolTip || ""
        }
    }

    onClicked: {
        if (!drawer || drawer?.isMenu) {
            return;
        }
        if (drawer.visible) {
            drawer.close();
        } else {
            // CallLater is necessary for when the DragHandler still had grab
            Qt.callLater(drawer.open);
        }
    }

    Connections {
        // Only target the GlobalDrawer when it *is* a GlobalDrawer, since
        // it can be something else, and that something else probably
        // doesn't have an isMenuChanged() signal.
        target: root.drawer as Kirigami.GlobalDrawer
        function onIsMenuChanged() {
            if (!root.drawer.isMenu && root.menu) {
                root.menu.dismiss()
            }
        }
    }


    DragHandler {
        target: null
        acceptedDevices: PointerDevice.TouchScreen
        xAxis {
            enabled: root.drawer && (root.drawer.edge === Qt.LeftEdge || root.drawer.edge === Qt.RightEdge)
            minimum: 0
            maximum: root.drawer?.contentItem.width ?? 0
            onActiveValueChanged: (delta) => {
                let positionDelta = delta / root.drawer.contentItem.width;
                if (root.drawer.edge === Qt.RightEdge) {
                    positionDelta *= -1;
                }
                root.drawer.position += positionDelta;
            }
        }
        yAxis.enabled: false
        onGrabChanged: (transition, point) => {
            switch (transition) {
            case PointerDevice.GrabExclusive:
            case PointerDevice.GrabPassive:
                root.drawer.peeking = true;
                break;
            case PointerDevice.UngrabExclusive:
            case PointerDevice.UngrabPassive:
            case PointerDevice.CancelGrabExclusive:
            case PointerDevice.CancelGrabPassive:
                root.drawer.peeking = false;
                break;
            default:
                break;
            }
        }
    }
}
