import 'package:flutter/material.dart';

class ColorManager {
  // Primary color for the buttons ("Start Module")
  static Color primary = HexColor.fromHex("#00A8E8"); // Light Blue

  // Secondary color for the progress bar and active elements
  static Color secondary = HexColor.fromHex("#00B2A9"); // Teal Green

  static Color darkGrey = HexColor.fromHex("#525252"); // Dark Grey
  static Color grey = HexColor.fromHex("#737477"); // Grey
  static Color lightGrey = HexColor.fromHex("#9E9E9E"); // Light Grey
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728"); // Primary color with 70% opacity
  static Color darkPrimary = HexColor.fromHex("#d17d11"); // Darker shade of primary (orange, if needed elsewhere)
  static Color grey1 = HexColor.fromHex("#707070"); // Grey variation
  static Color grey2 = HexColor.fromHex("#797979"); // Another grey variation
  static Color white = HexColor.fromHex("#FFFFFF"); // White
  static Color error = HexColor.fromHex("#e61f34"); // Error red
}


extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}