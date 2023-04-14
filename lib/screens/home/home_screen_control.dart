import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/api/apis.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/ads_screen.dart';
import 'package:kiet_olx/screens/Ads/BEFORE%20LOGIN/no_user_ads_screen.dart';
import 'package:kiet_olx/screens/home/home_screen.dart';
import 'package:kiet_olx/screens/home/home_without_login.dart';

class HomeControlScreen extends StatefulWidget {
  HomeControlScreen({Key? key}) : super(key: key);

  @override
  State<HomeControlScreen> createState() => _HomeControlScreenState();
}

class _HomeControlScreenState extends State<HomeControlScreen> {
  bool isloggedin = false;

  checkAuthentification() async {
    APIs.auth.authStateChanges().listen((user) {
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
    return isloggedin ? HomeScreen() : const WithoutLoginHome();
  }
}
