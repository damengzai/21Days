import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.blue,
  appBarTheme: AppBarTheme(color: Colors.blue),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  appBarTheme: AppBarTheme(color: Colors.black),
);
