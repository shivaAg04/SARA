import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:kiet_olx/api/apis.dart';

import 'package:kiet_olx/main.dart';
import 'package:kiet_olx/model/chat_user.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Screen"),
          centerTitle: true,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.width * .2),
                      child: CachedNetworkImage(
                        width: mq.height * .14,
                        height: mq.width * .3,
                        imageUrl: widget.user.image,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
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
                        onPressed: () {},
                        child: Icon(
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
                  widget.user.email,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(
                  height: mq.height * .02,
                ),
                TextFormField(
                  onSaved: (newValue) {
                    APIs.me.name = newValue ?? '';
                  },
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Required Field",
                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.orange),
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
                  initialValue: widget.user.about,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.info_outline, color: Colors.orange),
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
                      APIs.updateUser();
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "UPDATE",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
