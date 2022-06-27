import 'package:flutter/material.dart';

import 'package:kiet_olx/widgets/categories_button.dart';
import 'package:kiet_olx/widgets/category_row.dart';
import 'package:kiet_olx/widgets/products_column.dart';

import '../../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SearchBar(),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "   Browser Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CategooryRow(),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "   Fresh Recommendations",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: ProductsColumn())
        ],
      ),
    );
  }
}
