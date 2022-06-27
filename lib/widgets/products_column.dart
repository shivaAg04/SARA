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
        return ProductCard();
      },
    );
  }
}
