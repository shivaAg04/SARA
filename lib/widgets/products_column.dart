import 'package:flutter/material.dart';
import 'package:kiet_olx/widgets/product_card.dart';

class ProductsColumn extends StatelessWidget {
  const ProductsColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(
            "shiba",
            "35",
            "https://firebasestorage.googleapis.com/v0/b/kiet-olx.appspot.com/o/profilepictures%2Faeeaa140-69db-11ed-8024-a73eed1b6207?alt=media&token=07e3308f-f0c5-4fc6-b25d-983bfd2632f0",
            "",
            "");
      },
    );
  }
}
