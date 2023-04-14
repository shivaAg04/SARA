import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kiet_olx/BrowseCategories/category_row.dart';
import 'package:kiet_olx/FreshlyRecommendation/freshly_products_column.dart';

import 'package:kiet_olx/chat_app/chat_home_screen.dart';
import 'package:lottie/lottie.dart';

import '../../SearchBar/search_bar_icon.dart';
import '../../api/apis.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (APIs.auth.currentUser != null) {
        print(message);
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChatHomeScreen()),
                );
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