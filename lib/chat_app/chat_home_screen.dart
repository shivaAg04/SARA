import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:kiet_olx/api/apis.dart';
import 'package:kiet_olx/main.dart';
import 'package:kiet_olx/model/chat_user.dart';
import 'package:kiet_olx/widgets/chat_user_card.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        title: const Text("Messages"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_comment_outlined),
        ),
      ),
      //body
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: mq.height * 0.02),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return ChatUserCard(user: list[index]);
                  }),
                  itemCount: list.length,
                );
              } else {
                return const Center(
                  child: Text(" NO CHATS !!"),
                );
              }
          }
        },
      ),
    );
  }
}
