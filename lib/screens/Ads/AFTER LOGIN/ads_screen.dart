import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/add_new_entry.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/edited_screen.dart';

import '../../../widgets/product_card.dart';

class AdsScreen extends StatelessWidget {
  AdsScreen({Key? key}) : super(key: key);

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;

  deleteProduct(String id) async {
    await _firebaseFirestore.collection("Product").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MY ADS",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => AddNewEntry()),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Products").snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> userMAp = snapshot
                      .data!.docs[snapshot.data!.docs.length - (index + 1)]
                      .data() as Map<String, dynamic>;
                  return ProductCard(
                      userMAp["Title"],
                      userMAp["Price"] + "₹",
                      userMAp["Pic"],
                      userMAp["Description"],
                      userMAp["Id"],
                      userMAp["Category"]);
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
