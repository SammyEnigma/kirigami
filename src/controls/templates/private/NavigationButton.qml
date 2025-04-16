/*
 *  SPDX-FileCopyrightText: 2025 Marco Martin <mart@kde.org>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

QQC2.ToolButton {
    id: button

    Layout.rightMargin: state.length === 0 ? 0 : -width

    states: [
        State {
            PropertyChanges {
                target: button
                opacity: 1
                visible: true
            }
        },
        State {
            name: "invisible"
            PropertyChanges {
                target: button
                opacity: 0
                visible: false
            }
        }
    ]
    transitions: [
        Transition {
            from: "invisible"
            SequentialAnimation {
                PropertyAction {
                    target: button
                    property: "visible"
                    value: true
                }
                NumberAnimation {
                    target: button
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: Kirigami.Units.longDuration
                    easing.type: Easing.InOutQuad
                }
            }
        },
        Transition {
            to: "invisible"
            SequentialAnimation {
                NumberAnimation {
                    target: button
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: Kirigami.Units.longDuration
                    easing.type: Easing.InOutQuad
                }
                PropertyAction {
                    target: button
                    property: "visible"
                    value: false
                }
            }
        }
    ]

    display: QQC2.ToolButton.IconOnly

    QQC2.ToolTip {
        visible: button.hovered
        text: button.text
        delay: Kirigami.Units.toolTipDelay
        timeout: 5000
        y: button.height
    }
}
