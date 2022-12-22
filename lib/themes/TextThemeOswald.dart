import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme TextThemeOswald(Color color) {
  return TextTheme(
    headline1: GoogleFonts.oswald(
      fontSize: 93,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: color,
    ),
    headline2: GoogleFonts.oswald(
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: color,
    ),
    headline3: GoogleFonts.oswald(
      fontSize: 46,
      fontWeight: FontWeight.w400,
      color: color,
    ),
    headline4: GoogleFonts.oswald(
      fontSize: 33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: color,
    ),
    headline5: GoogleFonts.oswald(
      fontSize: 23,
      fontWeight: FontWeight.w400,
      color: color,
    ),
    headline6: GoogleFonts.oswald(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: color,
    ),
    subtitle1: GoogleFonts.oswald(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: color,
    ),
    subtitle2: GoogleFonts.oswald(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: color,
    ),
    bodyText1: GoogleFonts.oswald(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: color,
    ),
    bodyText2: GoogleFonts.oswald(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: color,
    ),
    button: GoogleFonts.oswald(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: color,
    ),
    caption: GoogleFonts.oswald(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: color,
    ),
    overline: GoogleFonts.oswald(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: color,
    ),
  );
}
