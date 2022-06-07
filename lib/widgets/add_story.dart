//Add Story Widget

import 'package:chat_app/utils/constants/custom_colors.dart';
import 'package:chat_app/utils/constants/custom_text.dart';
import 'package:flutter/material.dart';

class AddStory extends StatelessWidget {
  final double radius;
  final Icon icon;
  final String labelText;
  const AddStory({
    required this.radius,
    required this.icon,
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          child: Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.primaryColor(),

              //gradient: CustomColors.primaryColorGradient(),
            ),
            child: icon,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Text(
          labelText,
          style: CustomTextClass.bodyText(
            context,
            darkModeEnabled
                ? CustomColors.whiteVarOne()
                : CustomColors.blackVarOne(),
          ),
        ),
      ],
    );
  }
}
