import 'package:flutter/widgets.dart';

class WidthSpacer extends StatelessWidget {
  final double value;
  const WidthSpacer({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value);
  }
}
