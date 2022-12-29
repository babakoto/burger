import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color backgroundColor = Color(0xff3a3239);
  static const Color primary = Color(0xffB3ADAD);
  static const Color red = Color(0xffBF3838);
  static const Color cardColor = Color(0xffC9A836);
  static const Color grey = Color(0xff898181);

  static final TextTheme _textTheme = TextTheme(
    headline6: GoogleFonts.rajdhani(
      fontWeight: FontWeight.w700,
      fontSize: 18,
    ),
    headline2: GoogleFonts.rajdhani(
      fontWeight: FontWeight.w700,
      fontSize: 27,
    ),
    headline1: GoogleFonts.rajdhani(
      fontWeight: FontWeight.w700,
      fontSize: 40,
    ),
  );

  static ThemeData themes = ThemeData().copyWith(
    backgroundColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: _textTheme,
    hintColor: Colors.white,
    colorScheme: ThemeData().colorScheme.copyWith(secondary: red),
    iconTheme: const IconThemeData(
      color: primary,
      size: 26,
    ),
  );
}
