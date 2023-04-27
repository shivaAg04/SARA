import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../FreshlyRecommendation/fresh_recommendation_card.dart';
import '../api/apis.dart';
import '../model/products.dart';

class BrowswProductColumn extends StatelessWidget {
  String CategoryName;
  BrowswProductColumn(this.CategoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Stack(
          children: [
            // The text border
            Text(
              CategoryName,
              style: GoogleFonts.lobster(
                fontSize: 20,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.black,
              ),
            ),
            // The text inside
            Text(
              CategoryName,
              style: GoogleFonts.lobster(
                fontSize: 20,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("Products")
            .where(
              "Category",
              isEqualTo: CategoryName,
            )
            .where("Id", isNotEqualTo: APIs.user.uid)
            .snapshots(),
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
              List<Products> list =
                  data?.map((e) => Products.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    int i = list.length - index - 1;

                    return FreshRecommendationCard(
                        i,
                        list[i].Title,
                        list[i].Price,
                        list[i].Pic,
                        list[i].Description,
                        list[i].Id,
                        list[i].Category,
                        list[i].Email);
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
