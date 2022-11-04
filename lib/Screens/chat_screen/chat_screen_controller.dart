import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data_models/constant.dart';

class ChatScreenController extends GetxController {
  String name = Get.arguments['name'];
  String id = Get.arguments['id'];
  String friendId = "PeRqCk7ThgI3jxO95PqJ";
  final messageController = TextEditingController();
  RxString msg1 = "hello".obs;
  String msg = "";

  bool isMe = false;

  sendMessage() async {
    msg1(messageController.text);
    msg = messageController.text;
    messageController.clear();
    debugPrint("userID: ${id}");
    debugPrint("friendID: ${friendId}");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('messages')
        .doc(friendId)
        .collection('chats')
        .add({
      "senderId": id,
      "receiverId": friendId,
      "message": msg,
      "type": "text",
      "date": DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('messages')
          .doc(friendId)
          .set({
        'last_msg': msg,
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(friendId)
        .collection('messages')
        .doc(id)
        .collection("chats")
        .add({
      "senderId": id,
      "receiverId": friendId,
      "message": msg,
      "type": "text",
      "date": DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .collection('messages')
          .doc(id)
          .set({"last_msg": msg});
    });

    print(msg);
  }
}
