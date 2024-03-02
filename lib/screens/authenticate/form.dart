import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/chatuser.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/services/cloudmesssaging.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/custom_error.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Formy extends StatefulWidget {
  const Formy({super.key});

  @override
  State<Formy> createState() => _FormyState();
}

class _FormyState extends State<Formy> {
  final _formKey = GlobalKey<FormState>();
  final PageController _controller = PageController();
  var displayName = '';
  var bio = '';
  var location = '';
  var userName = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<ChatUser?>(
        stream: DataBaseService(email: user!.email!).chatUserStream,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? const Home()
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurple[200],
                  ),
                  backgroundColor: Colors.white,
                  body: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[300]),
                          margin: const EdgeInsets.symmetric(
                              vertical: 80, horizontal: 40),
                          child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Please enter your details',
                                      style: TextStyle(
                                          color: Colors.blue[400],
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      onChanged: (value) => setState(() {
                                        displayName = value;
                                      }),
                                      validator: (value) {
                                        return (value == null)
                                            ? 'enter your name or google acc name will be considered'
                                            : null;
                                      },
                                      decoration: textInputDecoration.copyWith(
                                          labelText: 'Name',
                                          hintText:
                                              'what do you like to be called by people',
                                          constraints: const BoxConstraints(
                                              maxWidth: 250)),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                      onChanged: (value) => setState(() {
                                        userName = value;
                                      }),
                                      validator: (value) {
                                        return (value == null || value.isEmpty)
                                            ? 'enter a unique username'
                                            : null;
                                      },
                                      decoration: textInputDecoration.copyWith(
                                          labelText: 'Username',
                                          hintText:
                                              'a unique username to identify you',
                                          constraints: const BoxConstraints(
                                              maxWidth: 250)),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                        onChanged: (value) => setState(() {
                                              bio = value;
                                            }),
                                        validator: (value) {
                                          return null;
                                        },
                                        decoration:
                                            textInputDecoration.copyWith(
                                                labelText: 'Bio',
                                                hintText: 'Something about you',
                                                constraints:
                                                    const BoxConstraints(
                                                        maxWidth: 250))),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    TextFormField(
                                      onChanged: (value) => setState(() {
                                        location = value;
                                      }),
                                      validator: (value) {
                                        return null;
                                      },
                                      decoration: textInputDecoration.copyWith(
                                          labelText: 'Location',
                                          hintText: 'where are you from?',
                                          constraints: const BoxConstraints(
                                              maxWidth: 250)),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                          fixedSize:
                                              const MaterialStatePropertyAll(
                                                  Size(250, 50)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.deepPurple[200])),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _controller.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        }
                                      },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Center(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              'Thanks for Signing In',
                              style: TextStyle(
                                  color: Colors.blue[400],
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              height: 75,
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  fixedSize: const MaterialStatePropertyAll(
                                      Size(250, 50)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.deepPurple[200])),
                              onPressed: () async {
                                await DataBaseService(email: user!.email!)
                                    .updateChatUserData(
                                        (displayName == '')
                                            ? user.displayName!
                                            : displayName,
                                        userName,
                                        bio,
                                        location,
                                        user.photoURL!,
                                        user.email!,
                                        user.uid);
                                await CloudMessagingService().initialise().then(
                                  (value) {
                                    DataBaseService(email: user!.email!)
                                        .updatePushToken(value);
                                  },
                                );
                              },
                              child: const Text(
                                'Get to Home',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                );
        });
  }
}
