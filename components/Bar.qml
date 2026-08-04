import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "../themes"
PanelWindow {
   id: panel
   // required property var modelData
   screen: modelData
   anchors.top: true
   anchors.left: true
   anchors.right: true
   implicitHeight: 50
   // color: "transparent"
   color: "red"
   property var hyprMonitor: Hyprland.monitorFor(screen)
   property bool expand: false

   HoverHandler{
      id: boxHover

      onHoveredChanged: {
         if(hovered){
            hovDelay.start()
         } else {
            panel.expand = false
         }
      }

   }

   Timer {
      id: hovDelay
      interval: 600
      repeat: false
      onTriggered: panel.expand = true

   }

   RowLayout{
      // anchors.fill: parent
      anchors.fill: parent
      anchors.leftMargin: 8
      anchors.verticalCenter: parent.verticalCenter
      anchors.margins: 8

      AboutArch{

      }
      WorkspaceSwitch{
         // required property var modelData
         // parentHovered: boxHover.hovered
         hyprMonitor: hyprMonitor
      }
      Item{
         Layout.fillWidth: true
      }

   }

}
