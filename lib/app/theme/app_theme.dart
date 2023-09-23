import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static bool isLightTheme = true;

  // Light Ui Overlay Style
  static const lightOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.baseLv7,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
  );

  // Dark Ui Overlay Style
  static const darkOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.black,
    statusBarIconBrightness: Brightness.light,
  );

  static ThemeData getTheme() {
    if (isLightTheme) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      titleLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.titleLarge!.color,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.titleMedium!.color,
        fontSize: 15,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.bodySmall!.color,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.bodyLarge?.color,
        fontSize: 14,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.bodyMedium!.color,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.bodySmall!.color,
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.labelLarge!.color,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.labelSmall!.color,
        fontSize: 10,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.titleMedium!.color,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.displayMedium!.color,
        fontSize: 60,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.displaySmall!.color,
        fontSize: 40,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.headlineMedium!.color,
        fontSize: 24,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        color: base.headlineSmall!.color,
        fontSize: 20.5,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(AppColors.primaryColorString);
    Color secondaryColor = HexColor(AppColors.secondaryColorString);

    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      background: AppColors.white,
      error: AppColors.red,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: lightOverlayStyle,
        iconTheme: IconThemeData(
          color: AppColors.base,
        ),
        shadowColor: AppColors.baseLv3,
        // titleSpacing: 0,
      ),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      iconTheme: const IconThemeData(color: Color(0xff2b2b2b)),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      splashColor: Colors.white.withOpacity(0.1),
      hoverColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,
      hintColor: primaryColor,
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      indicatorColor: primaryColor,
      disabledColor: HexColor("#9CA3AF"),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      cardColor: Colors.white,
    );
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(AppColors.primaryColorString);
    Color secondaryColor = HexColor(AppColors.secondaryColorString);

    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      background: const Color(0xff1c1d21),
      error: AppColors.red,
    );

    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.grey[700],
        elevation: 0,
        systemOverlayStyle: darkOverlayStyle,
        iconTheme: const IconThemeData(
          color: AppColors.base,
        ),
        shadowColor: AppColors.baseLv3,
        titleSpacing: 0,
      ),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.black),
      colorScheme: colorScheme,
      iconTheme: const IconThemeData(color: Colors.white),
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      hintColor: secondaryColor,
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: const Color(0xff111827),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      platform: TargetPlatform.iOS,
      disabledColor: HexColor("#6B7280"),
      cardColor: HexColor("#23262F"),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
