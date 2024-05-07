part of '../config.dart';
class MyThemApp {
  static ThemeData themeData(BuildContext context) {
    return ThemeData.light().copyWith(
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        displayLarge: GoogleFonts.cairo(
          color: black,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
