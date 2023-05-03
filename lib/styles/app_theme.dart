import 'package:flutter/material.dart';

class AppTheme {
  static final Color inputFillColor = Colors.grey.shade200;

  static ThemeData data() => ThemeData(
        primarySwatch: Colors.orange,
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: inputFillColor,
            helperStyle: const TextStyle(color: Colors.black)),
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      );
}
