import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  sendtoserver(
      String serverTitle, String serverPrice, String serverDescription) async {
    Map<String, dynamic> data = {
      "Title": serverTitle,
      "Price": serverPrice,
      "Description": serverDescription,
      "Category": selectedCategory
    };

    await _firebaseFirestore
        .collection(user!.email.toString())
        .doc(widget.id)
        .update(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing Page"),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    } else {
                      return null;
                    }
                  },
                  controller: widget.pricecontroller,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                SizedBox(
                  height: 20,
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
                        DropdownMenuItem(
                            value: "",
                            child: Text(
                              widget.Category,
                            )),
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
                    } else {
                      return null;
                    }
                  },
                  controller: widget.descriptioncontroller,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await sendtoserver(
                            widget.titlecontroller.text,
                            widget.pricecontroller.text,
                            widget.descriptioncontroller.text);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Updated Data')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update'),
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
