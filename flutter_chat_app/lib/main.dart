import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/views/auth/login_page.dart';
import 'package:flutter_chat_app/views/home/home_page.dart';

import 'package:google_fonts/google_fonts.dart';

import 'constants/custom_colors.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  final colorScheme = ColorScheme.fromSeed(
    seedColor: CustomColors.primaryColor(),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //Theme Mode
      themeMode: ThemeMode.system,

      //Theme

      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: CustomColors.white(),
        brightness: Brightness.light,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: CustomColors.primaryColor(),
          secondary: CustomColors.accentColor(),
        ),
      ),

      //Dark Theme

      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CustomColors.black(),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: CustomColors.primaryColor(),
          secondary: CustomColors.accentColor(),
        ),
      ),

      //Home

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LogInPage();
          }
        },
      ),
    );
  }
}
