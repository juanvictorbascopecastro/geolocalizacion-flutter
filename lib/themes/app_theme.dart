import 'package:flutter/material.dart';

class AppTheme {
  // static const Color primary = Colors.indigo;
  static const Color primary = Color(0xFF00C3A5);
  static const Color grey = Colors.grey;
  static const Color primary_2 = Color.fromRGBO(0, 131, 107, 1.0);

  static final ThemeData lishtTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 0
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: primary)
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(
          color: primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
          ),
        ),
      ),
  );

  static final ThemeData darkTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 0
      ),
      scaffoldBackgroundColor: Colors.black
  );
}