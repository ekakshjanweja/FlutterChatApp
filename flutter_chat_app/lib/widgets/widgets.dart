import 'package:flutter/material.dart';
import '../constants/custom_colors.dart';
import '../constants/custom_text.dart';

//Chat Tile Widget

class ChatTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String lastMessageTime;
  final bool isOnline;
  const ChatTile({
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Picture Of Chat

          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imageUrl,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.025,
                  width: MediaQuery.of(context).size.height * 0.025,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isOnline ? Colors.green : Colors.transparent,
                    border: isOnline
                        ? Border.all(
                            color: CustomColors.black(),
                            width: 4,
                          )
                        : Border.all(
                            width: 0,
                          ),
                  ),
                ),
              ),
            ],
          ),

          //Name And Last Message

          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: CustomTextClass.h3Bold(
                    context,
                    Colors.white,
                  ),
                ),
                Text(
                  lastMessage,
                  style: CustomTextClass.bodyTextSmall(
                    context,
                    Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          const Spacer(),

          //Last Message Time

          Text(
            lastMessageTime,
            style: CustomTextClass.bodyText(
              context,
              CustomColors.white(),
            ),
          ),
        ],
      ),
    );
  }
}
