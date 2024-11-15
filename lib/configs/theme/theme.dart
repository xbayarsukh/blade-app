import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color light = Colors.white;
  static const Color dark = Color(0xff000000);

  static const Color primary = Color(0xff182247);
  static const Color second = Color(0xff182247);

  static const Color lighterGray = Color(0xfff8f8f8);
  static const Color lightGray = Color(0xfff1f1f1);
  static const Color gray = Color(0xff717171);
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xff1f1f1f);

  static const Color bg = Color(0xffffffff);

  static const Color red = Color.fromARGB(255, 255, 0, 0);
  static const Color blue = Color(0xff2196F3);
  static const Color orange = Color(0xffFF9C09);
  static const Color green = Color(0xff2EC365);
  static const Color borderLine = Color(0xffDADADA);

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.light,
    scaffoldBackgroundColor: dark,
    primaryColor: light,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      // Primary
      primary: primary,
      onPrimary: light,
      onPrimaryContainer: dark,
      primaryContainer: light,

      //Secondary
      secondary: second,
      onSecondary: light,
      secondaryContainer: dark,
      onSecondaryContainer: light,
      //Background
      surface: light,
      //Error
      error: primary,
      // errorContainer: primaryAccent,
      inversePrimary: dark,
    ),
    appBarTheme: const AppBarTheme(
      color: dark,
      titleTextStyle: _titleLightLarge,
      iconTheme: IconThemeData(color: bg, size: 18),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(color: gray.withOpacity(.75)),
    textTheme: _lightTheme,
    iconTheme: const IconThemeData(
      color: bg,
      opacity: 1,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: dark,
    primaryColor: dark,
    appBarTheme: const AppBarTheme(
      color: dark,
      titleTextStyle: _titleLightLarge,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: bg),
    ),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      // Primary
      primary: primary,
      onPrimary: dark,
      onPrimaryContainer: light,
      primaryContainer: dark,

      //Secondary
      secondary: second,
      onSecondary: second,
      secondaryContainer: light,
      onSecondaryContainer: dark,
      //Background
      surface: dark,
      //Error
      error: primary,
      // errorContainer: primaryAccent,
      inversePrimary: dark,
    ),
    dividerTheme: DividerThemeData(color: gray.withOpacity(.75)),
    textTheme: _darkTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: light,
        backgroundColor: primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        disabledForegroundColor: lightGray,
        disabledBackgroundColor: gray.withOpacity(.75),
      ),
    ),
    iconTheme: const IconThemeData(
      color: bg,
      opacity: 1,
    ),
  );

  static const TextTheme _lightTheme = TextTheme(
    displayLarge: _displayLightLarge,
    displayMedium: _displayLightMedium,
    displaySmall: _displayLightSmall,
    headlineLarge: _headlineLightLarge,
    headlineMedium: _headlineLightMedium,
    headlineSmall: _headlineLightSmall,
    bodyLarge: _bodyLightLarge,
    bodyMedium: _bodyLightMedium,
    bodySmall: _bodyLightSmall,
    titleSmall: _titleLightSmall,
    titleMedium: _titleLightMedium,
    titleLarge: _titleLightLarge,
  );

  static const TextTheme _darkTheme = TextTheme(
    displayLarge: _displayDarkLarge,
    displayMedium: _displayDarkMedium,
    displaySmall: _displayDarkSmall,
    headlineLarge: _headlineDarkLarge,
    headlineMedium: _headlineDarkMedium,
    headlineSmall: _headlineDarkSmall,
    bodyLarge: _bodyDarkLarge,
    bodyMedium: _bodyDarkMedium,
    bodySmall: _bodyDarkSmall,
    titleSmall: _titleDarkSmall,
    titleMedium: _titleDarkMedium,
    titleLarge: _titleDarkLarge,
  );

  static const headLarge = 26.0;

  static const headMedium = 18.0;

  static const headSmall = 16.0;

  static const titleSmallFontSize = 14.0;

  static const bodyLargeFontSize = 16.0;

  static const bodyMediumFontSize = 14.0;

  static const bodySmallFontSize = 12.0;

  // LIGHT TEXT THEME
  static const TextStyle _displayLightLarge = TextStyle(
    fontSize: headLarge,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _displayLightMedium = TextStyle(
    fontSize: headMedium,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _displayLightSmall = TextStyle(
    fontSize: headSmall,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _headlineLightLarge = TextStyle(
    fontSize: headLarge,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _headlineLightMedium = TextStyle(
    fontSize: headMedium,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _headlineLightSmall = TextStyle(
    fontSize: headSmall,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _bodyLightLarge = TextStyle(
    fontSize: bodyLargeFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _bodyLightMedium = TextStyle(
    fontSize: bodyMediumFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _bodyLightSmall = TextStyle(
    fontSize: bodySmallFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _titleLightSmall = TextStyle(
    fontSize: titleSmallFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _titleLightMedium = TextStyle(
    fontSize: headSmall,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _titleLightLarge = TextStyle(
    fontSize: headMedium,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  // DARK TEXT THEME
  static const TextStyle _displayDarkLarge = TextStyle(
    fontSize: headLarge,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _displayDarkMedium = TextStyle(
    fontSize: headMedium,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _displayDarkSmall = TextStyle(
    fontSize: headSmall,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _headlineDarkLarge = TextStyle(
    fontSize: headLarge,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _headlineDarkMedium = TextStyle(
    fontSize: headMedium,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _headlineDarkSmall = TextStyle(
    fontSize: headSmall,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _bodyDarkLarge = TextStyle(
    fontSize: bodyLargeFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _bodyDarkMedium = TextStyle(
    fontSize: bodyMediumFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _bodyDarkSmall = TextStyle(
    fontSize: bodySmallFontSize,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _titleDarkSmall = TextStyle(
    fontSize: titleSmallFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _titleDarkMedium = TextStyle(
    fontSize: headSmall,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle _titleDarkLarge = TextStyle(
    fontSize: headMedium,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  // CUSTOM TEXTSTYLES

  static const TextStyle hintStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle subtitleGray14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle subtitleLightGray14 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static TextStyle subtitleDarkGray14 = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle subtitleGray12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle subtitleLightGray12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static TextStyle subtitleDarkGray12 = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle subtitleBlack12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );

  static const TextStyle subtitleWhite12 = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: "OpenSans",
  );
}
