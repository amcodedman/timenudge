import 'package:flutter/material.dart';

class Forum extends StatefulWidget {
  Forum({Key? key});
  @override
  State<StatefulWidget> createState() {
    return _Forum();
  }
}

String? inputvalue;

class _Forum extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Uiist(),
        const Text("Forum"),
      ],
    );
  }
}

Widget Uiist() {
  return ListTile(
    title: Text("Monday learning", style: TextStyle(color: Colors.red)),
    subtitle: (Text(DateTime.now().toString())),
    trailing: const Icon(Icons.check_box),
  );
}
