import 'dart:developer';

import 'package:chat_app/utils/constants/custom_colors.dart';
import 'package:chat_app/utils/constants/custom_text.dart';
import 'package:chat_app/utils/helpers/helpers.dart';
import 'package:chat_app/utils/models/user_model.dart';
import 'package:chat_app/views/home_page.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navigatorKey,

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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something Went Wrong Try Again.',
                style: CustomTextClass.bodyText(
                  context,
                  Colors.white,
                ),
              ),
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
