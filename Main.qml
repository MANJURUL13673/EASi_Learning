import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: "EASi Learn"

    header: ToolBar {
               height: 60
               background: Rectangle {
                   color: "#f8f9fa"
               }

               Label {
                   text: "EASi Learn"
                   color: "#001b3d"
                   font.pixelSize: 20
                   font.bold: true
                   //anchors.centerIn: parent
                   anchors.left: parent.left
                   anchors.leftMargin: 16
                   anchors.verticalCenter: parent.verticalCenter
               }
           }



}
