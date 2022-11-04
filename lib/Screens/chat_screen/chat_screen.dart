import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_screen_controller.dart';

class ChatScreen extends GetView<ChatScreenController> {
  @override
  final controller = Get.put(ChatScreenController());

  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(18);
    final borderRadius = BorderRadius.all(radius);
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
          title: Text(controller.name,
              style: TextStyle(
                fontSize: 18,
              )),
          elevation: 10,
          backgroundColor: Colors.teal.shade700,
          /*actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoXIxPG_PwKeAF-KX82a5eiC7JvpYMOzYUSg&usqp=CAU"),
          ),
        ],*/
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: controller.isMe
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(controller.id)
                      .collection('messages')
                      .doc(controller.friendId)
                      .collection('chats')
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      debugPrint("id: ${controller.id}");
                      debugPrint("chat data: ${snapshot.data.toString()}");
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data.docs.length,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (_, index) {
                          controller.isMe = snapshot.data.docs[index]
                                  ['senderId'] ==
                              controller.id;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: controller.isMe
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(16),
                                    constraints:
                                        const BoxConstraints(maxWidth: 140),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: controller.isMe
                                            ? borderRadius.subtract(
                                                BorderRadius.only(
                                                    bottomRight: radius))
                                            : borderRadius.subtract(
                                                BorderRadius.only(
                                                    bottomLeft: radius))),
                                    child: Text(
                                      snapshot.data.docs[index]['message'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      debugPrint("no data");
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        autocorrect: true,
                        enableSuggestions: true,
                        minLines: 1,
                        maxLines: 20,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Type your message...",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            gapPadding: 10,
                            borderSide: const BorderSide(
                              width: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.sendMessage();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 52,
                        width: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade700,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.send,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
