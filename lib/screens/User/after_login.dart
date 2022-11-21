// import 'package:authentification/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:authentification/Start.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiet_olx/screens/User/user_screen.dart';
import 'package:kiet_olx/screens/bottom_navigation_bar.dart';
import 'package:lottie/lottie.dart';

class AfterLogin extends StatefulWidget {
  @override
  _AfterLogin createState() => _AfterLogin();
}

class _AfterLogin extends State<AfterLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedin = false;
  final gooleSignIn = GoogleSignIn();
// thud
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CustomiseBottomNavigationBar(
                  iindex: 2,
                )));
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        user = firebaseUser!;
        isloggedin = true;
      });
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CustomiseBottomNavigationBar(iindex: 2)));
  }

  @override
  void initState() {
    super.initState();
    // checkAuthentification();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: !isloggedin
          ? Center(
              child: Lottie.network(
                  "https://assets1.lottiefiles.com/packages/lf20_oc72opni.json"))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 90.0),
                Container(
                  height: 99,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        "${user.photoURL}",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // child: Lottie.network(
                //     "https://assets3.lottiefiles.com/packages/lf20_jrpzvtqz.json")),

                SizedBox(
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Hello ',
                      style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${user.displayName}',
                          style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        const TextSpan(
                          text: ' you are Logged in as ',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: '${user.email}',
                          style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  // padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  onPressed: logout,
                  // color: Colors.orange,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  child: const Text('Signout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
    ));
  }
}
