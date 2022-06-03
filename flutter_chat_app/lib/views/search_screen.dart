import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';
import 'package:flutter_chat_app/views/chat_screen.dart';
import 'package:flutter_chat_app/widgets/chat_tile_widget.dart';
import 'package:flutter_chat_app/widgets/custom_button.dart';
import 'package:flutter_chat_app/widgets/custom_input_widget.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map> searchResults = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      isLoading = true;
      searchResults = [];
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: _searchController.text)
        .get()
        .then(
      (value) {
        if (value.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'No Users Found.',
                style: CustomTextClass.bodyText(
                  context,
                  Colors.white,
                ),
              ),
            ),
          );
          setState(() {
            isLoading = false;
          });
          return;
        }
        value.docs.forEach(
          (user) {
            if (user.data()['email'] !=
                FirebaseAuth.instance.currentUser!.email) {
              searchResults.add(
                user.data(),
              );
            }
          },
        );
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkModeEnabled = (Theme.of(context).brightness == Brightness.dark);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomInput(
                hintText: 'Type Username',
                isObscure: false,
                leadingIcon: Icon(
                  Icons.search,
                  color: darkModeEnabled
                      ? CustomColors.white()
                      : CustomColors.white(),
                ),
                controller: _searchController,
              ),
              if (searchResults.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                  itemCount: searchResults.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: CustomColors.blackVarOne(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatScreen(
                                friendId: searchResults[index]['uid'],
                                friendImageUrl:
                                    'https://images.unsplash.com/photo-1494790108377-'
                                    'be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90b'
                                    'y1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                                friendName: searchResults[index]['name'],
                              );
                            }));
                          },
                          child: ChatTile(
                            imageUrl:
                                'https://images.unsplash.com/photo-1494790108377-'
                                'be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90b'
                                'y1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                            name: searchResults[index]['name'],
                            lastMessage: searchResults[index]['email'],
                            lastMessageTime: '16:32',
                            isOnline: false,
                            messageCounter: index + 1,
                          ),
                        ),
                      ),
                    );
                  },
                ))
              else if (isLoading == true)
                Center(
                  child: CircularProgressIndicator(),
                ),
              CustomButton(
                buttonColor: CustomColors.primaryColor(),
                buttonText: 'Search',
                onTap: () {
                  onSearch();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
