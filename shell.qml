import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "./themes"
import "./components"

Variants {

   model: Quickshell.screens

   // Actual Panel itself
   Bar {
      required property var modelData
      screen: modelData
   }

}
