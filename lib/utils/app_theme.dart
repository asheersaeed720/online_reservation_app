import 'package:flutter/material.dart';

const String fontName = 'Poppins';

final lightThemeData = ThemeData(
  // colorScheme: ColorScheme.fromSwatch(primarySwatch: customPrimaryColor).copyWith(
  //   secondary: customAccentColor,
  // ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: customPrimaryColor),
  errorColor: Colors.red[800],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: fontName,
);

Map<int, Color> color = const {
  50: Color.fromRGBO(88, 148, 88, .1),
  100: Color.fromRGBO(88, 148, 88, .2),
  200: Color.fromRGBO(88, 148, 88, .3),
  300: Color.fromRGBO(88, 148, 88, .4),
  400: Color.fromRGBO(88, 148, 88, .5),
  500: Color.fromRGBO(88, 148, 88, .6),
  600: Color.fromRGBO(88, 148, 88, .7),
  700: Color.fromRGBO(88, 148, 88, .8),
  800: Color.fromRGBO(88, 148, 88, .9),
};

MaterialColor customPrimaryColor = MaterialColor(0xFF589442, color);
// MaterialColor customAccentColor = MaterialColor(0xFF88C228, color);
