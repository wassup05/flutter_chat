import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  late String error;

  CustomError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        '$error.  Sorry for the inconvinience caused',
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      backgroundColor: Colors.grey[350],
      title: const ListTile(
        leading: Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
          size: 25,
        ),
        title: Text(
          "Error!",
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      titlePadding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue[300])),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('okay'))
      ],
    );
  }
}
