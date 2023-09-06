import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

var darkTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30.0,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        systemNavigationBarColor: HexColor('333739'),
      ),
      titleTextStyle: const TextStyle(
        fontFamily: 'Janna',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      elevation: 20.0,
    ),
    fontFamily: 'Janna',
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        decoration: TextDecoration.none,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ));
var lightTheme = ThemeData(
    textTheme: const TextTheme(
        subtitle1: TextStyle(
          fontFamily: 'Janna',
          height: 1.3,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
        bodyText1: TextStyle(
          fontFamily: 'Janna',
          decoration: TextDecoration.none,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        )),
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Janna',
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.black,
        size: 30.0,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Colors.grey[300]),
      titleTextStyle: const TextStyle(
        fontFamily: 'Janna',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: defaultColor,
      type: BottomNavigationBarType.fixed,
      elevation: 20.0,
    ));
