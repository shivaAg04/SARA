import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/home/product_detail_screen.dart';

import '../main.dart';
import '../screens/home/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  String title;
  String price;
  String picUrl;
  String description;
  String id;
  String Category;

  ProductCard(this.title, this.price, this.picUrl, this.description, this.id,
      this.Category,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ProductDetailScreen(
                title, price, picUrl, description, id, Category)),
          ),
        );
      },
      child: Card(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(5),
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
            Text(title),
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
