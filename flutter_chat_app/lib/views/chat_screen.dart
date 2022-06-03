import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';
import 'package:flutter_chat_app/widgets/custom_input_widget.dart';
import 'package:flutter_chat_app/widgets/message_textfield.dart';

class ChatScreen extends StatefulWidget {
  final String friendId;
  final String friendName;
  final String friendImageUrl;
  const ChatScreen({
    required this.friendId,
    required this.friendImageUrl,
    required this.friendName,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //App Bar
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              color: CustomColors.primaryColor(),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: CustomColors.white(),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.friendImageUrl,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.friendName,
                    style:
                        CustomTextClass.h3Bold(context, CustomColors.white()),
                  ),
                ],
              ),
            ),

            //Message Box

            MessagetextField(
              currentId: user!.uid,
              friendId: widget.friendId,
            ),
          ],
        ),
      ),
    );
  }
}
