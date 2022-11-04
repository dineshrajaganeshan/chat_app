import 'package:meta/meta.dart';

import '../utils/utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class UserData {
  late String idUser;
  late String name;
  late String urlAvatar;
  late DateTime lastMessageTime;

  UserData({
    required this.name,
    required this.urlAvatar,
    required this.lastMessageTime,
    required this.idUser,
  });

  /*User copyWith(String name, String urlAvatar, DateTime lastMessageTime,
          {required String idUser}) =>
      User(
        idUser: idUser,
        name: name,
        urlAvatar: urlAvatar,
        lastMessageTime: lastMessageTime,
      );*/

  static UserData fromJson(Map<String, dynamic> json) => UserData(
        idUser: json['idUser'],
        name: json['name'],
        urlAvatar: json['urlAvatar'],
        lastMessageTime: (json['lastMessageTime']).toDate,
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'urlAvatar': urlAvatar,
        'lastMessageTime': lastMessageTime.toUtc(),
      };
}
