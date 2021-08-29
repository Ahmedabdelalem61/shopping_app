import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_todo/shared/components/constants.dart';

ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
        body1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white)),
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        backgroundColor: HexColor('333739')),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: HexColor('333739')));
ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
        body1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black)),
    primarySwatch: defaultColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.white));