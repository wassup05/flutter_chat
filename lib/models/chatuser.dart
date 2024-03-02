import 'package:flutter/material.dart';

bool isLight = true;

class ChatUser {
  late String photoURL;
  late String uid;
  late String displayName;
  late String bio;
  late String userName;
  late String location;
  late String email;
  late String pushToken;

  ChatUser(
      {required this.displayName,
      required this.bio,
      required this.userName,
      required this.location,
      required this.uid,
      required this.photoURL,
      required this.email,
      required this.pushToken});

  ThemeMode themeModeChanger() {
    return (isLight = true) ? ThemeMode.light : ThemeMode.dark;
  }
}
