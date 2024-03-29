import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiet_olx/api/apis.dart';
import 'package:kiet_olx/helper/dialogs.dart';

import 'package:kiet_olx/main.dart';
import 'package:kiet_olx/model/chat_user.dart';
import 'package:kiet_olx/screens/home/splash/start_login.dart';

import 'Slider/slider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late ChatUser user;

  final _formkey = GlobalKey<FormState>();
  String? _image;
  @override
  void initState() {
    user = APIs.me;
    super.initState();
  }

  bool islogin = true;
  bool isupdated = true;
  Future<void> logout() async {
    setState(() {
      islogin = !islogin;
    });
    try {
      await GoogleSignIn().disconnect();
      APIs.updateActiveStatus(false);
      APIs.auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartLogin()));
    } catch (e) {
      setState(() {
        islogin = !islogin;
      });
      Dialogs.showSnackBar(context, "Some error in logout");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: SizedBox(
          child: Image.asset("assets/images/profilep.png"),
          height: MediaQuery.of(context).size.height * .15,
        ),
        // title: Stack(
        //   children: [
        //     // The text border
        //     Text(
        //       'Profile Screen',
        //       style: GoogleFonts.josefinSans(
        //         fontSize: 27,
        //         letterSpacing: 3,
        //         fontWeight: FontWeight.bold,
        //         foreground: Paint()
        //           ..style = PaintingStyle.stroke
        //           ..strokeWidth = 3
        //           ..color = Color.fromARGB(255, 1, 85, 129),
        //       ),
        //     ),

        //     Text(
        //       'Profile Screen',
        //       style: GoogleFonts.josefinSans(
        //         fontSize: 27,
        //         letterSpacing: 3,
        //         fontWeight: FontWeight.bold,
        //         color: Color.fromARGB(255, 255, 102, 0),
        //       ),
        //     ),
        //   ],
        // ),
        centerTitle: true,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          onPressed: () {
            logout();
          },
          icon: const Icon(Icons.logout),
          label: islogin
              ? const Text("Logout")
              : const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    backgroundColor: Colors.black,
                    strokeWidth: 3,
                  ),
                ),
        ),
      ),
      //body
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.width * 0.05),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: mq.width * .03,
                width: mq.width,
              ),
              Stack(
                children: [
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(mq.width * .2),
                          child: Image.file(
                            File(_image!),
                            width: mq.height * .14,
                            height: mq.width * .3,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(mq.width * .2),
                          child: CachedNetworkImage(
                            width: mq.height * .14,
                            height: mq.width * .3,
                            imageUrl: user.image,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                              child: Icon(
                                CupertinoIcons.person,
                                color: Color.fromARGB(255, 1, 85, 129),
                              ),
                            ),
                          ),
                        ),
                  Positioned(
                    right: -18,
                    bottom: -4,
                    child: MaterialButton(
                      height: 28,
                      color: Colors.white,
                      shape: CircleBorder(),
                      onPressed: () {
                        _showBottomSheet();
                      },
                      child: const Icon(
                        size: 19,
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              TextFormField(
                onSaved: (newValue) {
                  APIs.me.name = newValue ?? '';
                },
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : "Required Field",
                initialValue: user.name,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 255, 102, 0),
                  ),
                  label: const Text("Name"),
                  hintText: "  eg. Shiva Agrahari",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              TextFormField(
                onSaved: (val) => APIs.me.about = val ?? "",
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : "Required Field",
                initialValue: user.about,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.info_outline,
                    color: Color.fromARGB(255, 255, 102, 0),
                  ),
                  label: const Text("About"),
                  hintText: "  eg. I am using KIET OLX",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * .04,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: StadiumBorder(),
                      minimumSize: Size(mq.width * .5, mq.height * .06)),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      setState(() {
                        isupdated = !isupdated;
                      });
                      APIs.updateUser().then((value) {
                        setState(() {
                          isupdated = !isupdated;
                        });
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: isupdated
                      ? const Text(
                          "UPDATE",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )
                      : const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            backgroundColor: Colors.black,
                            strokeWidth: 3,
                          ),
                        )),
              if (APIs.me.email == "shiva.2024cs1129@kiet.edu")
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SliderControlScreen()),
                      );
                    },
                    child: Text("Slider")),
            ]),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
                EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .03),
            children: [
              const Text(
                "Pick a Profile Picture ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      fixedSize: Size(mq.width * .3, mq.height * .15),
                    ),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick an image.
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
//
                      if (image != null) {
                        setState(() {
                          _image = image.path;
                        });
                        APIs.updateProfilePicture(File(_image!));
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset("assets/images/add_image.png"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick an image.
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
// Capture a photo.
//
                      if (image != null) {
                        setState(() {
                          _image = image.path;
                        });
                        APIs.updateProfilePicture(File(_image!));

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      fixedSize: Size(mq.width * .3, mq.height * .15),
                    ),
                    child: Image.asset("assets/images/camera.png"),
                  ),
                ],
              )
            ],
          );
        });
  }
}
