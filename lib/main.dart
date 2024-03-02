import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/authenticate/getstarted.dart';
import 'package:flutter_application_1/screens/home/chatrooms/chatroomscreen.dart';
import 'package:flutter_application_1/screens/home/chats/chatuserscreen.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/screens/initial.dart';
import 'package:flutter_application_1/screens/wrapper.dart';
import 'package:flutter_application_1/services/authservice.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().userStream,
      initialData: null,
      child: MaterialApp(
        initialRoute: '/initial',
        routes: {
          '/wrapper': (context) => const Wrapper(),
          '/initial': (context) => const Initial(),
          '/home': (context) => const Home(),
          '/getstarted': (context) => const GetStarted(),
          '/chatuserscreen': (context) => const ChatUserScreen(),
          '/chatroomscreen': (context) => const ChatRoomScreen()
        },
      ),
    );
  }
}
