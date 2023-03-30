import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/home/product_detail_screen.dart';

import '../screens/Ads/home/product_detail_screen.dart';

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
        color: Colors.orange,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(children: [
            Image.network(
              cacheHeight: 300,
              cacheWidth: 400,
              picUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(title),
            const SizedBox(
              height: 4,
            ),
            Text(price + "₹"),
          ]),
        ),
      ),
    );
  }
}
