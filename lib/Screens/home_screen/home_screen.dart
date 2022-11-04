import 'dart:convert';

import 'package:chat_app/Screens/home_screen/home_screen_controller.dart';
import 'package:chat_app/api/firebase_api.dart';
import 'package:chat_app/data_models/user.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  @override
  final controller = Get.put(HomeScreenController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp",
            style: TextStyle(
              fontSize: 18,
            )),
        elevation: 10,
        backgroundColor: Colors.teal.shade700,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                debugPrint(snapshot.data.toString());
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) =>
                      _buildFeedTile(snapshot.data?.docs[index]),
                );
              } else {
                debugPrint("null data: ${snapshot.data}");
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.CONTACTSCREEN);
        },
        backgroundColor: Colors.teal.shade700,
        child: const Icon(Icons.message),
      ),
    );
  }

  _buildFeedTile(users) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Get.toNamed(AppRoutes.CHATSCREEN,
                arguments: {'id': users.id, 'name': users['name']});
          },
          dense: true,
          leading: CircleAvatar(
              radius: 30, backgroundImage: NetworkImage(users['urlAvatar'])),
          title: Text(
            users['name'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            users['lastMessageTime'].toString(),
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        Divider(
          thickness: 1.3,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
