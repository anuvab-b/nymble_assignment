import 'package:flutter/material.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: appBarTheme,
    primaryColor: kPrimaryColor,
    // accentColor: kAccentLightColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      secondary: kSecondaryLightColor,
      background: Colors.white,
      // on light theme surface = Colors.white by default
    ),
    // backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: kPrimaryIconLightColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: kAccentIconLightColor,
    ),
    primaryIconTheme: const IconThemeData(color: kPrimaryIconLightColor),
    textTheme: const TextTheme().copyWith(
      bodyLarge: const TextStyle(color: kBodyTextColorLight),
      bodyMedium: const TextStyle(color: kBodyTextColorLight),
      headlineMedium:
          const TextStyle(color: kTitleTextLightColor, fontSize: 32),
      displayLarge: const TextStyle(color: kTitleTextLightColor, fontSize: 80),
    ),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      useMaterial3: true,
      primaryColor: kPrimaryColor,
      // accentColor: kAccentDarkColor,
      scaffoldBackgroundColor: const Color(0xFF0D0C0E),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.grey[900],
          elevation: 10,
          selectedLabelStyle: TextStyle(
              color: AppColors.onBackgroundDarkColor.withOpacity(0.87),
              fontFamily: "Poppins",
              fontSize: 14.0),
          unselectedLabelStyle: TextStyle(
              color: AppColors.onBackgroundDarkColor.withOpacity(0.60),
              fontFamily: "Poppins",
              fontSize: 12.0),
          selectedItemColor: AppColors.onBackgroundDarkColor.withOpacity(0.87),
          unselectedItemColor:
              AppColors.onBackgroundDarkColor.withOpacity(0.60),
          showUnselectedLabels: true),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.onBackgroundDarkColor)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.onBackgroundDarkColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.onBackgroundDarkColor)),
          hintStyle: TextStyle(
              color: AppColors.onBackgroundDarkColor.withOpacity(0.60)),
          labelStyle: TextStyle(
              color: AppColors.onBackgroundDarkColor.withOpacity(0.87))),
      appBarTheme: appBarTheme,
      colorScheme: const ColorScheme.light(
        secondary: kSecondaryDarkColor,
        surface: kSurfaceDarkColor,
        background: kBackgroundDarkColor,
      ),
      iconTheme: const IconThemeData(color: kBodyTextColorDark),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: kAccentIconDarkColor,
      ),
      primaryIconTheme: const IconThemeData(color: kPrimaryIconDarkColor),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: "Poppins",
            bodyColor: AppColors.onBackgroundDarkColor.withOpacity(0.87),
            displayColor: AppColors.onBackgroundDarkColor.withOpacity(0.6),
          ));
}

AppBarTheme appBarTheme =
    const AppBarTheme(color: kAccentDarkColor, elevation: 0);

// Colors
const kPrimaryColor = Color(0xFFFF97B3);
const kSecondaryLightColor = Color(0xFFE4E9F2);
const kSecondaryDarkColor = Color(0xFF404040);
const kAccentLightColor = Color(0xFFB3BFD7);
const kAccentDarkColor = Color(0xFF4E4E4E);
const kBackgroundDarkColor = Color(0xFF121212);
const kSurfaceDarkColor = Color(0xFF222225);
// Icon Colors
const kAccentIconLightColor = Color(0xFFECEFF5);
const kAccentIconDarkColor = Color(0xFF303030);
const kPrimaryIconLightColor = Color(0xFFECEFF5);
const kPrimaryIconDarkColor = Color(0xFF232323);
// Text Colors
const kBodyTextColorLight = Color(0xFFA1B0CA);
const kBodyTextColorDark = Color(0xFF7C7C7C);
const kTitleTextLightColor = Color(0xFF101112);
const kTitleTextDarkColor = Colors.white;

const kShadowColor = Color(0xFF364564);

class AppColors {
  static const Color darkThemePrimary = Color(0xFF474E68);
  static const Color darkThemePrimaryDark = Color(0xFF404258);
  static const Color darkThemeSecondary = Color(0xFF50577A);
  static const Color darkThemeAccentColor = Color(0xFFB3BFD7);
  static const Color onBackgroundDarkColor = Color(0xFFFFFFFF);
}
