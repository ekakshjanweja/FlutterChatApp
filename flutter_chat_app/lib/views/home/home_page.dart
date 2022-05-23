import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_colors.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';
import 'package:flutter_chat_app/views/home/home_widgets.dart';

import '../../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.daisyBush(),
        onPressed: () {},
        child: Icon(
          Icons.group_add,
          color: CustomColors.white(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: MediaQuery.of(context).size.height * 0.06,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Upper Section

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chats',
                    style: CustomTextClass.h1Bold(context, Colors.white),
                  ),
                  Icon(
                    Icons.search,
                    color: CustomColors.primaryColorLight(),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
              ),

              //Stories Section

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    //Add Story Button

                    AddStoryWidget(
                      radius: MediaQuery.of(context).size.height * 0.08,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      labelText: 'Add Story',
                    ),

                    //Other Stories

                    ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        5,
                        (index) => StoryWidget(
                          radius: MediaQuery.of(context).size.height * 0.08,
                          imageUrl:
                              'https://images.unsplash.com/photo-1494790108377-'
                              'be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90b'
                              'y1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                          labelText: 'John Doe',
                          showBorder: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Chats Section

              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 0.3,
                      color: Colors.white.withOpacity(0.5),
                    );
                  },
                  itemBuilder: (context, index) {
                    return ChatTile(
                      imageUrl: 'https://images.unsplash.com/phot'
                          'o-1518806118471-f28b20a1d79d?ixlib=rb-1'
                          '.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdl'
                          'fHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                      name: 'John Doe',
                      lastMessage: 'Lorem ipsum Lorem ipsum 😊😂🤣',
                      lastMessageTime: '16:32',
                      isOnline: true,
                      messageCounter: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
