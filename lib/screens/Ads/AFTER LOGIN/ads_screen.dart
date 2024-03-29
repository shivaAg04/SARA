import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiet_olx/model/products.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/add_new_entry.dart';
import 'package:lottie/lottie.dart';

import '../../../api/apis.dart';

import '../../../widgets/product_card.dart';

class AdsScreen extends StatefulWidget {
  AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  List<Products> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: SizedBox(
          child: Image.asset("assets/images/myads.png"),
          height: MediaQuery.of(context).size.height * .14,
        ),
        // title: Stack(
        //   children: [
        //     // The text border
        //     Text(
        //       'MY ADS',
        //       style: GoogleFonts.josefinSans(
        //         fontSize: 25,
        //         letterSpacing: 4,
        //         fontWeight: FontWeight.bold,
        //         foreground: Paint()
        //           ..style = PaintingStyle.stroke
        //           ..strokeWidth = 3
        //           ..color = Color.fromARGB(255, 1, 85, 129),
        //       ),
        //     ),
        //     // The text inside
        //     Text(
        //       'MY ADS',
        //       style: GoogleFonts.josefinSans(
        //         fontSize: 25,
        //         letterSpacing: 4,
        //         fontWeight: FontWeight.bold,
        //         color: Theme.of(context).primaryColor,
        //       ),
        //     ),
        //   ],
        // ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => AddNewEntry()),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: APIs.getUserProducts(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: SizedBox(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              _list =
                  data?.map((e) => Products.fromJson(e.data())).toList() ?? [];
              if (_list.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    int i = _list.length - index - 1;
                    return ProductCard(
                        _list[i].Title,
                        _list[i].Price,
                        _list[i].Pic,
                        _list[i].Description,
                        _list[i].Id,
                        _list[i].Category,
                        _list[i].sent);
                  },
                );
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/empty.json"),
                    Text("No Ads"),
                  ],
                ));
              }
          }
        }),
      ),
    );
  }
}
