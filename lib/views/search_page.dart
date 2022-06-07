import 'package:chat_app/utils/constants/custom_colors.dart';
import 'package:chat_app/utils/constants/custom_text.dart';
import 'package:chat_app/views/chat_page.dart';
import 'package:chat_app/widgets/chat_tile.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //Text Controllers

  final TextEditingController _searchController = TextEditingController();

  //Variables

  List<Map> searchResults = [];
  bool isLoading = false;

  //Search Users On Database Function

  void onSearch() async {
    setState(() {
      searchResults = [];
      isLoading = true;
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
                'No User Found',
                style: CustomTextClass.bodyText(
                  context,
                  CustomColors.whiteVarOne(),
                ),
              ),
            ),
          );
          setState(() {
            isLoading = false;
          });
          return;
        }
        for (var element in value.docs) {
          if (element.data()['email'] !=
              FirebaseAuth.instance.currentUser!.email) {
            searchResults.add(
              element.data(),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Theme

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
              //Search Field

              CustomInput(
                hintText: 'Type Username',
                isObscure: false,
                isSearch: true,
                leadingIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: darkModeEnabled
                        ? CustomColors.white()
                        : CustomColors.white(),
                  ),
                ),
                controller: _searchController,
                onSearch: onSearch,
              ),

              if (searchResults.length > 0)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ChatPage(
                                  friendId: searchResults[index]['uid'],
                                  friendImageUrl: searchResults[index]
                                      ['imageUrl'],
                                  friendName: searchResults[index]['name'],
                                );
                              },
                            ),
                          );
                        },
                        child: ChatTile(
                          imageUrl: searchResults[index]['imageUrl'],
                          name: searchResults[index]['name'],
                          lastMessage: 'Lorem Ipsum',
                          lastMessageTime: '16:32',
                          isOnline: false,
                          messageCounter: index,
                        ),
                      );
                    },
                  ),
                )
              else if (isLoading == true)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
