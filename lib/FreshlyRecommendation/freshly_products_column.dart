import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/api/apis.dart';
import 'package:lottie/lottie.dart';

import '../model/products.dart';
import 'fresh_recommendation_card.dart';

class FreshlyProductColumn extends StatelessWidget {
  FreshlyProductColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("Products")
          .orderBy('sent', descending: false)
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
                physics:
                    NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true,
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
                    list[i].Email,
                    list[i].sent,
                  );
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
    );
  }
}
