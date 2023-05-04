import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../api/apis.dart';
import '../../../helper/dialogs.dart';

class AddNewEntry extends StatefulWidget {
  AddNewEntry({Key? key}) : super(key: key);

  @override
  State<AddNewEntry> createState() => _AddNewEntryState();
}

class _AddNewEntryState extends State<AddNewEntry> {
  List dropDownListData = [
    {"title": "Sports", "value": "Sports"},
    {"title": "Stationary", "value": "Stationary"},
    {"title": "Electrical", "value": "Electrical"},
    {"title": "Others", "value": "Others"},
    {"title": "Quantum", "value": "Quantum"},
    {"title": "Coolers", "value": "Coolers"},
    {"title": "Lab Coat", "value": "Lab Coat"},
    {"title": "Calculators", "value": "Calculators"},
    {"title": "Decoration", "value": "Decoration"},
  ];

  String selectedCategory = "";
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController pricecontroller = TextEditingController();

  TextEditingController descriptioncontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? mainPic;
  String? downloadUrl;
  bool isuploaded = true;

  Future<void> sendtoserver(
      String serverTitle, String serverPrice, String serverDescription) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("productPicture")
        .child(APIs.user.uid)
        .child(time)
        .putFile(mainPic!);
    TaskSnapshot taskSnapshot = await uploadTask;
    downloadUrl = await taskSnapshot.ref.getDownloadURL();

    Map<String, dynamic> data = {
      "Title": serverTitle,
      "Price": serverPrice,
      "Description": serverDescription,
      "Id": APIs.user.uid,
      "Pic": downloadUrl,
      "Category": selectedCategory,
      "Email": APIs.user.email!,
      "sent": time
    };
    final ref = APIs.firestore.collection('Products');
    await ref.doc(time).set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Stack(
          children: [
            // The text border
            Text(
              'New Entry',
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
              'New Entry',
              style: GoogleFonts.lobster(
                fontSize: 20,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
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
                    }
                    if (value.length > 20) {
                      return "Big length";
                    } else {
                      return null;
                    }
                  },
                  controller: titlecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //PRICE
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
                            value: e['value'],
                            child: Text(e['title']),
                          );
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
                        } else {
                          Dialogs.showSnackBar(
                              context, "upload pic or select category");
                        }
                      },
                      child: isuploaded == true
                          ? const Text('Submit')
                          : const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                backgroundColor: Colors.black,
                                strokeWidth: 3,
                              ),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
