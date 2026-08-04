import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "../themes"

Rectangle {
   id: workspaceBox
   // Layout.preferredWidth: workspaceRow.implicitWidth + 16
   // Layout.preferredHeight: workspaceRow.implicitHeight + 10
   color: Colors.md3.surface
   width: workspaceRow.implicitWidth + 16
   height: workspaceRow.implicitHeight + 6 + ((workspaceRow.implicitHeight + 6) % 2)

   radius: 12
   property bool parentHovered: false
   clip: true
   property var hyprMonitor

   Behavior on width {
      NumberAnimation {
         duration: 150
         easing.type: Easing.OutQuad

      }
   }
   HoverHandler{
      id: hoverOverSwitcher

      onHoveredChanged: {
         if(hovered){
            hovDelay.start()
         } else {
            workspaceBox.parentHovered = false
         }
      }
   }
   MouseArea {
      anchors.fill: parent
      onClicked: hovDelay.stop()

   }

   Timer {
      id: hovDelay
      interval: 1000
      repeat: false
      onTriggered: workspaceBox.parentHovered = true

   }

   RowLayout {
      id: workspaceRow
      anchors.centerIn: parent
      // anchors.fill: parent
      anchors.margins: 8

      Repeater {
         id: workspaceRepeater
         model: Hyprland.workspaces.values
         Rectangle{
            id: littleContainers
            width: workspaceNums.implicitWidth + 5 + ((workspaceNums.implicitWidth + 5) % 2)
            height: workspaceNums.implicitHeight + 3
            radius: 12
            visible: workspaceBox.parentHovered ? true : workspaceNums.thisMonitor
            HoverHandler {
               id: hoverLittleCont
            }
            // color: hoverLittleCont.hovered ? Colors.md3.primary_container : Colors.md3.background
            color: Colors.md3.background
            Behavior on color {
               ColorAnimation{
                  duration: 100
                  // easing.type: Easing.OutQuad
               }
            }

            required property var modelData
            MouseArea {
               anchors.fill: parent
               onClicked: {
                  Hyprland.dispatch("hl.dsp.focus({workspace = " + modelData.id + "})")
                  hovDelay.stop()
               }

            }

            Text {
               id: workspaceNums
               // property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
               // required property var workspaceRepeater.modelData
               property var ws: littleContainers.modelData
               property bool thisMonitor: ws.monitor == panel.hyprMonitor
               property bool inFocus: ws.focused
               // property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
               //
               visible: workspaceBox.parentHovered ? true : thisMonitor
               // visible: thisMonitor
               anchors.centerIn: parent
               text: ws.id

               font { pixelSize: 16; bold: true }
               // property  color computedColor: {
               //
               //    if(inFocus) return Colors.md3.primary
               //       if(thisMonitor){ return Colors.md3.secondary }

               color: inFocus ? Colors.md3.primary : thisMonitor ? Colors.md3.on_background: Colors.md3.tertiary_container

            }

            PopupWindow {
               implicitHeight: 50
               implicitWidth: 50
               visible: true
            }
         }
      }

      // Item {
      // 	Layout.fillWidth: true
      // }
   }

}
