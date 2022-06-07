import 'dart:async';

import 'package:chat_app/main.dart';
import 'package:chat_app/utils/auth/auth.dart';
import 'package:chat_app/views/home_page.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants/custom_colors.dart';
import '../utils/constants/custom_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //Objects

  final Auth _auth = Auth();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Theme

    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02,
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
                  top: MediaQuery.of(context).size.height * 0.13,
                  left: MediaQuery.of(context).size.width * 0.04,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey,',
                        style: CustomTextClass.h1Bold(
                          context,
                          CustomColors.primaryColor(),
                        ),
                      ),
                      Text(
                        'Welcome Back.',
                        style: CustomTextClass.h1Bold(
                          context,
                          CustomColors.primaryColor(),
                        ),
                      ),
                    ],
                  ),
                ),

                //Email Field

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.28,
                  child: CustomInput(
                    hintText: 'Email',
                    isObscure: false,
                    isSearch: false,
                    leadingIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.email_outlined,
                        color: darkModeEnabled
                            ? CustomColors.whiteVarOne()
                            : CustomColors.blackVarOne(),
                      ),
                    ),
                    controller: _emailController,
                  ),
                ),

                //Password Field

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: CustomInput(
                    hintText: 'Password',
                    isObscure: true,
                    isSearch: false,
                    leadingIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.lock_outline_rounded,
                        color: darkModeEnabled
                            ? CustomColors.whiteVarOne()
                            : CustomColors.blackVarOne(),
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ),

                //Login button

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.55,
                  child: CustomButton(
                    buttonColor: CustomColors.primaryColor(),
                    buttonText: 'Sign In',
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                      _auth.signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      navigatorKey.currentState!.pop();
                    },
                  ),
                ),

                //Google Login Button

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      Text(
                        'Or login using google?',
                        style: CustomTextClass.bodyText(
                          context,
                          darkModeEnabled
                              ? CustomColors.whiteVarOne()
                              : CustomColors.blackVarOne(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: CustomColors.primaryColor(),
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _auth.signInWithGoogle();
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
                    ],
                  ),
                ),

                //Log In Instead

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.88,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
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
      ),
    );
  }
}
