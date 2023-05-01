import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/api/apis.dart';
import 'package:kiet_olx/model/chat_user.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/edited_screen.dart';

import '../chat_app/chat_screen.dart';
import '../main.dart';

class FreshDetailScreen extends StatelessWidget {
  String title;
  String price;
  String pic;
  String description;
  String id;

  String Category;
  String Email;
  String sent;

  FreshDetailScreen(this.title, this.price, this.pic, this.description, this.id,
      this.Category, this.Email, this.sent,
      {super.key});
  late ChatUser productseller;
  Future<void> getuser(BuildContext context) async {
    await APIs.firestore.collection('users').doc(id).get().then((user) async {
      productseller = ChatUser.fromJson(user.data()!);
    }).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ChatUserScreen(user: productseller)));
    });
    await APIs.addChatUser(Email);
  }

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
                        fontSize: 15),
                  ),
                  Text(
                    title,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
                    'Category: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Text(
                    Category,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
                onPressed: () {
                  getuser(context);
                },
                icon: const Icon(Icons.chat_outlined),
                label: const Text("Message"),
              ),
              const SizedBox(
                height: 10,
              ),
              APIs.user.email == "shiva.2024cs1129@kiet.edu"
                  ? ElevatedButton.icon(
                      onPressed: () async {
                        await APIs.firestore
                            .collection("Products")
                            .doc(sent)
                            .delete();
                        await APIs.storage.refFromURL(pic).delete();

                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete"),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
