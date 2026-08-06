import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Widgets
import "../../themes"

PopupWindow{
   id: popup
   color: "red"
   implicitWidth: 700
   implicitHeight: 400

   Rectangle {
      // color: "red"
      id: background

      implicitHeight: 400
      implicitWidth: 700
      color: Qt.alpha(Colors.md3.surface, 0.95)
      radius: 12

      property var osInfo
      property var fastfetchConfig: new URL(Qt.resolvedUrl("../assets/fffuv.json")).pathname

      Process {
         running: true
         command: ["fastfetch", "--config", background.fastfetchConfig]
         stdout: StdioCollector {
            onStreamFinished: {
               // console.log(this.text)
               // console.log(new URL(Qt.resolvedUrl("../assets/fffuv.json")).pathname)

               background.osInfo = this.text
            }
         }

      }

      ColumnLayout{
         anchors {
            fill: parent
            margins: 20
         }
         Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            color: Qt.alpha(Colors.md3.primary_container, .6)
            radius: 12
            border {
               color: Colors.md3.primary
            }

            implicitWidth: fastfetchoutput.implicitWidth + 50
            implicitHeight: fastfetchoutput.implicitHeight + 50

            RowLayout {
               anchors.centerIn: parent
               Text {
                  id: fastfetchoutput
                  color: Colors.md3.on_primary_container
                  font {pixelSize: 9; family: "JetBrainsMono Nerd Font Mono"}
                  // text: "Arch Linux"
                  text: background.osInfo
               }
            }

         }
      }

   }

}
