import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:kiet_olx/model/chat_user.dart';
import 'package:kiet_olx/model/products.dart';

import '../helper/dialogs.dart';
import '../model/messages.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static GoogleSignIn googleSignIn = GoogleSignIn();
  static User get user => auth.currentUser!;
  static ChatUser me = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I'm SARA!",
      image: user.photoURL.toString(),
      createdAt: '',
      isOnline: false,
      lastActive: '',
      pushToken: '');

  static List SliderList = ["", "", "", "", ""];

  static Future<void> getSliderList() async {
    var res = await firestore.collection('Slider').doc('pic').get();
    Map<String, dynamic>? data = res.data();
    SliderList[0] = data!['first'];
    SliderList[1] = data['second'];
    SliderList[2] = data['third'];
    SliderList[3] = data['fourth'];
    SliderList[4] = data['fifth'];
  }

  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

// for getting messaging token
  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
      }
    });
  }

  // for sending push notification
  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAl5NKeY8:APA91bFO2H4I1LLCSkr-em80g3yO93eDFGxuORVeV7hDHIhWs8VSnVf98XwA-0fZVpnNmR3FK3slx5QA6BJy35S3ipX93Z8b1Aw79fs8jMHXek04Mr7CwKyUWIRmRZkOnBVixWWwd8He'
          },
          body: jsonEncode(body));
    } catch (e) {
      // log('\nsendPushNotificationE: $e');
    }
  }
// add chat user

  // for adding an chat user for our conversation
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    print('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      //user exists

      print('user exists: ${data.docs.first.data()}');

      firestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }

  // for getting id's of known users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  // for adding an user to my user when first message is send
  static Future<void> sendFirstMessage(
      ChatUser chatUser, String msg, Type type) async {
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // for getting all users from firestore database
  static Stream<List<ChatUser>> getAllUsers(List<String> userIds) async* {
    List<ChatUser> mlist = [];
    for (var str in userIds) {
      var mdata = await firestore.collection('users').doc(str).get();
      if (mdata != null) {
        ChatUser cu = ChatUser.fromJson(mdata.data()!);
        mlist.add(cu);
      }
    }
    yield mlist;
  }

  // google login

  static Future<OAuthCredential?> googleLogin(BuildContext context) async {
    //show circular
    Dialogs.showProgressBar(context);
    try {
      await InternetAddress.lookup('google.com');
      var googleAc = await googleSignIn.signIn();
      Navigator.pop(context);
      if (googleAc == null) {
        return null;
      }
      // for kiet id only
      if (googleAc.email.endsWith("@kiet.edu")) {
        final userData = await googleAc.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: userData.accessToken, idToken: userData.idToken);

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => Navigator.pop(context));
        if ((await APIs.userExists() == false)) {
          await APIs.creatUser();
        }
        return credential;
      } else {
        await googleSignIn.disconnect().then((value) {
          Dialogs.showSnackBar(context, "Only KIET MAIL");
          return null;
        });
      }
      ////////////////////////////
      // for all gmail account
      // final userData = await googleAc.authentication;
      // final credential = GoogleAuthProvider.credential(
      //     accessToken: userData.accessToken, idToken: userData.idToken);

      // await FirebaseAuth.instance
      //     .signInWithCredential(credential)
      //     .then((value) => Navigator.pop(context));
      // if ((await APIs.userExists() == false)) {
      //   await APIs.creatUser();
      ///////////////////
    } catch (error) {
      Dialogs.showSnackBar(context, "  No Internet");
      Navigator.pop(context);
    }
    return null;
  }

  //////////////////////////////////////////////////

  static Future<void> creatUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        about: "Hey, I am Using KIETOLX",
        name: user.displayName.toString(),
        createdAt: time,
        isOnline: false,
        id: user.uid,
        lastActive: time,
        email: user.email.toString(),
        pushToken: ' ');

    await firestore.collection('users').doc(user.uid).set(
          chatUser.toJson(),
        );
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();

        APIs.updateActiveStatus(true);
      } else {
        await creatUser().then((value) => getSelfInfo());
      }
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updateUser() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;

    final ref = storage.ref().child('profilePicture').child('${user.uid}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser chatUser) {
    return firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

// for getting the products of specific user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserProducts() {
    return firestore
        .collection('Products')
        .where('Id', isEqualTo: user.uid)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) {
      // sendPushNotification(chatUser, type == Type.text ? msg : "image");
    });
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //send chat image
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  //delete message
  static Future<void> deleteMessage(Message message) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image) {
      await storage.refFromURL(message.msg).delete();
    }
  }

  //update message
  static Future<void> updateMessage(Message message, String updatedMsg) async {
    await firestore
        .collection('chats/${getConversationID(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': updatedMsg});
  }

  // sending Product

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts(
      ChatUser chatUser) {
    return firestore.collection('products').snapshots();
  }

  // sending product

  // for sending message
  static Future<void> sendProduct(String email, String category, String title,
      String pic, String description, String price) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send

    final Products product = Products(
        Email: email,
        Category: category,
        Description: description,
        Price: price,
        Title: title,
        Pic: pic,
        Id: me.id);

    final ref = firestore.collection('products/${me.id}/items/');
    await ref.doc(time).set(product.toJson());
  }
}
