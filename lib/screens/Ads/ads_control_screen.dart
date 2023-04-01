import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/ads_screen.dart';
import 'package:kiet_olx/screens/Ads/BEFORE%20LOGIN/no_user_ads_screen.dart';

class AdsControlScreen extends StatefulWidget {
  AdsControlScreen({Key? key}) : super(key: key);

  @override
  State<AdsControlScreen> createState() => _AdsControlScreenState();
}

class _AdsControlScreenState extends State<AdsControlScreen> {
  bool isloggedin = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          isloggedin = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuthentification();
  }

  @override
  Widget build(BuildContext context) {
    return isloggedin ? AdsScreen() : NoUserAdsScreen();
  }
}
