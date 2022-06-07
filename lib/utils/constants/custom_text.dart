import 'package:flutter/material.dart';

class CustomTextClass {
  //Heading 1

  static TextStyle h1Bold(BuildContext context, Color textColor) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.04,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
  }

  //Heading 2

  static TextStyle h2Bold(BuildContext context, Color textColor) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.03,
      fontWeight: FontWeight.bold,
      color: textColor,
    );
  }

  //Body Text

  static TextStyle bodyText(BuildContext context, Color textColor) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.02,
      fontWeight: FontWeight.normal,
      color: textColor,
    );
  }

  //Body Text Small

  static TextStyle bodyTextSmall(BuildContext context, Color textColor) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.height * 0.018,
      fontWeight: FontWeight.normal,
      color: textColor,
    );
  }
}
