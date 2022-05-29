import 'package:flutter/material.dart';
import 'package:flutter_chat_app/views/auth/signup_page.dart';
import 'package:flutter_chat_app/views/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/custom_colors.dart';

void main(List<String> args) {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: CustomColors.white(),
        brightness: Brightness.light,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: CustomColors.daisyBush(),
          secondary: CustomColors.bittersweet(),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CustomColors.black(),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: CustomColors.daisyBush(),
          secondary: CustomColors.bittersweet(),
        ),
      ),
      home: const SignUpPage(),
    );
  }
}
