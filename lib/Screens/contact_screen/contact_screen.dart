import 'package:chat_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_screen_controller.dart';

class ContactScreen extends GetView<ContactScreenController> {
  @override
  final controller = Get.put(ContactScreenController());

  ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        title: const Text("Contact",
            style: TextStyle(
              fontSize: 18,
            )),
        elevation: 10,
        backgroundColor: Colors.teal.shade700,
      ),
      body: SafeArea(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: 10,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => _buildContactTile())),
    );
  }
}

_buildContactTile() {
  return Column(
    children: [
      ListTile(
        onTap: () {
          Get.toNamed(AppRoutes.CHATSCREEN);
        },
        dense: true,
        leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoXIxPG_PwKeAF-KX82a5eiC7JvpYMOzYUSg&usqp=CAU")),
        title: Text(
          "Rock",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          "hi!",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
      const Divider(
        thickness: 1.3,
        indent: 10,
        endIndent: 10,
      ),
    ],
  );
}
