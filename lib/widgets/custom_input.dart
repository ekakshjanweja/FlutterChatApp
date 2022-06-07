import 'package:flutter/material.dart';
import '../utils/constants/custom_colors.dart';
import '../utils/constants/custom_text.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final bool isSearch;
  final IconButton leadingIcon;
  final TextEditingController controller;
  final Function()? onSearch;
  const CustomInput({
    required this.hintText,
    required this.isObscure,
    required this.isSearch,
    required this.leadingIcon,
    required this.controller,
    this.onSearch,
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
            padding: const EdgeInsets.only(left: 10),
            child: leadingIcon,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                obscureText: isObscure,
                controller: controller,
                style: CustomTextClass.bodyText(
                  context,
                  darkModeEnabled ? CustomColors.white() : CustomColors.black(),
                ),
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
          isObscure
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.visibility_off,
                    color: darkModeEnabled
                        ? CustomColors.whiteVarOne()
                        : CustomColors.blackVarOne(),
                  ),
                )
              : Container(),
          isSearch
              ? Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: onSearch,
                    icon: Icon(
                      Icons.search,
                      color: darkModeEnabled
                          ? CustomColors.whiteVarOne()
                          : CustomColors.blackVarOne(),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
