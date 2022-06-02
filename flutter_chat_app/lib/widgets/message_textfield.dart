import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';

class MessagetextField extends StatefulWidget {
  final String? currentId;
  final String friendId;
  const MessagetextField({
    required this.currentId,
    required this.friendId,
    Key? key,
  }) : super(key: key);

  @override
  State<MessagetextField> createState() => _MessagetextFieldState();
}

class _MessagetextFieldState extends State<MessagetextField> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: darkModeEnabled
            ? CustomColors.blackVarOne()
            : CustomColors.whiteVarOne(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: CustomTextClass.bodyText(
                context,
                darkModeEnabled ? CustomColors.white() : CustomColors.black(),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type your message here....',
                hintStyle: CustomTextClass.bodyText(
                  context,
                  darkModeEnabled ? CustomColors.white() : CustomColors.black(),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: CustomColors.primaryColorLight(),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () async {
                String message = _messageController.text;
                _messageController.clear();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .collection('chats')
                    .add({
                  'senderId': widget.currentId,
                  'receiverId': widget.friendId,
                  'message': message,
                  'type': 'text',
                  'date': DateTime.now(),
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .set({
                    'last_message': message,
                  });
                });

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.friendId)
                    .collection('messages')
                    .doc(widget.currentId)
                  ..collection('chats').add({
                    'senderId': widget.currentId,
                    'receiverId': widget.friendId,
                    'message': message,
                    'type': 'text',
                    'date': DateTime.now(),
                  }).then((value) => {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.friendId)
                            .collection('messages')
                            .doc(widget.currentId)
                            .set({
                          'last_message': message,
                        })
                      });
              },
              icon: Icon(
                Icons.send,
                color: CustomColors.white(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
