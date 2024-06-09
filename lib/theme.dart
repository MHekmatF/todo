import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = const Color(0xFF5D9CEC);
  static Color backgroundColorLight = const Color(0xFFDFECDB);
  static Color backgroundColorDark = const Color(0xFF060E1E);
  static Color green = const Color(0xFF61E757);
  static Color red = const Color(0xFFEC4B4B);
  static Color black = const Color(0xFF141922);
  static Color grey = const Color(0xFFC8C9CB);
  static Color white = const Color(0xFFFFFFFF);

  static ThemeData lightTheme = ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: backgroundColorLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: grey,
          selectedItemColor: primary),
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: primary,
          titleTextStyle: TextStyle(
              color: white, fontWeight: FontWeight.bold, fontSize: 22)),
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: grey.withOpacity(0.8),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: primary,
            width: 2,
          ))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          backgroundColor: primary,
          /*
        * double.infinity take max size  parent allow
        * can't use double.infinity here
        *
        * */
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            foregroundColor: AppTheme.black),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: primary,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: black,
        ),
        bodyLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: black,
        ),
        titleMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: black,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(
          side: BorderSide(color: white, width: 4),
        ),
      ));

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
    ),
  );
}
