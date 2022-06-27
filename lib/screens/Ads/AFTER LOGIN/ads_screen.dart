import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/add_image.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/new_ads_screen.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MY ADS"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => AddImage()),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
