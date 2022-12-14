import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoUserAdsScreen extends StatelessWidget {
  const NoUserAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/nologin.json"),
        Text("LOG IN with Kiet ID for Posting ADS"),
      ],
    ));
  }
}
