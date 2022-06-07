import 'package:chat_app/utils/constants/custom_colors.dart';
import 'package:chat_app/utils/constants/custom_text.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const MessageBox({
    required this.message,
    required this.isCurrentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
          decoration: BoxDecoration(
            color: isCurrentUser
                ? CustomColors.primaryColor()
                : CustomColors.blackVarOne(),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            message,
            style: CustomTextClass.bodyText(context, Colors.white),
          ),
        )
      ],
    );
  }
}
