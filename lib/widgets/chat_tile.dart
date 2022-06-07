import 'package:chat_app/utils/constants/custom_colors.dart';
import 'package:chat_app/utils/constants/custom_text.dart';
import 'package:flutter/material.dart';

//Chat Tile Widget

class ChatTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String lastMessageTime;
  final bool isOnline;
  final int messageCounter;
  const ChatTile({
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
    required this.messageCounter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.04,
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: CustomColors.blackVarOne(),
        borderRadius: BorderRadius.circular(12),
      ),
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
                  style: CustomTextClass.h2Bold(
                    context,
                    darkModeEnabled ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  lastMessage,
                  style: CustomTextClass.bodyTextSmall(
                    context,
                    darkModeEnabled ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          const Spacer(),

          //End Column

          Column(
            children: [
              //Last Message Time

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  lastMessageTime,
                  style: CustomTextClass.bodyText(
                    context,
                    darkModeEnabled ? Colors.white : Colors.black,
                  ),
                ),
              ),

              //Message Counter

              // ignore: unnecessary_null_comparison
              messageCounter != 0
                  ? Container(
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.primaryColor(),
                      ),
                      child: Text(
                        messageCounter.toString(),
                        style: CustomTextClass.bodyTextSmall(
                          context,
                          CustomColors.white(),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
