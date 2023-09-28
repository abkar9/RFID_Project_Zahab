import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class ColorThemeRFID {
  static Color brown = const Color(0xffA18A54);
  static Color white = const Color(0xffffffff);
  static Color blue = const Color(0xff0B79AC);
  static Color lightBlue = Color.fromARGB(123, 11, 121, 172);
  static Color black = const Color(0xff000000);
  static Color lightBrown = Color.fromARGB(87, 161, 138, 84);

  static ThemeData themeLight(BuildContext context) {
    return ThemeData.light().copyWith(
        textTheme: GoogleFonts.elMessiriTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
            color: blue, actionsIconTheme: IconThemeData(color: brown)),
        primaryColor: blue);
  }
}
