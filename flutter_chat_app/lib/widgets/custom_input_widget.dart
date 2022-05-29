import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final Icon leadingIcon;
  const CustomInput({
    required this.hintText,
    required this.isObscure,
    required this.leadingIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: darkModeEnabled
            ? CustomColors.blackVarOne()
            : CustomColors.whiteVarOne(),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: leadingIcon,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                obscureText: isObscure,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: CustomTextClass.bodyText(
                    context,
                    darkModeEnabled
                        ? CustomColors.white()
                        : CustomColors.black(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
