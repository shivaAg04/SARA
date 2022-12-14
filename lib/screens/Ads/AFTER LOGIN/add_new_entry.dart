import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddNewEntry extends StatefulWidget {
  AddNewEntry({Key? key}) : super(key: key);

  @override
  State<AddNewEntry> createState() => _AddNewEntryState();
}

class _AddNewEntryState extends State<AddNewEntry> {
  List dropDownListData = [
    {"title": "SPORTS", "value": "SPORTS"},
    {"title": "STATIONARY", "value": "STATIONARY"},
    {"title": "ELECTRICAL", "value": "ELECTRICAL"},
    {"title": "OTHERS", "value": "OTHERS"},
  ];

  String selectedCategory = "";
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController pricecontroller = TextEditingController();

  TextEditingController descriptioncontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? user = _auth.currentUser;

  File? mainPic;
  String? downloadUrl;
  bool isuploaded = true;

  sendtoserver(
      String serverTitle, String serverPrice, String serverDescription) async {
    String id = DateTime.now().toIso8601String();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("profilepictures")
        .child(Uuid().v1())
        .putFile(mainPic!);
    TaskSnapshot taskSnapshot = await uploadTask;
    downloadUrl = await taskSnapshot.ref.getDownloadURL();
    Map<String, dynamic> data = {
      "Title": serverTitle,
      "Price": serverPrice,
      "Description": serverDescription,
      "Id": id,
      "Pic": downloadUrl,
      "Category": selectedCategory,
      "Email": user!.email!,
    };

    await _firebaseFirestore
        .collection("Products")
        .doc(user!.email! + id)
        .set(data);
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
                // IMAGE CAPTURE
                InkWell(
                  onTap: () async {
                    XFile? selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (selectedImage != null) {
                      File convertedFile = File(selectedImage.path);
                      setState(() {
                        mainPic = convertedFile;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey,
                    child: (mainPic != null)
                        ? Image(image: FileImage(mainPic!))
                        : Icon(Icons.camera),
                  ),
                ),
                // TITLE
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //PRICE
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter value";
                    } else {
                      return null;
                    }
                  },
                  controller: pricecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
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
                        const DropdownMenuItem(
                            value: "",
                            child: Text(
                              "Select Category",
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
                  controller: descriptioncontroller,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          selectedCategory != "" &&
                          downloadUrl != "") {
                        setState(() {
                          isuploaded = false;
                        });
                        await sendtoserver(titlecontroller.text,
                            pricecontroller.text, descriptioncontroller.text);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Uploaded Data')),
                        );
                        titlecontroller.clear();
                        pricecontroller.clear();
                        descriptioncontroller.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: isuploaded == true
                        ? const Text('Submit')
                        : const CircularProgressIndicator(
                            backgroundColor: Colors.black),
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
