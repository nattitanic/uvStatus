import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "../themes"

Rectangle {
   id: workspaceBox
   Layout.preferredWidth: workspaceRow.implicitWidth + 16
   Layout.preferredHeight: workspaceRow.implicitHeight + 10
   color: Colors.md3.surface

   radius: 12
   property bool parentHovered: false
   clip: true
   property var hyprMonitor

   Behavior on Layout.preferredWidth {
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
      onTriggered: {if (hoverOverSwitcher.hovered) workspaceBox.parentHovered = true}

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
            // visible: workspaceBox.parentHovered ? true : workspaceNums.thisMonitor

            visible: {
               if(workspaceBox.parentHovered){
                  return true
               } else if(workspaceNums.special){
                  return true
               } else {
                  return workspaceNums.thisMonitor
               }
            }
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
               property bool special: ws.id < 0
               // property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
               //
               // visible: workspaceBox.parentHovered ? true : thisMonitor
               // visible: thisMonitor
               anchors.centerIn: parent
               // text: ws.id

               text: {
                  if(!special) {
                     console.log(ws.id);
                     return (ws.id)
                  } else {
                     switch (ws.name) {
                        case "special:scratchpad":
                        return "assignment";
                        case "special:terminal":
                        return "terminal";
                        case "special:brave":
                        return "globe_asia";

                     }

                  }
               }
               font {
                  pixelSize: 16;
                  bold: true;
                  family: special ? "Material Symbols Outlined" : "JetBrainsMono Nerd Font Mono"
                  // family: "JetBrainsMono Nerd Font Mono"
               }
               // property  color computedColor: {
               //
               //    if(inFocus) return Colors.md3.primary
               //       if(thisMonitor){ return Colors.md3.secondary }

               // color: inFocus ? Colors.md3.primary : thisMonitor ? Colors.md3.on_background: Colors.md3.tertiary_container

               color: {
                  if(special){
                     littleContainers.color = Colors.md3.primary_container
                     return Colors.md3.on_primary_container
                  } else if(inFocus) {
                     return Colors.md3.primary
                  } else if (thisMonitor) {
                     return Colors.md3.on_background
                  } else {
                     return Colors.md3.tertiary_container
                  }

               }

            }

         }
      }

      // Item {
      // 	Layout.fillWidth: true
      // }
   }

}
