import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/home/product_detail_screen.dart';

import '../screens/home/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => ProductDetailScreen())));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(children: [
            Image.network(
              cacheHeight: 300,
              cacheWidth: 400,
              "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 4,
            ),
            const Text("TITLE"),
            const SizedBox(
              height: 4,
            ),
            const Text("PRICE"),
          ]),
        ),
      ),
    );
  }
}
