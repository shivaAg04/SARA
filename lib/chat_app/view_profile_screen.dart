import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiet_olx/chat_app/user_product_column.dart';

import '../helper/my_date_util.dart';
import '../main.dart';
import '../model/chat_user.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(title: Text(widget.user.name)),
          // floatingActionButton: //user about
          //     Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text(
          //       'Joined On: ',
          //       style: TextStyle(
          //           color: Colors.black87,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 15),
          //     ),
          //     Text(
          //         MyDateUtil.getLastMessageTime(
          //             context: context,
          //             time: widget.user.createdAt,
          //             showYear: true),
          //         style: const TextStyle(color: Colors.black54, fontSize: 15)),
          //   ],
          // ),

          //body
          body: Column(
            children: [
              // for adding some space
              SizedBox(width: mq.width, height: mq.height * .03),

              //user profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(mq.height * .1),
                child: CachedNetworkImage(
                  width: mq.height * .2,
                  height: mq.height * .2,
                  fit: BoxFit.cover,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),

              // for adding some space
              SizedBox(height: mq.height * .03),

              // user email label
              Text(widget.user.email,
                  style: const TextStyle(color: Colors.black87, fontSize: 16)),

              // for adding some space
              SizedBox(height: mq.height * .02),

              //user about
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'About: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Text(widget.user.about,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15)),
                ],
              ),

              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "  User Products",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromARGB(255, 1, 85, 129),
                  ),
                ),
              ),
              Expanded(child: UserProductColumn(user: widget.user)),
            ],
          )),
    );
  }
}
