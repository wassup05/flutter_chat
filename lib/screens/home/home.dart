import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/chatrooms/chatroomlist.dart';
import 'package:flutter_application_1/screens/home/settings/editchatroom.dart';
import 'package:flutter_application_1/screens/home/chats/chatuserlist.dart';
import 'package:flutter_application_1/screens/home/settings/settingspage.dart';
import 'package:flutter_application_1/screens/home/settings/usersettings.dart';
import 'package:flutter_application_1/services/authservice.dart';
import 'package:flutter_application_1/services/cloudmesssaging.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/custom_error.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

PageController controller = PageController();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    CloudMessagingService().initialise().then(
      (value) {
        DataBaseService(email: user!.email!).updatePushToken(value);
      },
    );

    return StreamBuilder(
        stream: DataBaseService(email: user!.email!).chatUserStream,
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.active)
              ? (snapshot.hasData)
                  ? Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.add),
                      ),
                      drawer: Drawer(
                        backgroundColor: Colors.orange[200],
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user!.photoURL!),
                                  radius: 30,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(snapshot.data!.displayName),
                                SizedBox(height: 5),
                                Text(snapshot.data!.email),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                    onPressed: () async {
                                      await AuthService().signOutWithGoogle();
                                    },
                                    child: const ListTile(
                                      trailing: Icon(Icons.arrow_back_ios),
                                      leading: Icon(
                                        Icons.g_mobiledata_sharp,
                                        size: 35,
                                      ),
                                      title: Text(
                                        'Sign Out',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ))
                              ]),
                        ),
                      ),
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(130),
                        child: Column(children: [
                          AppBar(
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    controller.animateToPage(2,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  },
                                  icon: Icon(
                                    Icons.settings_rounded,
                                    size: 25,
                                  ))
                            ],
                            title: Text('Medos'),
                            backgroundColor: Colors.deepPurple[200],
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            buttonHeight: 45,
                            buttonPadding: const EdgeInsets.all(6),
                            children: [
                              TextButton(
                                  onPressed: () {
                                    controller.animateToPage(0,
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeIn);
                                  },
                                  child: const Text(
                                    'Chats',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontStyle: FontStyle.italic),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    controller.animateToPage(1,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  },
                                  child: const Text(
                                    'Chatrooms',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontStyle: FontStyle.italic),
                                  ))
                            ],
                          )
                        ]),
                      ),
                      body: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: const [
                          ChatUserList(),
                          ChatRoomList(),
                          SettingsPage(),
                          CreateAChatRoom(),
                          UserSettings()
                        ],
                      ),
                    )
                  : (snapshot.hasError)
                      ? CustomError(error: snapshot.error.toString())
                      : Loading()
              : Loading();
        });
  }
}
