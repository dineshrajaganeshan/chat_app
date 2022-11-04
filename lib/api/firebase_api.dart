import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data_models/message.dart';
import '../data_models/user.dart';

class FirebaseApi {
  FirebaseApi.init();
  static final FirebaseApi instance = FirebaseApi.init();

  FirebaseAuth? _firebaseAuth;

  FirebaseAuth? initializeAuth() {
    if (_firebaseAuth != null) {
      return _firebaseAuth;
    }

    _firebaseAuth = FirebaseAuth.instance;
    return _firebaseAuth;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getData(
      String userData) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection(userData).get();

    return Future.value(querySnapshot.docs);
  }

  getChats(String userData) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        (await FirebaseFirestore.instance.collection(userData).doc(userList.id))
            as QuerySnapshot<Map<String, dynamic>>;

    return Future.value(querySnapshot.docs);
  }

  final CollectionReference userList =
      FirebaseFirestore.instance.collection('users');

  static Stream getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots();

  static Future addRandomUsers(List<UserData> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (UserData user in users) {
        final userDoc = refUsers.doc();

        await userDoc.set(user.toJson());
      }
    }
  }

  static Future sendMessageToFireBase(
      List<Message> message, String authId) async {
    final refMsg = FirebaseFirestore.instance
        .collection('users')
        .doc(authId)
        .collection("chats");

    final allMsg = await refMsg.get();
    if (allMsg.size != 0) {
      return;
    } else {
      for (Message msg in message) {
        final msgDoc = refMsg.doc();

        await msgDoc.set(msg.toJson());
      }
    }
  }
}
