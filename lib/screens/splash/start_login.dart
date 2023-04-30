import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
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
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
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
            SizedBox(height: 35.0),
            Container(
              alignment: Alignment.center,
              height: 400,
              child: Lottie.asset("assets/welcome.json"),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ",
                  style: GoogleFonts.josefinSans(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 85, 129),
                  ),
                ),
                Stack(
                  children: [
                    // The text border
                    Text(
                      'SARA ',
                      style: GoogleFonts.josefinSans(
                        fontSize: 30,
                        letterSpacing: 6,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Color.fromARGB(255, 1, 85, 129),
                      ),
                    ),

                    Text(
                      'SARA ',
                      style: GoogleFonts.josefinSans(
                        fontSize: 30,
                        letterSpacing: 6,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 102, 0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              'Sell your unused Product here',
              style: TextStyle(
                color: Color.fromARGB(255, 1, 85, 129),
              ),
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
