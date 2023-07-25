import 'package:flutter/material.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/resuables.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
      required this.onTap,
      required this.height,
      required this.width,
      required this.color2,
      required this.color3,
      required this.text1});

  final void Function()? onTap;
  final double height;
  final double width;
  final Color color2;
  final Color color3;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color2,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: color3)),
        child: Reusables(
          text: text1,
          style: appStyle(11, color3, FontWeight.bold),
        ),
      ),
    );
  }
}
