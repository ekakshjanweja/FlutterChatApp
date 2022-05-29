import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';
import 'package:flutter_chat_app/widgets/custom_input_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.08,
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              //Logo

              Positioned(
                top: 0,
                child: Image.asset(
                  darkModeEnabled
                      ? "assets/logo_dark.png"
                      : "assets/logo_light.png",
                ),
              ),

              //Greeting

              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                child: Text(
                  'WELCOME',
                  style: CustomTextClass.h1Bold(
                    context,
                    CustomColors.primaryColorLight(),
                  ).copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    letterSpacing: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              //Email Textfield

              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                child: const CustomInput(
                  hintText: 'Email',
                  isObscure: false,
                  leadingIcon: Icon(Icons.email_outlined),
                ),
              ),

              //Password Textfield

              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                child: const CustomInput(
                  hintText: 'Password',
                  isObscure: true,
                  leadingIcon: Icon(Icons.lock_outlined),
                ),
              ),
              //Sign Up Button

              //Log In Instead
            ],
          ),
        ),
      ),
    );
  }
}
