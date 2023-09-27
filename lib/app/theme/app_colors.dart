import 'package:flutter/material.dart';

// App Colors
class AppColors {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppColors._();

  // Main App Color
  static MaterialColor mainColor = createMaterialColor(primary);

  // Convert Color into MaterialColor
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  // Native Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;

  static const primaryColorString = '#3772FF';
  static const secondaryColorString = '#22C55E';

  // Main Colors
  static const Color base = Color(0xFF141416);
  static const Color primary = Color(0xFF3772FF);
  static const Color secondary = Color(0xFF22C55E);
  static const Color sea = Color(0xFF08CCCC);
  static const Color yellow = Color(0xFFFFB800);
  static const Color pink = Color(0xFFFF61D3);

  // Red
  static const Color red = Color(0xFFFE1A59);
  static const Color redLv7 = Color(0xFFffd9e3);

  // Base subcolors
  static const Color baseLv2 = Color(0xFF23262F);
  static const Color baseLv3 = Color(0xFF353945);
  static const Color baseLv4 = Color(0xFF777E90);
  static const Color baseLv5 = Color(0xFFB1B5C3);
  static const Color baseLv6 = Color(0xFFE6E8EC);
  static const Color baseLv7 = Color(0xFFF4F5F6);
  static const Color baseLv8 = Color(0xFFFCFCFD);

  // Primary subcolors
  static const Color primaryLv2 = Color(0xFF23262F);
  static const Color primaryLv3 = Color(0xFF353945);
  static const Color primaryLv4 = Color(0xFFB1B5C3);
  static const Color primaryLv5 = Color(0xFFB1B5C3);
  static const Color primaryLv6 = Color(0xFFE6E8EC);
  static const Color primaryLv7 = Color(0xFFF4F5F6);
  static const Color primaryLv8 = Color(0xFFFCFCFD);

  // Tangerine
  static const Color tangerine = Color(0xFFfd9f34);

  // Green
  static const Color greenLv1 = Color(0xFF07BD74);
  static const Color greenLv2 = Color(0xFF28C687);
  static const Color greenLv3 = Color(0xFF49CF99);
  static const Color greenLv4 = Color(0xFF6AD7AC);
  static const Color greenLv5 = Color(0xFF8BE0BE);
  static const Color greenLv6 = Color(0xFFACE9D1);
  static const Color greenLv7 = Color(0xFFCDF2E3);

  // Gradient Text
  static const Color darkBlue = Color(0xFF0500FF);
  static const Color lightBlue = Color(0xFF01C8F4);
}
