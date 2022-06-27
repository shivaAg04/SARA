import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/bottom_navigation_bar.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

// class Authentication with ChangeNotifier {
//   bool isLoggedIn() {
//     auth.authStateChanges().listen((user) {
//       if (user != null) return true;
//     });
//     return false;
//   }

Future<void> login(String? email, String? password) async {
  try {
    await auth.signInWithEmailAndPassword(email: email!, password: password!);
  } catch (e) {
    rethrow;
  }
}

Future<void> googleSignIn(BuildContext ctx) async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser != null) {
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    if (googleAuth.idToken != null && googleAuth.accessToken != null) {
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential user = await auth.signInWithCredential(credential);

      await Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: ((context) => CustomiseBottomNavigationBar(
                iindex: 2,
              )),
        ),
      );
    } else {
      throw StateError('Missing Google Auth Token');
    }
  } else
    throw StateError('Sign in Aborted');
}
