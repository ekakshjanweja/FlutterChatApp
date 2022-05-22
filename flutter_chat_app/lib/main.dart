import 'package:flutter/material.dart';
import 'package:flutter_chat_app/views/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomePage(),
    );
  }
}
