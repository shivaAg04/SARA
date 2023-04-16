import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/edited_screen.dart';

import '../main.dart';

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
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: mq.width * .85,
                  imageUrl: pic,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Icon(Icons.image),
                  errorWidget: (context, url, error) => const Icon(Icons.image),
                ),
              ),
              SizedBox(
                height: mq.height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Product Name: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Price: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text(
                    "₹$price",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Contact Mail: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                  Text(
                    Email,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .01,
              ),
              const Center(
                child: Text(
                  'Description: ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                height: mq.height * .01,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  description,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.chat_outlined),
                  label: Text("Message"))
            ],
          ),
        ),
      ),
    );
  }
}
