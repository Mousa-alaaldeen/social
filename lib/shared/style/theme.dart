// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 30,
      actionsIconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      titleTextStyle: GoogleFonts.abyssinicaSil(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 5),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    // backgroundColor: Colors.grey.shade200,
    elevation: 9.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: orange,
    focusColor: orange,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 14,
      height: 1.3,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      titleSpacing: 30,
      actionsIconTheme: IconThemeData(color: Colors.white),
      backgroundColor: HexColor('333739'),
      titleTextStyle: GoogleFonts.abyssinicaSil(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 5),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    elevation: 9.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: orange,
    focusColor: orange,
  ),
  textTheme: TextTheme(
      bodyLarge: TextStyle(
        
          height: 1.3,
          fontWeight: FontWeight.w700,
          color: Colors.white),
      bodySmall: TextStyle(color: Colors.white)),
);
