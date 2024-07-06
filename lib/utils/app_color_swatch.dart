import 'package:flutter/material.dart';

// Define a custom Color Swatch
class AppColorSwatch {
  static const MaterialColor customBlack = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color.fromRGBO(0, 0, 0, .1),
      100: Color.fromRGBO(0, 0, 0, .2),
      200: Color.fromRGBO(0, 0, 0, .3),
      300: Color.fromRGBO(0, 0, 0, .4),
      400: Color.fromRGBO(0, 0, 0, .5),
      500: Color.fromRGBO(0, 0, 0, .6),
      600: Color.fromRGBO(0, 0, 0, .7),
      700: Color.fromRGBO(0, 0, 0, .8),
      800: Color.fromRGBO(0, 0, 0, .9),
      900: Color.fromRGBO(0, 0, 0, 1),
    },
  );

  static const MaterialColor customWhite = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color.fromRGBO(255, 255, 255, .1),
      100: Color.fromRGBO(255, 255, 255, .2),
      200: Color.fromRGBO(255, 255, 255, .3),
      300: Color.fromRGBO(255, 255, 255, .4),
      400: Color.fromRGBO(255, 255, 255, .5),
      500: Color.fromRGBO(255, 255, 255, .6),
      600: Color.fromRGBO(255, 255, 255, .7),
      700: Color.fromRGBO(255, 255, 255, .8),
      800: Color.fromRGBO(255, 255, 255, .9),
      900: Color.fromRGBO(255, 255, 255, 1),
    },
  );

  static const Color appBarColor = Color(0xFF000000);

  static const Color appChipColor = Color(0xFFFF7A00);

  static const Color appDrawBgCOlor = Color.fromRGBO(46, 46, 46, 1);

// Define other custom colors if needed
// static const MaterialColor customAccentColor = MaterialColor(...);
}
