import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final _formKey1 = GlobalKey<FormState>();
  late String displayName;
  late String bio;
  late String location;
  late String userName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder(
        stream: DataBaseService(email: user!.email!).chatUserStream,
        builder: (context, snapshot) => (snapshot.connectionState ==
                ConnectionState.active)
            ? (snapshot.hasData)
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Center(
                        child: Form(
                            key: _formKey1,
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: snapshot.data!.displayName)),
                                    onChanged: (value) => setState(() {
                                      displayName = value;
                                    }),
                                    validator: (value) {
                                      return (value == null)
                                          ? 'enter your name'
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
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: snapshot.data!.userName)),
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
                                      controller:
                                          TextEditingController.fromValue(
                                              TextEditingValue(
                                                  text: snapshot.data!.bio)),
                                      onChanged: (value) => setState(() {
                                            bio = value;
                                          }),
                                      validator: (value) {
                                        return null;
                                      },
                                      decoration: textInputDecoration.copyWith(
                                          labelText: 'Bio',
                                          hintText: 'Something about you',
                                          constraints: const BoxConstraints(
                                              maxWidth: 250))),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextFormField(
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: snapshot.data!.location)),
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
                                  )
                                ],
                              ),
                            ))),
                  )
                : Loading()
            : Loading());
  }
}
