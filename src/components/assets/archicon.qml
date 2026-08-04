// Generated from SVG file archicon.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes
import QtQuick.Effects

Item {
    implicitWidth: 155
    implicitHeight: 155
    component AnimationsInfo : QtObject
    {
        property bool paused: false
        property int loops: 1
        signal restart()
    }
    property AnimationsInfo animations : AnimationsInfo {}
    transform: [
        Scale { xScale: width / 43.9208; yScale: height / 43.9208 }
    ]
    objectName: "svg1"
    id: _qt_node0
    transformOrigin: Item.TopLeft
    Item { // Structure node
        objectName: "layer1"
        id: _qt_node1
        transformOrigin: Item.TopLeft
        transform: TransformGroup {
            id: _qt_node1_transform_base_group
            Translate { x: -83.7836; y: -119.858}
        }
        Image {
            objectName: "image1"
            id: _qt_node2
            transformOrigin: Item.TopLeft
            x: 83.7836
            y: 119.858
            width: 43.9208
            height: 43.9208
            source: "svg_asset_12884901888.png"
        }
    }
}
