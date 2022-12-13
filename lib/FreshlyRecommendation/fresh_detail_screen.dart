import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/edited_screen.dart';

class FreshDetailScreen extends StatelessWidget {
  String title;
  String price;
  String pic;
  String description;
  String id;
  String Category;

  FreshDetailScreen(this.title, this.price, this.pic, this.description, this.id,
      this.Category,
      {super.key});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;

  deleteProduct(String id) async {
    await _firebaseFirestore.collection(user!.email!).doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                pic,
                height: 250,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              " " + title + " ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              price,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(description, textAlign: TextAlign.start),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    ));
  }
}
