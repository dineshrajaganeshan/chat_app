import 'package:chat_app/data_models/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreenController extends GetxController {
  String currentUserId = "";

  final _box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentUserId = FirebaseFirestore.instance.collection('users').doc().id;
    _box.write(USERID, currentUserId);
    debugPrint(_box.read(USERID));
    debugPrint("user Id: {$currentUserId}");
  }
}
