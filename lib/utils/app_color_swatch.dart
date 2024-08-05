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


  static const Color cardColorDark = Color(0xff262626);
  static const Color cardColorLight = Color(0xffF4F9FF);

  static const Color topBarColorDark = Color(0xff262626);
  static const Color topBarColorLight = Color(0xffFFFFFF);

  static const Color bgContainerColorDark = Color(0xff000000);
  static const Color bgContainerColorLight = Color(0xffFFFFFF);

  static const Color bgBarColorDark = Color(0xff333333);
  static const Color bgBarColorLight = Color(0xff333333);

  static const Color iconTextColorDark = Color(0xffD9D9D9);
  static const Color iconTextColorLight = Color(0xff000000);

  static const Color titleTextColorDark = Color(0xffFFFFFF);
  static const Color titleTextColorLight = Color(0xff262626);

  static const Color switchColorDark = Color(0xFFA7A7A7);
  static const Color switchColorLight = Color(0xffD9D9D9);

  static const Color badgeColorDark = Color(0xFF4F4F50);
  static const Color badgeColorLight = Color(0xffE5F1FF);

  static const Color badgeTextColorDark = Color(0xff262626);
  static const Color badgeTextColorLight = Color(0xff262626);


  static const Color siteCardColorDark = Color(0xffFFFFFF);
  static const Color siteCardColorLight = Color(0xffF4F9FF);


  static const Color blue = Color(0xff365880);

// Define other custom colors if needed
// static const MaterialColor customAccentColor = MaterialColor(...);
}
