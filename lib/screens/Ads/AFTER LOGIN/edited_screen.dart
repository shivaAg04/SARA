import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/helper/dialogs.dart';
import 'package:kiet_olx/main.dart';

class EditedScreen extends StatefulWidget {
  late final String oldTitle;
  late final String oldDescription;
  late final String oldPrice;
  late final String id;
  late final String Category;

  late TextEditingController titlecontroller;
  late TextEditingController pricecontroller;
  late TextEditingController descriptioncontroller = TextEditingController();
  EditedScreen(
      this.oldTitle, this.oldDescription, this.oldPrice, this.id, this.Category,
      {super.key}) {
    titlecontroller = TextEditingController(text: oldTitle);
    descriptioncontroller = TextEditingController(text: oldDescription);
    pricecontroller = TextEditingController(text: oldPrice);
  }

  @override
  State<EditedScreen> createState() => _EditedScreenState();
}

class _EditedScreenState extends State<EditedScreen> {
  List dropDownListData = [
    {"title": "SPORTS", "value": "SPORTS"},
    {"title": "STATIONARY", "value": "STATIONARY"},
    {"title": "ELECTRICAL", "value": "ELECTRICAL"},
    {"title": "OTHERS", "value": "OTHERS"},
  ];

  String selectedCategory = "";
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? user = _auth.currentUser;
  bool _isUploading = false;
  sendtoserver(
      String serverTitle, String serverPrice, String serverDescription) async {
    Map<String, dynamic> data = {
      "Title": serverTitle,
      "Price": serverPrice,
      "Description": serverDescription,
      "Category": selectedCategory
    };

    await _firebaseFirestore
        .collection("Products")
        .doc(user!.email.toString() + widget.id)
        .update(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing Page"),
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
                  controller: widget.titlecontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    }
                    if (value.length > 15) {
                      return "Big length";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    }
                    if (5 > int.parse(value) || int.parse(value) > 5000) {
                      return "price in range of 5 - 5000";
                    } else {
                      return null;
                    }
                  },
                  controller: widget.pricecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.01,
                ),
                InputDecorator(
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(15.0)),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      isDense: true,
                      isExpanded: true,
                      menuMaxHeight: 350,
                      items: [
                        const DropdownMenuItem(
                          value: "",
                          child: Text(
                            "Select Category",
                          ),
                        ),
                        ...dropDownListData.map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem(
                              child: Text(e['title']), value: e['value']);
                        }).toList(),
                      ],
                      onChanged: (newValue) {
                        setState(
                          () {
                            selectedCategory = newValue!;
                          },
                        );
                      },
                    ),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    }
                    if (value.length > 200) {
                      return "Big length";
                    } else {
                      return null;
                    }
                  },
                  maxLines: null,
                  controller: widget.descriptioncontroller,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            selectedCategory != "") {
                          setState(() {
                            _isUploading = !_isUploading;
                          });
                          await sendtoserver(
                              widget.titlecontroller.text,
                              widget.pricecontroller.text,
                              widget.descriptioncontroller.text);

                          Dialogs.showSnackBar(context, "Updated Successfully");

                          Navigator.pop(context);
                        }
                      },
                      child: _isUploading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                backgroundColor: Colors.black,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text("Update")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
