import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiet_olx/api/apis.dart';

// import 'package:kiet_olx/screens/User/sign_in.dart';
// import 'package:kiet_olx/screens/User/sign_up.dart';
import 'package:lottie/lottie.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  googleLogin() async {
    try {
      var googleAc = await _googleSignIn.signIn();
      if (googleAc == null) {
        return;
      }
      if (googleAc.email.endsWith("@kiet.edu")) {
        final userData = await googleAc.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: userData.accessToken, idToken: userData.idToken);

        await FirebaseAuth.instance.signInWithCredential(credential);
        if ((await APIs.userExists() == false)) {
          await APIs.creatUser();
        }
      } else {
        await _googleSignIn.disconnect();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 35.0),
            Container(
              alignment: Alignment.center,
              height: 400,
              child: Lottie.asset("assets/welcome.json"),
            ),
            SizedBox(height: 20),
            RichText(
                text: const TextSpan(
                    text: 'Welcome to ',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'OLX kiet',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange))
                ])),
            const SizedBox(height: 10.0),
            const Text(
              'Sell your unused Product here',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30.0),
            SizedBox(height: 20.0),
            SignInButton(Buttons.Google,
                text: "Sign up with KIET MAIL ID", onPressed: googleLogin)
          ],
        ),
      ),
    );
  }
}
