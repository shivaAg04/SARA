import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lottie/lottie.dart';

import '../../api/apis.dart';

class StartLogin extends StatefulWidget {
  const StartLogin({super.key});

  @override
  _StartLoginState createState() => _StartLoginState();
}

class _StartLoginState extends State<StartLogin> {
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
              APIs.googleLogin(context);
            })
          ],
        ),
      ),
    );
  }
}
