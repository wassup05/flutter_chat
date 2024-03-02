import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/authenticate/getstarted.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/custom_error.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/chatroom.dart';

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({super.key});

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder(
      stream: DataBaseService(email: user!.email!).chatRooms,
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.active)
            ? (snapshot.hasData)
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/chatroomscreen');
                          },
                          child: ListTile(
                            leading: ClipRRect(
                              child: Image.network(
                                  'https://cdn6.aptoide.com/imgs/1/2/2/1221bc0bdd2354b42b293317ff2adbcf_icon.png'),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            title: Text(
                              snapshot.data![index]!.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              snapshot.data![index]!.description,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ))
                : (snapshot.hasError)
                    ? CustomError(error: snapshot.error.toString())
                    : Loading()
            : Loading();
      },
    );
  }
}
