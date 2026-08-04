import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Widgets
import "../themes"

Rectangle {
   id: iconRoot
   anchors.leftMargin: 100
   implicitHeight: 35
   implicitWidth: logoPill.implicitWidth + 15
   width: 100
   radius: 12
   color: Colors.md3.surface
   clip: true
   property bool expanded: false

   Behavior on implicitWidth {
      NumberAnimation {
         duration: 150
         easing.type: Easing.OutQuad
      }
   }
   HoverHandler{
      id: hoverOverIcon

      onHoveredChanged: {
         if(hovered){
            hoverDelay.start()
         } else {
            iconRoot.expanded = false
         }
      }
   }

   Timer{
      id: hoverDelay
      interval: 500
      repeat: false
      onTriggered: iconRoot.expanded = true
   }

   RowLayout {
      id: logoPill
      anchors.centerIn: parent
      anchors.margins: 8

      Item {
         id: logoContainer
         implicitHeight: archLogo.implicitHeight
         implicitWidth: archLogo.implicitWidth

         IconImage {
            id: archLogo
            anchors.centerIn: parent
            source: Qt.resolvedUrl("./assets/archicon.svg")
            implicitWidth: 20
            implicitHeight: 20
         }
         MultiEffect {
            implicitWidth: parent
            implicitHeight: parent
            anchors.fill: archLogo
            source: archLogo

            colorization: 1.0
            colorizationColor: Colors.md3.primary

         }

      }
      Item {
         height: 35
         width: joke.implicitWidth
         visible: iconRoot.expanded ? true : false
         Text {
            id: joke
            anchors.centerIn: parent
            text: "uwu please activate arch 🥺"
            font { pixelSize: 16; bold: true }
            color: Colors.md3.primary
         }
      }

   }

}
