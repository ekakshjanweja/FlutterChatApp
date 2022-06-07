import 'dart:developer';
import 'package:chat_app/utils/auth/auth.dart';
import 'package:chat_app/utils/constants/custom_text.dart';
import 'package:chat_app/utils/models/user_model.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/views/login_page.dart';
import 'package:chat_app/views/search_page.dart';
import 'package:chat_app/widgets/add_story.dart';
import 'package:chat_app/widgets/chat_tile.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/constants/custom_colors.dart';
import '../widgets/story.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables

  final currentUser = FirebaseAuth.instance.currentUser;

  //Objects

  final Auth _auth = Auth();

  //Get Users

  getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // log(userData.data().toString());

    // UserModel userModel = UserModel.fromJson(userData.data());

    // userData.data()!.forEach((key, value) {});

    // QuerySnapshot snapshot =
    //     await FirebaseFirestore.instance.collection('users').get();

    // for (var doc in snapshot.docs) {
    //   log(doc.data().toString());
    // }
    // print('Log 2');
    // log(snapshot.docs.toString());
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  //User Collection Reference

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    //Theme

    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.primaryColor(),
          onPressed: () {},
          child: Icon(
            Icons.group_add,
            color:
                darkModeEnabled ? CustomColors.white() : CustomColors.white(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
              vertical: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Upper Section

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chats',
                      style: CustomTextClass.h1Bold(
                        context,
                        darkModeEnabled
                            ? CustomColors.white()
                            : CustomColors.black(),
                      ),
                    ),
                    Row(
                      children: [
                        //Logout Button

                        IconButton(
                          onPressed: () {
                            _auth.signOut();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.logout_outlined,
                            color: darkModeEnabled
                                ? CustomColors.white()
                                : CustomColors.black(),
                          ),
                        ),

                        const SizedBox(
                          width: 20,
                        ),

                        //Search Button

                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchPage(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.search,
                            color: darkModeEnabled
                                ? CustomColors.white()
                                : CustomColors.black(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //Stories Section

                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.2,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     physics: const BouncingScrollPhysics(),
                //     children: [
                //       //Add Story Button

                //       AddStory(
                //         radius: MediaQuery.of(context).size.height * 0.08,
                //         icon: const Icon(
                //           Icons.add,
                //           color: Colors.white,
                //         ),
                //         labelText: 'Add Story',
                //       ),

                //       //Other Stories

                //       ListView(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         children: List.generate(
                //           5,
                //           (index) => StoryWidget(
                //             radius: MediaQuery.of(context).size.height * 0.08,
                //             imageUrl:
                //                 'https://images.unsplash.com/photo-1494790108377-'
                //                 'be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90b'
                //                 'y1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                //             labelText: 'John Doe',
                //             showBorder: true,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                //Chats Section

                SizedBox(
                  height: MediaQuery.of(context).size.height * 2,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('messages')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length < 1) {
                          return Center(
                            child: Text(
                              'No Chats Available.',
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
                          itemBuilder: (context, index) {
                            var friendId = snapshot.data.docs[index].id;
                            var lastMessage =
                                snapshot.data.docs[index]['last_message'];
                            return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(friendId)
                                  .get(),
                              builder: (context, AsyncSnapshot asyncSnapshot) {
                                if (asyncSnapshot.hasData) {
                                  var friend = asyncSnapshot.data;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ChatPage(
                                              friendId: friend['uid'],
                                              friendImageUrl:
                                                  friend['imageUrl'],
                                              friendName: friend['name'],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: ChatTile(
                                      imageUrl: friend['imageUrl'],
                                      name: friend['name'],
                                      lastMessage: lastMessage,
                                      lastMessageTime: '16:32',
                                      isOnline: false,
                                      messageCounter: 1,
                                    ),
                                  );
                                }
                                return const CircularProgressIndicator();
                              },
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
