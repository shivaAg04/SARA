import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/api/apis.dart';
import 'package:kiet_olx/model/chat_user.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  late ChatUser? user;

  @override
  void initState() {
    user = APIs.me;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: APIs.getAllProducts(user!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final data = snapshot.data.docs;
          print(jsonEncode(data![0].data()));
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
