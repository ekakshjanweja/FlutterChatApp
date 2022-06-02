import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/auth/auth_class.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';
import 'package:flutter_chat_app/main.dart';
import 'package:flutter_chat_app/views/auth/signup_page.dart';
import 'package:flutter_chat_app/views/home/home_page.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_input_widget.dart';
import 'package:flutter_svg/svg.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //Text Controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //Class Objects

  AuthClass _authClass = AuthClass();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.04,
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
                child: CustomInput(
                  hintText: 'Email',
                  isObscure: false,
                  leadingIcon: const Icon(Icons.email_outlined),
                  controller: _emailController,
                ),
              ),

              //Password Textfield

              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                child: CustomInput(
                  hintText: 'Password',
                  isObscure: true,
                  leadingIcon: const Icon(Icons.lock_outlined),
                  controller: _passwordController,
                ),
              ),

              //Sign In Button

              Positioned(
                top: MediaQuery.of(context).size.height * 0.65,
                child: CustomButton(
                  buttonColor: CustomColors.primaryColorLight(),
                  buttonText: 'Login In',
                  onTap: () {
                    _authClass.signInWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                  },
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.78,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColorLight(),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _authClass.signInWitGoogle();
                    },
                    child: SvgPicture.asset(
                      "assets/google_logo.svg",
                      width: 32,
                      color: darkModeEnabled
                          ? CustomColors.blackVarOne()
                          : CustomColors.whiteVarOne(),
                    ),
                  ),
                ),
              ),

              //Log In Instead

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t Have An Account? ',
                      style: TextStyle(
                        color: darkModeEnabled ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Create One.',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
