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
  String Email;

  FreshDetailScreen(this.title, this.price, this.pic, this.description, this.id,
      this.Category, this.Email,
      {super.key});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 40),
        child: Column(
          children: [
            Card(
              color: Colors.orange,
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
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Price : " + price,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Contact mail : " + Email,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.orange),
              ),
              child: Text(
                "  " + description,
                style: TextStyle(fontSize: 15),
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    ));
  }
}
