import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/chatbubble.dart';
import 'package:flutter_application_1/services/cloudmesssaging.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/custom_error.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder(
        stream: DataBaseService(email: user!.email!).chatRoomData,
        builder: (context, snapshot) =>
            (snapshot.connectionState == ConnectionState.active)
                ? (snapshot.hasData)
                    ? Scaffold(
                        backgroundColor: Colors.blueGrey,
                        appBar: AppBar(
                          title: Text(
                            snapshot.data!.name,
                            style: TextStyle(fontSize: 20),
                          ),
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
                        body: Stack(children: [
                          ChatBubble(),
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: TextFormField(
                              controller: _controller,
                              onFieldSubmitted: (value) async {
                                DataBaseService(email: user.email!)
                                    .createMessage(value, user);
                                _controller.clear();

                                var chatUsers =
                                    await DataBaseService(email: user.email!)
                                        .listOfChatUsers
                                        .single;

                                AccessFirebaseToken()
                                    .sendPushNotification(chatUsers);
                              },
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'type a message...',
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.purpleAccent,
                                          width: 2.0))),
                            ),
                          ),
                        ]),
                      )
                    : (snapshot.hasError)
                        ? CustomError(error: snapshot.error.toString())
                        : Loading()
                : Loading());
  }
}
