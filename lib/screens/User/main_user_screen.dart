import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/User/after_login.dart';
import 'package:kiet_olx/screens/User/user_screen.dart';

class MainUserScreen extends StatefulWidget {
  const MainUserScreen({Key? key}) : super(key: key);

  @override
  State<MainUserScreen> createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isloggedin = false;
  checkAuthentification() async {
    print("mainUser?????????");
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print("user is not null");
        setState(() {
          isloggedin = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    checkAuthentification();
  }

  @override
  Widget build(BuildContext context) {
    return isloggedin ? AfterLogin() : UserScreen();
  }
}
