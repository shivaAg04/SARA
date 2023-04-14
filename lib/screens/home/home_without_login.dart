import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WithoutLoginHome extends StatelessWidget {
  const WithoutLoginHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/nologin.json"),
        const Text("LOG IN with Kiet ID"),
      ],
    ));
  }
}
