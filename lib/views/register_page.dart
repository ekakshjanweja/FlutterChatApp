import 'package:chat_app/utils/auth/auth.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:flutter/material.dart';
import '../utils/constants/custom_colors.dart';
import '../utils/constants/custom_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    //Theme

    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);

    //Text Controllers

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneNumberController = TextEditingController();

    //Objects

    Auth auth = Auth();

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

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
                        'Hey, let\'s get you up ',
                        style: CustomTextClass.h1Bold(
                          context,
                          CustomColors.primaryColor(),
                        ),
                      ),
                      Text(
                        'and running.',
                        style: CustomTextClass.h1Bold(
                          context,
                          CustomColors.primaryColor(),
                        ),
                      ),
                    ],
                  ),
                ),

                //Name Field

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.28,
                  child: CustomInput(
                    hintText: 'Name',
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
                    controller: nameController,
                  ),
                ),

                //Phone Field

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.40,
                  child: CustomInput(
                    hintText: 'Phone Number',
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
                    controller: phoneNumberController,
                  ),
                ),

                //Email Field

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.52,
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
                    controller: emailController,
                  ),
                ),

                //Password Field

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.64,
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
                    controller: passwordController,
                  ),
                ),

                //Register button

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.78,
                  child: CustomButton(
                    buttonColor: CustomColors.primaryColor(),
                    buttonText: 'Register',
                    onTap: () {
                      auth.signUpWithEmailAndPassword(
                        email: emailController.text.trim(),
                        name: nameController.text.trim(),
                        password: passwordController.text.trim(),
                        imageUrl:
                            'https://images.unsplash.com/photo-1654525587441-0a1e5a4f985c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                        phoneNumber: phoneNumberController.text.trim(),
                      );
                    },
                  ),
                ),

                //Log In Instead

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.89,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already Have An Account? ',
                        style: TextStyle(
                          color: darkModeEnabled ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Login Instead.',
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
