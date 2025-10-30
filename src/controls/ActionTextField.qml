/*
 *  SPDX-FileCopyrightText: 2019 Carl-Lucien Schwan <carl@carlschwan.eu>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import QtQuick.Templates as T
import org.kde.kirigami as Kirigami

/*!
  \qmltype ActionTextField
  \inqmlmodule org.kde.kirigami

  \brief An advanced control to create custom textfields with inline buttons

  ActionTextField can display inline action buttons on the leading or trailing
  sides, and is used as the base class for other kinds of specialized text
  fields, including \l SearchField and \l PasswordField.

  Each action's \c {text} property will be displayed in a tooltip on hover.

  Example usage:
  \code
  import org.kde.kirigami as Kirigami

  Kirigami.ActionTextField {
      id: inputField

      placeholderText: i18n("Enter name")

      rightActions: Kirigami.Action {
          icon.name: "edit-clear"
          visible: inputField.text.length > 0
          onTriggered: {
              inputField.clear();
              inputField.accepted();
          }
      }

      onAccepted: console.log("Entered text is " + inputField.text);
  }
  \endcode

  \since 5.56
 */
QQC2.TextField {
    id: root

    /*!
      \qmlproperty keysequence ActionTextField::focusSequence
      This property holds a shortcut sequence that will focus the text field.
      \since 5.56

      By default no shortcut is set.
     */
    property alias focusSequence: focusShortcut.sequence

    /*!
     \qmlproperty list<keysequence> ActionTextField::focusSequences
     This property holds multiple shortcut sequences that will focus the text field.
     \since 6.18

     By default no shortcut is set.
     */
    property alias focusSequences: focusShortcut.sequences

    /*!
      \qmlproperty list<Action> leftActions

      This property holds a list of actions that will be displayed on the
      leading side of the text field.

      By default this list is empty.

      \since 5.56
     */
    property list<T.Action> leftActions

    /*!
      \qmlproperty list<Action> rightActions

      This property holds a list of actions that will be displayed on the
      trailing side of the text field.

      By default this list is empty.

      \since 5.56
     */
    property list<T.Action> rightActions

    property alias _leftActionsRow: leftActionsRow
    property alias _rightActionsRow: rightActionsRow

    hoverEnabled: true

    horizontalAlignment: Qt.AlignLeft
    LayoutMirroring.enabled: Application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    leftPadding: Kirigami.Units.smallSpacing + (LayoutMirroring.enabled ? rightActionsRow : leftActionsRow).width
    rightPadding: Kirigami.Units.smallSpacing + (LayoutMirroring.enabled ? leftActionsRow : rightActionsRow).width

    Behavior on leftPadding {
        NumberAnimation {
            duration: Kirigami.Units.longDuration
            easing.type: Easing.InOutQuad
        }
    }

    Behavior on rightPadding {
        NumberAnimation {
            duration: Kirigami.Units.longDuration
            easing.type: Easing.InOutQuad
        }
    }

    Shortcut {
        id: focusShortcut
        enabled: root.visible && root.enabled
        onActivated: {
            root.forceActiveFocus(Qt.ShortcutFocusReason)
            root.selectAll()
        }
    }

    QQC2.ToolTip {
        visible: focusShortcut.nativeText.length > 0 && root.text.length === 0 && root.hovered
        text: focusShortcut.nativeText
    }

    component InlineActionIcon: QQC2.ToolButton {
        id: iconDelegate

        required property T.Action modelData

        icon.width: Kirigami.Units.iconSizes.sizeForLabels
        icon.height: Kirigami.Units.iconSizes.sizeForLabels

        Layout.fillHeight: true
        Layout.preferredWidth: implicitHeight

        icon.name: modelData.icon.name.length > 0 ? modelData.icon.name : modelData.icon.source
        visible: !(modelData instanceof Kirigami.Action) || modelData.visible
        enabled: modelData.enabled

        onClicked: mouse => iconDelegate.modelData.trigger()

        QQC2.ToolTip.visible: (hovered || activeFocus) && (iconDelegate.modelData.text.length > 0)
        QQC2.ToolTip.text: iconDelegate.modelData.text
    }

    RowLayout {
        id: leftActionsRow

        anchors {
            margins: 1
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }

        spacing: Kirigami.Units.smallSpacing
        layoutDirection: Qt.LeftToRight

        Repeater {
            model: root.leftActions
            InlineActionIcon { }
        }
    }

    RowLayout {
        id: rightActionsRow

        anchors {
            margins: 1
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }

        spacing: Kirigami.Units.smallSpacing
        layoutDirection: Qt.RightToLeft

        Repeater {
            model: root.rightActions
            InlineActionIcon { }
        }
    }
}
