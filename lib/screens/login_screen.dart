// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 150.0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Image(
                        image: AssetImage("images/VectorUp.png"),
                      ),
                    ),
                    Center(
                      child: Text(
                        "chat-ions",
                        style: TextStyle(
                            color: Color(0xFF9A80D2),
                            fontSize: 50.0,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: 300.0,
                    height: 70.0,
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                      keyboardType:
                          TextInputType.phone,
                      cursorColor: Color(0xFF9A80D2),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        fillColor: Color(0xFF171819),
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.phone,
                            color: Color(0xFF9A80D2),
                          ),
                        ),
                        hintText: "Enter Phone Number",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 18.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0XFF9A80D2),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: SizedBox(
                    width: 150.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF5A428E),
                            Color(0xFF9A80D2),
                          ],
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          print("Get OTP");
                        },
                        child: Text(
                          "Get OTP",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    "OR",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print("Google");
                        },
                        child: Image(
                          image: AssetImage("images/google.png"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Facebook");
                        },
                        child: Image(
                          image: AssetImage("images/facebook.png"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Apple");
                        },
                        child: Image(
                          image: AssetImage("images/apple.png"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Positioned(
                    child: Image(
                      image: AssetImage("images/VectorDown.png"),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Create one");
                          },
                          child: Text(
                            "Create one.",
                            style: TextStyle(
                              color: Color(0xFF1C82DF),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
