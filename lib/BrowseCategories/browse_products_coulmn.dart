import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FreshlyRecommendation/fresh_recommendation_card.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Products")
            .where("Category", isEqualTo: CategoryName)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> userMAp = snapshot
                      .data!.docs[snapshot.data!.docs.length - (index + 1)]
                      .data() as Map<String, dynamic>;
                  return FreshRecommendationCard(
                      index,
                      userMAp["Title"],
                      userMAp["Price"] + "₹",
                      userMAp["Pic"],
                      userMAp["Description"],
                      userMAp["Id"],
                      userMAp["Category"],
                      userMAp["Email"]);
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
