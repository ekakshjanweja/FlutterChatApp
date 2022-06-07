import 'package:chat_app/utils/constants/custom_colors.dart';
import 'package:chat_app/utils/constants/custom_text.dart';
import 'package:chat_app/widgets/message_box.dart';
import 'package:chat_app/widgets/message_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPage extends StatefulWidget {
  final String friendId;
  final String friendName;
  final String friendImageUrl;
  const ChatPage({
    required this.friendId,
    required this.friendImageUrl,
    required this.friendName,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    //Theme

    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);

    //Text Controllers

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
                        CustomTextClass.h2Bold(context, CustomColors.white()),
                  ),
                ],
              ),
            ),

            //Chats

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                ),
                color: Colors.transparent,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .orderBy(
                        'date',
                        descending: true,
                      )
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length < 1) {
                        return Center(
                          child: Text(
                            'Say Hi',
                            style: CustomTextClass.h2Bold(
                              context,
                              darkModeEnabled
                                  ? CustomColors.blackVarOne()
                                  : CustomColors.whiteVarOne(),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isCurrentUser = snapshot.data.docs[index]
                                  ['senderId'] ==
                              FirebaseAuth.instance.currentUser!.uid;
                          return MessageBox(
                            message: snapshot.data.docs[index]['message'],
                            isCurrentUser: isCurrentUser,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),

            //Message Box

            MessagetextField(
              currentId: FirebaseAuth.instance.currentUser!.uid,
              friendId: widget.friendId,
            ),

            // Text(
            //   widget.friendId,
            //   style: CustomTextClass.bodyText(context, Colors.white),
            // ),
            // Text(
            //   widget.friendName,
            //   style: CustomTextClass.bodyText(context, Colors.white),
            // ),
            // Image.network(widget.friendImageUrl.toString()),
            // Text(
            //   FirebaseAuth.instance.currentUser!.displayName.toString(),
            //   style: CustomTextClass.bodyText(context, Colors.white),
            // ),
          ],
        ),
      ),
    );
  }
}
