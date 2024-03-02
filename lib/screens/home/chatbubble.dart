import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({super.key});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder(
      stream: DataBaseService(email: user!.email!).messageListStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return (snapshot.data![index]!.sentBy == user.displayName)
                      ? BubbleNormal(
                          bubbleRadius: 20,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          color: Colors.green,
                          isSender: true,
                          text:
                              "${data![index]!.message}    ${data[index]!.dateTime}")
                      : BubbleNormal(
                          isSender: false,
                          bubbleRadius: 20,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              snapshot.data![index]!.senderPhotoURL,
                              width: 25,
                              height: 25,
                            ),
                          ),
                          text:
                              "${data![index]!.message}    ${data[index]!.dateTime}");
                });
          } else {
            return Loading();
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
