import 'dart:async';
import 'package:flutter/material.dart';

class Initial extends StatefulWidget {
  const Initial({super.key});

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      Navigator.pushReplacementNamed(context, '/wrapper');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset("assets/ic_launcher.png"),
    );
  }
}
