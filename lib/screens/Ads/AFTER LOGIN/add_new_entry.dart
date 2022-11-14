import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNewEntry extends StatelessWidget {
  AddNewEntry({Key? key}) : super(key: key);

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? user = _auth.currentUser;

  sendtoserver(
      String serverTitle, String serverPrice, String serverDescription) async {
    Map<String, dynamic> data = {
      "Title": serverTitle,
      "Price": serverPrice,
      "Description": serverDescription
    };
  
    await _firebaseFirestore
        .collection(user!.email.toString())
        .doc(DateTime.now().toIso8601String())
        .set(data);
  }

  gatDAta() async {
    var result = await _firebaseFirestore.collection("Product").get();
    print(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Entry"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    } else {
                      return null;
                    }
                  },
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    } else {
                      return null;
                    }
                  },
                  controller: pricecontroller,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    } else {
                      return null;
                    }
                  },
                  controller: descriptioncontroller,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      
                      if (_formKey.currentState!.validate()) {
                        await gatDAta();
                        
                        await sendtoserver(titlecontroller.text,
                            pricecontroller.text, descriptioncontroller.text);
                            
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
