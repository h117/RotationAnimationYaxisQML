import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("DragAndRotate")

    Row {
        x: 100; y: 100
        spacing: 10
        Rectangle {
        id: container
        width: 600; height: 200
            Rectangle {
            id: rect
            width: 50; height: 50
            color: "red"
            transform:
                Rotation {
                id: yRed
                origin.x: 50;
                origin.y: 50;
                axis { x: 0; y: 1; z: 0; }
                angle: 0
                }
                // Rotation Movement in yAxis
                NumberAnimation {
                running: true
                target: yRed;
                property: "angle";
                from: 0; to: 360;
                duration: 3000;
                }
                MouseArea {
                anchors.fill: parent
                drag.target: rect
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.maximumX: container.width - rect.width
                // Zoom in-out & drag movement
                onWheel: {
                    if (wheel.modifiers & Qt.ControlModifier) {
                        rect.rotation += wheel.angleDelta.y / 120 * 5;
                        if (Math.abs(rect.rotation) < 4)
                            rect.rotation = 0;
                    } else {
                        rect.rotation += wheel.angleDelta.x / 120;
                        if (Math.abs(rect.rotation) < 0.6)
                            rect.rotation = 0;
                        var scaleBefore = rect.scale;
                        rect.scale += rect.scale * wheel.angleDelta.y / 120 / 10;
                    }
                    }
                }
            }
        }
    }
}




