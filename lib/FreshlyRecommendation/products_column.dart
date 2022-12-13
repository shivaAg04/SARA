// import 'package:flutter/material.dart';
// import 'package:kiet_olx/widgets/product_card.dart';

// import 'fresh_recommendation_card.dart';

// class ProductsColumn extends StatelessWidget {
//   const ProductsColumn({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemCount: 10,
//       itemBuilder: (BuildContext context, int index) {
//         return FreshRecommendationCard(
//             "shiva",
//             "35",
//             "https://firebasestorage.googleapis.com/v0/b/kiet-olx.appspot.com/o/profilepictures%2Faeeaa140-69db-11ed-8024-a73eed1b6207?alt=media&token=07e3308f-f0c5-4fc6-b25d-983bfd2632f0",
//             "",
//             "",
//             "");
//       },
//     );
//   }
// }

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
        stream: FirebaseFirestore.instance.collection("").snapshots(),
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
