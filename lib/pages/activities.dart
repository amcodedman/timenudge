import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  Activities({Key? key});
  @override
  State<StatefulWidget> createState() {
    return _Activities();
  }
}

class _Activities extends State<StatefulWidget> {
  double _radius = 5;
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("Activities"), _circleAnim()]);
  }

  Widget _circleAnim() {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_radius),
            color: Color.fromARGB(255, 48, 42, 42)),
      ),
      onDoubleTap: () {
        setState(() {
          _radius += 10;
          if (_radius > 50) {
            _radius = 1;
          }
        });
      },
    );
  }
}
