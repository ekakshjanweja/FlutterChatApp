import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';

import '../../constants/custom_colors.dart';

//Add Story Widget

class AddStoryWidget extends StatelessWidget {
  final double radius;
  final Icon icon;
  final String labelText;
  const AddStoryWidget({
    required this.radius,
    required this.icon,
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              color: CustomColors.daisyBush(),

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
            Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

//Story Widget

class StoryWidget extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final String labelText;
  final bool showBorder;
  const StoryWidget({
    required this.radius,
    required this.imageUrl,
    required this.labelText,
    required this.showBorder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: showBorder
                  ? Border.all(
                      color: CustomColors.primaryColorLight(),
                      width: 2,
                    )
                  : null,
            ),
            child: Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.daisyBush(),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Text(
          labelText,
          style: CustomTextClass.bodyText(
            context,
            Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
