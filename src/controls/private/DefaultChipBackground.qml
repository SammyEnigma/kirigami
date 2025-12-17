// SPDX-FileCopyrightText: 2022 Felipe Kinoshita <kinofhek@gmail.com>
// SPDX-License-Identifier: LGPL-2.0-or-later

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.kirigami.templates as KT

Rectangle {

    /*!
      \brief This property holds the chip's default background color.
     */
    property color defaultColor: Kirigami.Theme.backgroundColor

    /*!
      \brief This property holds the color of the Chip's background when it is being pressed.
      \sa QtQuick.AbstractButton::down
     */
    property color pressedColor: Qt.rgba(Kirigami.Theme.highlightColor.r, Kirigami.Theme.highlightColor.g, Kirigami.Theme.highlightColor.b, 0.3)

    /*!
      \brief This property holds the color of the Chip's background when it is checked.
      \sa QtQuick.AbstractButton::checked
     */
    property color checkedColor: Qt.rgba(Kirigami.Theme.highlightColor.r, Kirigami.Theme.highlightColor.g, Kirigami.Theme.highlightColor.b, 0.2)

    /*!
      \brief This property holds the chip's default border color.
     */
    property color defaultBorderColor: Kirigami.ColorUtils.linearInterpolation(Kirigami.Theme.backgroundColor, Kirigami.Theme.textColor, Kirigami.Theme.frameContrast)

    /*!
      \brief This property holds the color of the Chip's border when it is checked.
      \sa QtQuick.AbstractButton::checked
     */
    property color checkedBorderColor: Qt.rgba(Kirigami.Theme.highlightColor.r, Kirigami.Theme.highlightColor.g, Kirigami.Theme.highlightColor.b, 0.9)

    /*!
      \brief This property holds the color of the Chip's border when it is being pressed.
      \sa QtQuick.AbstractButton::down
     */
    property color pressedBorderColor: Qt.rgba(Kirigami.Theme.highlightColor.r, Kirigami.Theme.highlightColor.g, Kirigami.Theme.highlightColor.b, 0.7)

    /*!
     * \brief This property holds the color of the Chip's border when it is hovered.
     * \sa QtQuick.Control::hovered
     */
    property color hoveredBorderColor: Kirigami.Theme.hoverColor

    Kirigami.Theme.colorSet: Kirigami.Theme.Header
    Kirigami.Theme.inherit: false

    color: {
        const chip = parent as KT.Chip
        if (chip.down) {
            return pressedColor
        } else if (chip.checked) {
            return checkedColor
        } else {
            return defaultColor
        }
    }
    border.color: {
        const chip = parent as KT.Chip
        if (chip.down) {
            return pressedBorderColor
        } else if (chip.checked) {
            return checkedBorderColor
        } else if (chip.hovered) {
            return hoveredBorderColor
        } else {
            return defaultBorderColor
        }
    }
    border.width: 1
    radius: Kirigami.Units.cornerRadius
}
