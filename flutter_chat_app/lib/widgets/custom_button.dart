import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  final Color buttonColor;
  const CustomButton({
    required this.buttonColor,
    required this.buttonText,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          buttonText,
          style: CustomTextClass.h3Bold(
            context,
            CustomColors.white(),
          ).copyWith(
            letterSpacing: 5,
          ),
        ),
      ),
    );
  }
}
