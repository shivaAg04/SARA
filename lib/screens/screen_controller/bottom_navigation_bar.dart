import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:kiet_olx/chat_app/chat_home_screen.dart';

import 'package:kiet_olx/screens/home/home_screen.dart';
import 'package:kiet_olx/screens/user_profile_screen.dart';

import '../Ads/AFTER LOGIN/ads_screen.dart';

class CustomiseBottomNavigationBar extends StatefulWidget {
  CustomiseBottomNavigationBar({Key? key, required this.iindex})
      : super(key: key);
  int iindex;

  @override
  _CustomiseBottomNavigationBar createState() =>
      _CustomiseBottomNavigationBar(iindex);
}

class _CustomiseBottomNavigationBar
    extends State<CustomiseBottomNavigationBar> {
  // ignore: empty_constructor_bodies
  int i;
  _CustomiseBottomNavigationBar(this.i);

  final List<Widget> _screenWidget = [
    // AdsControlScreen(),
    ChatHomeScreen(),
    AdsScreen(),
    HomeScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screenWidget[i],
        bottomNavigationBar: CurvedNavigationBar(
          index: i,
          items: const <Widget>[
            Icon(
              Icons.message,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.add_sharp,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              size: 20,
              color: Colors.white,
            ),
            Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 20,
            ),
          ],

          animationDuration: const Duration(milliseconds: 300),
          height: 55,
          onTap: (index) {
            setState(() {
              i = index;
            });
          },
          // animationCurve: Curves.decelerate,
          buttonBackgroundColor: Color.fromARGB(255, 255, 102, 0),
          color: Color.fromARGB(255, 1, 85, 129),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
