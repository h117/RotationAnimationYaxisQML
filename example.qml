import QtQuick 2.14
import QtQuick.Window 2.14

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("DragAndRotate")

    property int rotateAngle: 0
    property real centerX : (width / 2);
    property real centerY : (height / 2);

    Rectangle {
        id: rect
        anchors.centerIn: parent
        width: 150;
        height: 150
        antialiasing: true

        gradient: Gradient {
            GradientStop {
                position: 0.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14148c"; to: "#0E1533"; duration: 5000 }
                    ColorAnimation { from: "#0E1533"; to: "#14148c"; duration: 5000 }
                }
            }
            GradientStop {
                position: 1.0
                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "#14aaff"; to: "#437284"; duration: 5000 }
                    ColorAnimation { from: "#437284"; to: "#14aaff"; duration: 5000 }
                }
            }
        }

        Rectangle {
            anchors {
                top: parent.top
                right: parent.right
            }
            width: 10;
            height: 10
            color: "red"
        }

        WheelHandler {
            property: "rotation"
            onWheel: console.log("rotation", event.angleDelta.y)
        }
    }

    Rectangle {
        id: fixed
        anchors {
            top: rect.top
            right: rect.right
        }
        width: 10;
        height: 10
        color: "black"
    }

    Rectangle {
        id: cirLeft
        anchors {
            left: parent.left
            leftMargin: 120
            top: parent.top
            topMargin: 120
        }
        width: 100
        height: width
        radius: width / 2
        antialiasing: true
        color: "orange"
        transform: Rotation { origin.x: 0; origin.y: 0; angle: rotateAngle}
    }

    Rectangle {
        id: cirRight
        anchors {
            right: parent.right
            rightMargin: 120
            top: parent.top
            topMargin: 120
        }
        width: 100
        height: width
        radius: width / 2
        antialiasing: true
        color: "orange"

        Rectangle {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            width: 20
            height: width
            radius: width / 2
            color: "red"
        }

        NumberAnimation on rotation { from: 0; to: 360; duration: 10000; loops: Animation.Infinite }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onPositionChanged: {
            var point =  mapToItem (parent, mouse.x, mouse.y);
            var diffX = (point.x - window.centerX);
            var diffY = -1 * (point.y - window.centerY);
            var rad = Math.atan (diffY / diffX);
            var deg = (rad * 180 / Math.PI);
            rotateAngle = deg;
            if (diffX > 0 && diffY > 0) {
                rect.rotation = 90 - Math.abs (deg);
            }
            else if (diffX > 0 && diffY < 0) {
                rect.rotation = 90 + Math.abs (deg);
            }
            else if (diffX < 0 && diffY > 0) {
                rect.rotation = 270 + Math.abs (deg);
            }
            else if (diffX < 0 && diffY < 0) {
                rect.rotation = 270 - Math.abs (deg);
            }
            console.log("deg: ", deg)
        }
    }
}
