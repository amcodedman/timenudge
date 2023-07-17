import 'package:flutter/widgets.dart';

class Heightspacer extends StatelessWidget {
  final double value;
  const Heightspacer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value);
  }
}
