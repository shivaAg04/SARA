import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/dropdown.dart';
import 'package:kiet_olx/screens/bottom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kiet_olx/screens/splash_screen.dart';
import 'chat_app/chat_home_screen.dart';
import 'firebase_options.dart';

import 'package:kiet_olx/screens/home/home_screen.dart';

late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// 72a5b43b8753d40e79ace9d2288113444d946b97 (HEAD -> master)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KIET OLX',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange,
      ),
      // home: DropDownHelper(),
      // home: ChatHomeScreen(),
      // home: BottomSheetWidget(),
      home: SplashScreen(),
    );
  }
}
