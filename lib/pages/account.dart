import 'package:flutter/material.dart';

class MyAccout extends StatefulWidget {
  MyAccout({Key? key});
  @override
  State<StatefulWidget> createState() {
    return _Account();
  }
}

class _Account extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("My account")],
    );
  }
}
