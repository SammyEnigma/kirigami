// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: LGPL-2.0-or-later

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

import org.kde.kirigami.templates as KT
import "private" as P

KT.Chip {
    id: chip

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding,
                            implicitIndicatorWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight)

    checkable: !closable
    hoverEnabled: chip.interactive

    MouseArea {
        anchors.fill: parent
        enabled: !chip.interactive
    }

    property alias labelItem: label

    icon.width: Kirigami.Units.iconSizes.small
    icon.height: Kirigami.Units.iconSizes.small
    spacing: Kirigami.Units.smallSpacing
    leftPadding: Kirigami.Units.smallSpacing
        + ((!iconItem.visible && !mirrored) || (!indicator.visible && mirrored)
            ? Kirigami.Units.smallSpacing : 0)
        + (indicator.visible && mirrored ? implicitIndicatorWidth : 0)
    rightPadding: Kirigami.Units.smallSpacing
        + ((!iconItem.visible && mirrored) || (!indicator.visible && !mirrored)
            ? Kirigami.Units.smallSpacing : 0)
        + (indicator.visible && !mirrored ? implicitIndicatorWidth : 0)

    indicator: QQC2.ToolButton {
        x: parent.mirrored ? 0 : parent.width - width
        y: Math.round((parent.height - height) / 2)
        visible: chip.closable
        text: qsTr("Remove Tag")
        icon.name: "edit-delete-remove"
        icon.width: Kirigami.Units.iconSizes.sizeForLabels
        icon.height: Kirigami.Units.iconSizes.sizeForLabels
        display: QQC2.AbstractButton.IconOnly
        onClicked: chip.removed()
    }

    contentItem: RowLayout {
        spacing: chip.spacing

        Kirigami.Icon {
            id: iconItem
            visible: valid && chip.display !== QQC2.AbstractButton.TextOnly
            implicitWidth: chip.icon.width
            implicitHeight: chip.icon.height
            color: chip.icon.color
            isMask: chip.iconMask
            source: chip.icon.name || chip.icon.source
        }
        QQC2.Label {
            id: label
            visible: text.length > 0 && chip.display !== QQC2.AbstractButton.IconOnly
            Layout.fillWidth: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: chip.text
            color: Kirigami.Theme.textColor
            elide: Text.ElideRight
        }
    }

    background: P.DefaultChipBackground {}
}
