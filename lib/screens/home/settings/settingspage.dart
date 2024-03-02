import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(user!.photoURL!),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              user.email!,
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
              onPressed: () {
                controller.animateToPage(4,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'User Settings',
                  style: TextStyle(fontSize: 25),
                ),
              )),
          TextButton(
              onPressed: () {
                controller.animateToPage(3,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              child: ListTile(
                leading: Icon(Icons.group_add_sharp),
                title: Text(
                  'Modify ChatRoom',
                  style: TextStyle(fontSize: 25),
                ),
              )),
        ],
      ),
    );
  }
}
