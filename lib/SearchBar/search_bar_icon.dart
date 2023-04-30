import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/SearchBar/search_bar.dart';

import '../api/apis.dart';
import '../model/products.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List _allproducts = [];

  void listMaking() async {
//  Stream<QuerySnapshot<Map<String, dynamic>>>  snapshot =    APIs.firestore
//           .collection("Products")
//           .where("Id", isNotEqualTo: APIs.user.uid)
//           .snapshots();
//           final data = snapshot.
//        _allproducts =
//                 data?.map((e) => Products.fromJson(e.data())).toList() ?? [];

    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("Products")
        .where("Id", isNotEqualTo: APIs.user.uid)
        .get();
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
        color: Color.fromARGB(255, 1, 85, 129),
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
