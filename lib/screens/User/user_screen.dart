import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:kiet_olx/screens/User/after_login.dart';
// import 'package:kiet_olx/screens/User/sign_in.dart';
// import 'package:kiet_olx/screens/User/sign_up.dart';
import 'package:lottie/lottie.dart';

import '../bottom_navigation_bar.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<void> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // signInwithGoogle() async {
  //   print("///////////////");
  //   try {
  //     print("///e////////////");
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();

  // if (googleSignInAccount!.email.contains("kiet.edu")) {
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken);

  //   await FirebaseAuth.instance.signInWithCredential(credential);
  // } else {
  //   return "shiva";
  // }

  //     // final GoogleSignInAuthentication googleSignInAuthentication =
  //     //     await googleSignInAccount!.authentication;
  //     // final AuthCredential credential = GoogleAuthProvider.credential(
  //     //   accessToken: googleSignInAuthentication.accessToken,
  //     //   idToken: googleSignInAuthentication.idToken,
  //     // );
  //     // await _auth.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     rethrow;
  //   }
  //   print("lastttttttt");
  // }

  googleLogin() async {
    print("googleLogin method Called");

    try {
      var googleAc = await _googleSignIn.signIn();
      if (googleAc == null) {
        return;
      }
      // if (googleAc.email.endsWith("@kiet.edu")) {
      //   final userData = await googleAc.authentication;
      //   final credential = GoogleAuthProvider.credential(
      //       accessToken: userData.accessToken, idToken: userData.idToken);

      //   await FirebaseAuth.instance.signInWithCredential(credential);
      // } else {
      //   dispose();
      // }
      final userData = await googleAc.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }

  // Future<void> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // Obtain the auth details from the request
  //     if (googleUser == null) {
  //       return;
  //     }
  //     if (googleUser.email.contains("kiet.edu")) {
  //       final GoogleSignInAuthentication? googleAuth =
  //           await googleUser.authentication;

  //       // Create a new credential
  //       final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth?.accessToken,
  //         idToken: googleAuth?.idToken,
  //       );

  //       // Once signed in, return the UserCredential
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //     } else {
  //       return;
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // Future<void> googleLogin() async {
  //   print("googleLogin method Called");
  //   GoogleSignIn _googleSignIn = GoogleSignIn();
  //   print("object1");
  //   try {
  //     print("object2");
  //     var reslut = await _googleSignIn.signIn();
  //     print("object3");

  //     if (reslut == null) {
  //       return;
  //     }
  //     print("object");
  //     if (reslut.email.contains("kiet.edu")) {
  //       final userData = await reslut.authentication;
  //       final credential = GoogleAuthProvider.credential(
  //           accessToken: userData.accessToken, idToken: userData.idToken);
  //       var finalResult =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       print("Result $reslut");
  //       print(reslut.displayName);
  //       print(reslut.email);
  //       print(reslut.photoUrl);
  //       print("////////");
  //     } else {
  //       return;
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

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
//   child: const Image(
            //     image: NetworkImage(
            //         "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            //     fit: BoxFit.contain,
            //   ),
            // ),
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
