import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiet_olx/screens/screen_controller/bottom_navigation_bar.dart';
import 'package:kiet_olx/screens/splash/start_login.dart';
import 'package:lottie/lottie.dart';

import '../../api/apis.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(seconds: 4), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      if (APIs.auth.currentUser != null) {
        //navigate to home screen
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => CustomiseBottomNavigationBar(
                      iindex: 1,
                    )));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const StartLogin()));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            Stack(
              children: [
                // The text border
                Text(
                  ' OLX KIET ',
                  style: GoogleFonts.lobster(
                    fontSize: 30,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 10
                      ..color = Colors.black,
                  ),
                ),
                // The text inside
                Text(
                  ' OLX KIET ',
                  style: GoogleFonts.lobster(
                    fontSize: 30,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),

            //
            Container(child: Lottie.asset('assets/splash.json')),
            // SizedBox(height: 120),

            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/heart.svg",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    " by - SHIVA AGRAHARI",
                    style: GoogleFonts.nanumPenScript(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
