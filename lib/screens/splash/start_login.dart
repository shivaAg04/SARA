import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../../api/apis.dart';
import '../../helper/dialogs.dart';
import '../screen_controller/bottom_navigation_bar.dart';

class StartLogin extends StatefulWidget {
  const StartLogin({super.key});

  @override
  _StartLoginState createState() => _StartLoginState();
}

class _StartLoginState extends State<StartLogin> {
  // handles google login button click
  _handleGoogleBtnClick() {
    //for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => CustomiseBottomNavigationBar(
                        iindex: 1,
                      )));
        } else {
          await APIs.creatUser().then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => CustomiseBottomNavigationBar(
                          iindex: 1,
                        )));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //////// normal gmail///////////
      // final GoogleSignInAuthentication? googleAuth =
      //     await googleUser!.authentication;

      // // Create a new credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );
      // return await APIs.auth.signInWithCredential(credential);
      // Obtain the auth details from the request
      if (googleUser!.email.endsWith("@kiet.edu")) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await APIs.auth.signInWithCredential(credential);
      } else {
        await GoogleSignIn().disconnect().then((value) {
          Dialogs.showSnackBar(context, "Only KIET MAIL");
          return null;
        });
      }

      // Once signed in, return the UserCredential
    } catch (e) {
      Dialogs.showSnackBar(context, 'Something Went Wrong (Check Internet!)');
      return null;
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20.0),
            SignInButton(Buttons.Google, text: "Sign up with KIET MAIL ID",
                onPressed: () {
              _handleGoogleBtnClick();
            })
          ],
        ),
      ),
    );
  }
}
