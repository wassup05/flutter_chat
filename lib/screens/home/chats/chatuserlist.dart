import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class ChatUserList extends StatefulWidget {
  const ChatUserList({super.key});

  @override
  State<ChatUserList> createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder(
        initialData: null,
        stream: DataBaseService(email: user!.email!).listOfChatUsers,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.active)
              ? (snapshot.hasData)
                  ? ListView.separated(
                      itemBuilder: (context, index) => TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/chatuserscreen',
                              );
                            },
                            child: ListTile(
                              subtitle: Text(
                                snapshot.data![index]!.bio,
                                style: TextStyle(fontSize: 20),
                              ),
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                      snapshot.data![index]!.photoURL)),
                              title: Text(
                                snapshot.data![index]!.displayName,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => const Divider(
                            height: 0,
                            thickness: 0,
                            color: Colors.transparent,
                          ),
                      itemCount: snapshot.data!.length)
                  : const Loading()
              : Loading();
        });
  }
}
