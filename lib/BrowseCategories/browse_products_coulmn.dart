import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/add_new_entry.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/edited_screen.dart';

import '../../../widgets/product_card.dart';
import '../FreshlyRecommendation/fresh_recommendation_card.dart';

class BrowswProductColumn extends StatelessWidget {
  String CategoryName;
  BrowswProductColumn(this.CategoryName);

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CategoryName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Products")
            .where("Category", isEqualTo: CategoryName)
            .snapshots(),
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
                  return FreshRecommendationCard(
                      userMAp["Title"],
                      userMAp["Price"] + "₹",
                      userMAp["Pic"],
                      userMAp["Description"],
                      userMAp["Id"],
                      userMAp["Category"],
                      userMAp["Email"]);
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
