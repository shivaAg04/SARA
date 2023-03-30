import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kiet_olx/BrowseCategories/categories_button.dart';
import 'package:kiet_olx/BrowseCategories/category_row.dart';
import 'package:kiet_olx/FreshlyRecommendation/freshly_products_column.dart';
import 'package:kiet_olx/SearchBar/search_bar.dart';
import 'package:lottie/lottie.dart';

import '../../../SearchBar/search_bar_icon.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 187, 85),
              ),
              child: Lottie.asset('assets/menu.json'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "OLX KIET",
        ),
        actions: [SearchBar()],
      ),
      body: Column(
        children: [
          // SearchBar(),
          SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "   Browse Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const CategooryRow(),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "   Fresh Recommendations",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: FreshlyProductColumn())
        ],
      ),
    );
  }
}
