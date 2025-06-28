import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: "EASi Learning"

    header: ToolBar {
               id: titlePanel
               height: 60
               background: Rectangle {
                   color: "#dee1e6"
               }

               Label {
                   text: "EASi Learning"
                   color: "#001b3d"
                   font.pixelSize: 20
                   font.bold: true
                   //anchors.centerIn: parent
                   anchors.left: parent.left
                   anchors.leftMargin: 16
                   anchors.verticalCenter: parent.verticalCenter
               }
           }

           Canvas {
              id: canvas
              anchors.fill: parent

              property bool drawing: false
              property bool backgroundDrawn: false
              property color brushColor: "black"  // White brush on black canvas
              property int brushSize: 4
              property var lastPoint: Qt.point(0, 0)

              onPaint: {
                      var ctx = getContext("2d")

                      // Draw black background first time or when needed
                      if (!backgroundDrawn) {
                          ctx.fillStyle = "white"
                          ctx.fillRect(0, 0, width, height)
                          backgroundDrawn = true
                          //console.log("Black background drawn, size:", width, height)
                      }
                  }

              MouseArea {
                   anchors.fill: parent

                   onPressed: {
                       canvas.drawing = true;
                       canvas.lastPoint = Qt.point(mouseX, mouseY)
                   }

                   onPositionChanged: {
                       if (canvas.drawing) {
                           var ctx = canvas.getContext("2d")
                           ctx.strokeStyle = canvas.brushColor
                           ctx.lineWidth = canvas.brushSize
                           ctx.lineCap = "round"
                           ctx.lineJoin = "round"

                           ctx.beginPath()
                           ctx.moveTo(canvas.lastPoint.x, canvas.lastPoint.y)
                           ctx.lineTo(mouseX, mouseY)
                           ctx.stroke()

                           canvas.lastPoint = Qt.point(mouseX, mouseY)
                           canvas.requestPaint()
                       }
                   }

                   onReleased: {
                       canvas.drawing = false
                   }
              }
           }

           Drawer {
               id: drawer
               width: 250
               height: parent.height
               dragMargin: 30

               background: Rectangle {
                   color: "#f5f5f5"
                   border.color: "#dee1e6"
                   border.width: 1
               }

               Column {
                   anchors.fill: parent
                   anchors.margins: 16
                   spacing: 12

                   Label {
                       text: "Drawing Options"
                       font.pixelSize: 18
                       font.bold: true
                       color: "#001b3d"
                   }

                   Rectangle {
                       width: parent.width
                       height: 1
                       color: "#dee1e6"
                   }

                   // Brush Color Section
                   Label {
                       text: "Brush Color"
                       font.pixelSize: 14
                       color: "#001b3d"
                   }

                   Row {
                       spacing: 8
                       Repeater {
                           model: ["black", "red", "blue", "green", "purple"]
                           delegate: Rectangle {
                               width: 30
                               height: 30
                               color: modelData
                               radius: 15
                               border.color: canvas.brushColor === modelData ? "#001b3d" : "#ccc"
                               border.width: 2
                               MouseArea {
                                   anchors.fill: parent
                                   onClicked: canvas.brushColor = modelData
                               }
                           }
                       }
                   }

                   // Brush Size Section
                   Label {
                       text: "Brush Size: " + canvas.brushSize + "px"
                       font.pixelSize: 14
                       color: "#001b3d"
                   }

                   Slider {
                       width: parent.width
                       from: 1
                       to: 20
                       stepSize: 1
                       value: canvas.brushSize
                       onValueChanged: canvas.brushSize = value
                   }

                   Rectangle {
                       width: parent.width
                       height: 1
                       color: "#dee1e6"
                   }

                   // Action Buttons
                   Button {
                       width: parent.width
                       height: 40
                       text: "Clear Canvas"
                       background: Rectangle {
                           color: parent.pressed ? "#c0c4c9" : "#dee1e6"
                           radius: 4
                       }
                       onClicked: {
                           canvas.backgroundDrawn = false
                           canvas.requestPaint()
                       }
                   }

                   Button {
                       width: parent.width
                       height: 40
                       text: "Close Menu"
                       background: Rectangle {
                           color: parent.pressed ? "#b8bcc1" : "#001b3d"
                           radius: 4
                       }
                       contentItem: Text {
                           text: parent.text
                           color: "white"
                           horizontalAlignment: Text.AlignHCenter
                           verticalAlignment: Text.AlignVCenter
                       }
                       onClicked: drawer.close()
                   }
               }
           }

}
