import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/chatroom.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:provider/provider.dart';

class CreateAChatRoom extends StatefulWidget {
  const CreateAChatRoom({super.key});

  @override
  State<CreateAChatRoom> createState() => _CreateAChatRoomState();
}

class _CreateAChatRoomState extends State<CreateAChatRoom> {
  final _formkey = GlobalKey<FormState>();
  String? chatRoomName;
  String description = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Form(
        key: _formkey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              return (value == null) ? 'enter a ChatRoom Name' : null;
            },
            onChanged: (val) {
              setState(() {
                chatRoomName = val;
              });
            },
            decoration:
                textInputDecoration.copyWith(labelText: 'ChatRoom Name'),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            validator: (value) {
              return (value == null) ? 'enter a description' : null;
            },
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
            decoration:
                textInputDecoration.copyWith(labelText: 'ChatRoom Description'),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    controller.animateToPage(2,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  },
                  child: Text('Exit')),
              SizedBox(
                width: 20,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    (_formkey.currentState!.validate())
                        ? {
                            DataBaseService(email: user!.email!).createChatRoom(
                                chatRoomName!, description, user),
                            controller.animateToPage(1,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn)
                          }
                        : 'enter the required details';
                  },
                  child: Text('Modify ChatRoom'))
            ],
          )
        ]));
  }
}
