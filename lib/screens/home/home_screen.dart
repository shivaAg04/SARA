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
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri(scheme: "https", host: url);
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw "Can not launch url";
  }
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
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/images/chat.png")),
                  SizedBox(
                    width: mq.width * 0.04,
                  ),
                  const Text(
                    'Messages',
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 85, 129),
                    ),
                  ),
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
              title: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/images/coding.png")),
                  SizedBox(
                    width: mq.width * 0.04,
                  ),
                  const Text(
                    'About Shiva',
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 85, 129),
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            SizedBox(
              height: mq.height * .5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/images/instagram.png")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                          onTap: () async {
                            const url =
                                'https://www.youtube.com/c/ICC/featured';

                            await canLaunchUrl(Uri.parse(url))
                                ? await launchUrl(Uri.parse(url))
                                : throw 'Could not launch $url';
                          },
                          child: Image.asset("assets/images/linkedin.png"))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/images/youtube.png")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/images/twitter (1).png")),
                ),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 1, 85, 129),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Stack(
          children: [
            // The text border
            Text(
              ' SARA ',
              style: GoogleFonts.josefinSans(
                fontSize: 27,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Color.fromARGB(255, 1, 85, 129),
              ),
            ),

            Text(
              ' SARA ',
              style: GoogleFonts.josefinSans(
                fontSize: 27,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 102, 0),
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
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "  Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )),
          const SizedBox(
            height: 20,
          ),

          const CategooryRow(),

          const SizedBox(
            height: 15,
          ),
          const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "  Newly Added",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: FreshlyProductColumn())
        ],
      ),
    );
  }
}
