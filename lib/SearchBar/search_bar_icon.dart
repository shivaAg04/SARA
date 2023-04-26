import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/SearchBar/search_bar.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final List _allproducts = [];

  void listMaking() async {
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("Products").get();
    for (var doc in data.docs) {
      _allproducts.add(doc.data());
    }
  }

  @override
  initState() {
    // at the beginning, all users are shown
    listMaking();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Theme.of(context).primaryColor,
        icon: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchBarScreen(_allproducts),
            ),
          );
        });
  }
}
