import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  //Primary Color

  static Color daisyBush() {
    return const Color(0xff5A428E);
  }

  //Dark Cyan

  static Color darkCyan() {
    return const Color(0xff087E8B);
  }

  //Bitter Sweet

  static Color bittersweet() {
    return const Color(0xffFF5A5F);
  }

  //Black

  static Color black() {
    return const Color(0xFF0A0A0A);
  }

  static Color blackVarOne() {
    return const Color(0xFF171819);
  }

  //White

  static Color white() {
    return const Color(0xFFFCF9F4);
  }

  static Color whiteVarOne() {
    return const Color(0xFFECECEC);
  }

  //Primary Color Dark

  static Color primaryColorDark() {
    return const Color(0xFF311F58);
  }

  //Primary Color Light

  static Color primaryColorLight() {
    return const Color(0xFFA283E7);
  }

  //Primary Color Gradient

  static LinearGradient primaryColorGradient() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        primaryColorDark(),
        primaryColorLight(),
      ],
    );
  }

  //Check Dark Mode

  bool checkIfDarkModeEnabled(BuildContext context) {
    bool darkModeEnabled = false;
    final ThemeData theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      darkModeEnabled = true;
    }
    return darkModeEnabled;
  }
}
