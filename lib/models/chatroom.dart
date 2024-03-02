import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/services/database.dart';

class ChatRoom {
  late String createdBy;
  late var createdAt;
  late String groupId;
  late String name;
  late String description;

  ChatRoom(
      {required this.createdAt,
      required this.createdBy,
      required this.groupId,
      required this.name,
      required this.description});
}
