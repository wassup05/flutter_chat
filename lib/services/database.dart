import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/chatroom.dart';
import 'package:flutter_application_1/models/chatuser.dart';
import 'package:flutter_application_1/models/message.dart';

class DataBaseService {
  late String email;

  DataBaseService({required this.email});

  final CollectionReference chatUserCollection =
      FirebaseFirestore.instance.collection('chatUsers');

  final CollectionReference chatRoomCollection =
      FirebaseFirestore.instance.collection('chatRooms');

  final CollectionReference messages =
      FirebaseFirestore.instance.collection('Messages');

  Future<void> updateChatUserData(
      String displayName,
      String userName,
      String bio,
      String location,
      String photoURL,
      String email,
      String uid) async {
    return await chatUserCollection.doc(email).set({
      'photoURL': photoURL,
      'displayName': displayName,
      'userName': userName,
      'bio': bio,
      'location': location,
      'email': email,
      'uid': uid
    });
  }

  Future<void> updatePushToken(String? token) async {
    return await chatUserCollection.doc(email).update({'pushToken': token});
  }

  List<ChatUser?> chatUserListFromCollection(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => ChatUser(
            pushToken: e.get('pushToken'),
            photoURL: e.get('photoURL'),
            displayName: e.get('displayName'),
            bio: e.get('bio'),
            userName: e.get('userName'),
            location: e.get('location'),
            uid: e.get('uid'),
            email: email))
        .toList();
  }

  Stream<List<ChatUser?>> get listOfChatUsers {
    return chatUserCollection.snapshots().map(chatUserListFromCollection);
  }

  ChatUser? getChatUser(DocumentSnapshot snapshot) {
    return ChatUser(
        pushToken: snapshot.get('pushToken'),
        photoURL: snapshot.get('photoURL'),
        displayName: snapshot.get('displayName'),
        bio: snapshot.get('bio'),
        userName: snapshot.get('userName'),
        location: snapshot.get('location'),
        uid: snapshot.get('uid'),
        email: email);
  }

  Stream<ChatUser?> get chatUserStream {
    return chatUserCollection.doc(email).snapshots().map(getChatUser);
  }

  void createChatRoom(String name, String? description, User? user) {
    DataBaseService(email: user!.email!)
        .chatRoomCollection
        .doc('supritsj05@gmail.com')
        .set({
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': user.uid,
      "groupId":
          DataBaseService(email: user.email!).chatRoomCollection.doc().id,
      'name': name,
      'description': description
    });
  }

  List<ChatRoom?> getListOfChatRoom(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => ChatRoom(
            description: e.get('description'),
            createdAt: e.get('createdAt'),
            createdBy: e.get('createdBy'),
            groupId: e.get('groupId'),
            name: e.get('name')))
        .toList();
  }

  Stream<List<ChatRoom?>> get chatRooms {
    return chatRoomCollection.snapshots().map(getListOfChatRoom);
  }

  ChatRoom? getChatRoomData(DocumentSnapshot snapshot) {
    return ChatRoom(
        description: snapshot.get('description'),
        createdAt: snapshot.get('createdAt'),
        createdBy: snapshot.get('createdBy'),
        groupId: snapshot.get('groupId'),
        name: snapshot.get('name'));
  }

  Stream<ChatRoom?> get chatRoomData {
    return chatRoomCollection
        .doc('supritsj05@gmail.com')
        .snapshots()
        .map(getChatRoomData);
  }

  void createMessage(String message, User? user) {
    messages.doc('supritsj05@gmail.com').collection('messages*').doc().set({
      'sentAt': FieldValue.serverTimestamp(),
      'sentBy': user!.displayName,
      'message': message,
      'senderId': user.uid,
      'senderPhotoURL': user.photoURL,
      'dateTime': DateTime.now().toString().substring(11, 16)
    });
  }

  List<Message?> getListOfMessages(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => Message(
            dateTime: e.get('dateTime'),
            senderPhotoURL: e.get('senderPhotoURL'),
            sentAt: e.get('sentAt'),
            sentBy: e.get('sentBy'),
            message: e.get('message')))
        .toList();
  }

  Stream<List<Message?>> get messageListStream {
    return messages
        .doc('supritsj05@gmail.com')
        .collection('messages*')
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map(getListOfMessages);
  }
}
