import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/views/auth/login_page.dart';
import 'package:flutter_chat_app/views/auth/signup_page.dart';
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
  isUserSignedIn() {}
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
      // home: FutureBuilder(
      //   future: isUserSignedIn(),
      //   builder: (context, AsyncSnapshot<Widget> snapshot) {
      //     if (snapshot.hasData) {
      //       return snapshot.data!;
      //     }
      //     return Scaffold(
      //       body: Center(
      //         child: CircularProgressIndicator(
      //             color: CustomColors.primaryColorLight()),
      //       ),
      //     );
      //   },
      // ),
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
