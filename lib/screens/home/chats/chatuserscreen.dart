import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class ChatUserScreen extends StatefulWidget {
  const ChatUserScreen({super.key});

  @override
  State<ChatUserScreen> createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder(
        stream: DataBaseService(email: user!.email!).chatUserStream,
        builder: (context, snapshot) => (snapshot.hasData)
            ? Scaffold(
                backgroundColor: Colors.blueGrey,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: 30,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              )
            : Loading());
  }
}
