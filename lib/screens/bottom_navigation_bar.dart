import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/ads_control_screen.dart';
import 'package:kiet_olx/screens/User/after_login.dart';
import 'package:kiet_olx/screens/User/main_user_screen.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/ads_screen.dart';
import 'package:kiet_olx/screens/Ads/home/home_screen.dart';
import 'package:kiet_olx/screens/User/user_screen.dart';

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
    AdsControlScreen(),
    HomeScreen(),
    const MainUserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenWidget[i],
      bottomNavigationBar: CurvedNavigationBar(
        index: i,
        items: const <Widget>[
          Icon(
            Icons.add_sharp,
            size: 20,
            color: Colors.black,
          ),
          Icon(
            Icons.home,
            size: 20,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle,
            color: Colors.black,
            size: 20,
          ),
        ],
        animationDuration: const Duration(milliseconds: 300),
        height: 50,
        onTap: (index) {
          setState(() {
            i = index;
          });
        },
        // animationCurve: Curves.decelerate,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
      ),
    );
  }
}
