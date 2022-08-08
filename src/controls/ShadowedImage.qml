/*
 *  SPDX-FileCopyrightText: 2020 Arjen Hiemstra <ahiemstra@heimr.nl>
 *  SPDX-FileCopyrightText: 2022 Carl Schwan <carl@carlschwan.eu>
 *
 *  SPDX-License-Identifier: LGPL-2.0-or-later
 */

import QtQuick 2.1
import org.kde.kirigami 2.12

/**
 * @brief An image with a shadow.
 *
 * This item will render a image, with a shadow below it. The rendering is done
 * using distance fields, which provide greatly improved performance. The shadow is
 * rendered outside of the item's bounds, so the item's width and height are the
 * don't include the shadow.
 *
 * Example usage:
 * @code
 * import org.kde.kirigami 2.19
 *
 * ShadowedImage {
 *     source: 'qrc:/myKoolGearPicture.png'
 *
 *     radius: 20
 *
 *     shadow.size: 20
 *     shadow.xOffset: 5
 *     shadow.yOffset: 5
 *
 *     border.width: 2
 *     border.color: Kirigami.Theme.textColor
 *
 *     corners.topLeftRadius: 4
 *     corners.topRightRadius: 5
 *     corners.bottomLeftRadius: 2
 *     corners.bottomRightRadius: 10
 * }
 * @endcode
 *
 * @since 5.69
 * @since 2.12
 * @inherit Item
 */
Item {

//BEGIN properties
    /**
     * @brief This property holds the color that will be underneath the image.
     *
     * This will be visible if the image has transparancy.
     *
     * @see org::kde::kirigami::ShadowedRectangle::radius
     * @property color color
     */
    property alias color: shadowRectangle.color

    /**
     * @brief This propery holds the corner radius of the image.
     * @see org::kde::kirigami::ShadowedRectangle::radius
     * @property real radius
     */
    property alias radius: shadowRectangle.radius

    /**
     * @brief This propery holds the shadow's properties of the image.
     * @see org::kde::kirigami::ShadowedRectangle::shadow
     * @property org::kde::kirigami::ShadowedRectangle::ShadowGroup shadow
     */
    property alias shadow: shadowRectangle.shadow

    /**
     * @brief This propery holds the border's properties of the image.
     * @see org::kde::kirigami::ShadowedRectangle::border
     * @property org::kde::kirigami::ShadowedRectangle::BorderGroup border
     */
    property alias border: shadowRectangle.border

    /**
     * @brief This propery holds the corner radius properties of the image.
     * @see org::kde::kirigami::ShadowedRectangle::corners
     * @property org::kde::kirigami::ShadowedRectangle::CornersGroup corners
     */
    property alias corners: shadowRectangle.corners

    /**
     * @brief This propery holds the source of the image.
     * @brief QtQuick.Image::source
     */
    property alias source: image.source

    /**
     * This property specifies that images on the local filesystem should be loaded
     * asynchronously in a separate thread. The default value is false,
     * causing the user interface thread to block while the image is
     * loaded. Setting asynchronous to true is useful where maintaining
     * a responsive user interface is more desirable than having images
     * immediately visible.
     *
     * @see QtQuick.Image::asynchronous
     * @property bool asynchronous
     */
    property alias asynchronous: image.asynchronous

    /**
     * @brief This property defines what happens when the source image has a different
     * size than the item.
     * @see QtQuick.Image::fillMode
     * @property int fillMode
     */
    property alias fillMode: image.fillMode

    /**
     * @brief This property holds the scaled width and height of the full-frame image.
     * @see QtQuick.Image::sourceSize
     */
    property alias sourceSize: image.sourceSize
//END properties

    Image {
        id: image
        anchors.fill: parent
        visible: shadowRectangle.softwareRendering
    }

    ShadowedTexture {
        id: shadowRectangle
        anchors.fill: parent

        source: image.status === Image.Ready ? image : null
    }
}
