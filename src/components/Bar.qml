import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "../themes"
import "./popups"

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

   // Hover Handler for the entire bar:
   HoverHandler{
      id: boxHover

      onHoveredChanged: {
         if(hovered){
            hovDelay.start()
         } else {
            panel.expand = false
            workspaceSwitcher.parentHovered = false
         }
      }

   }

   // Timer for delays
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
         id: aboutArch
         Layout.alignment: Qt.AlignVCenter
         property bool expanded: false
         property bool popupOpen: archPopup.visible
         MouseArea {
            id: clickedLaunch
            anchors.fill: parent
            onClicked: {
               archPopup.visible = !archPopup.visible
               aboutArch.expanded = true
            }
         }
      }
      WorkspaceSwitch{
         // required property var modelData
         // parentHovered: boxHover.hovered
         id: workspaceSwitcher
         hyprMonitor: hyprMonitor
         Layout.alignment: Qt.AlignVCenter

      }
      Item{
         Layout.fillWidth: true
      }

   }

   AboutArchPopup{
      id: archPopup
      anchor.window: panel
      anchor.rect.x: 10
      anchor.rect.y: panel.implicitHeight + 5
      grabFocus: true

   }

}
