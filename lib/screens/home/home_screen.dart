import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kiet_olx/BrowseCategories/category_row.dart';
import 'package:kiet_olx/FreshlyRecommendation/freshly_products_column.dart';

import 'package:kiet_olx/chat_app/chat_home_screen.dart';
import 'package:kiet_olx/main.dart';
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
    APIs.updateActiveStatus(true);
    APIs.getSelfInfo();
    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (APIs.auth.currentUser != null) {
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
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 187, 85),
              ),
              child: Lottie.asset('assets/menu.json'),
            ),
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.message, color: Colors.orange),
                  SizedBox(
                    width: mq.width * 0.04,
                  ),
                  const Text('Messages'),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Stack(
          children: [
            // The text border
            Text(
              ' OLX KIET ',
              style: GoogleFonts.lobster(
                fontSize: 20,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.black,
              ),
            ),
            // The text inside
            Text(
              ' OLX KIET ',
              style: GoogleFonts.lobster(
                fontSize: 20,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        actions: [SearchBar()],
      ),
      body: Column(
        children: [
          // SearchBar(),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                // The text border
                Text(
                  " Browse Category",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 17,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.black,
                  ),
                ),
                // The text inside
                Text(
                  " Browse Category",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 17,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          const CategooryRow(),

          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                // The text border
                Text(
                  " Fresh Recommendations",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 17,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.black,
                  ),
                ),

                // The text inside
                Text(
                  " Fresh Recommendations",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 17,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
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
