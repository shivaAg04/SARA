import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/add_new_entry.dart';
import 'package:kiet_olx/screens/Ads/AFTER%20LOGIN/edited_screen.dart';

class AdsScreen extends StatelessWidget {
  AdsScreen({Key? key}) : super(key: key);

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;

  deleteProduct(String id) async {
    print(id);
    await _firebaseFirestore.collection(user!.email!).doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MY ADS",
        ),
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
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(user!.email!).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> userMAp =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => EditedScreen(
                                userMAp["Title"],
                                userMAp["Description"],
                                userMAp["Price"],
                                userMAp["Id"])),
                          ),
                        );
                      },
                      title: Text(userMAp["Title"]),
                      subtitle: Text(userMAp["Price"]),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print(userMAp["Id"]);
                            deleteProduct(userMAp["Id"]);
                          }));
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
