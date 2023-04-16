import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/home/product_detail_screen.dart';

import '../main.dart';
import '../screens/home/product_detail_screen.dart';
import 'fresh_detail_screen.dart';

class FreshRecommendationCard extends StatelessWidget {
  String title;
  String price;
  String picUrl;
  String description;
  String id;
  String Category;
  String Email;

  FreshRecommendationCard(this.title, this.price, this.picUrl, this.description,
      this.id, this.Category, this.Email,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => FreshDetailScreen(
                title, price, picUrl, description, id, Category, Email)),
          ),
        );
      },
      child: Card(
        elevation: 3,
        color: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(children: [
            CachedNetworkImage(
              width: mq.height * .18,
              height: mq.width * .35,
              imageUrl: picUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Icon(Icons.image),
              errorWidget: (context, url, error) => const Icon(Icons.image),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text("₹ $price"),
          ]),
        ),
      ),
    );
  }
}
