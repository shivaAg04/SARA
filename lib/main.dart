import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:kiet_olx/screens/splash/splash_screen.dart';

import 'firebase_options.dart';

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
        primaryColor: Color.fromARGB(255, 255, 102, 0),
      ),
      // home: DropDownHelper(),
      // home: ChatHomeScreen(),
      // home: BottomSheetWidget(),
      home: SplashScreen(),
    );
  }
}
