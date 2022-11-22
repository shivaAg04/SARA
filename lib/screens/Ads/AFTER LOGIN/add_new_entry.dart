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
      "Pic": downloadUrl
    };

    await _firebaseFirestore
        .collection(user!.email.toString())
        .doc(id)
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
                  decoration: InputDecoration(
                    labelText: 'Price',
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
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
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
                        ? Text('Submit')
                        : CircularProgressIndicator(
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
