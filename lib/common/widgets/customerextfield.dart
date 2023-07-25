import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.hint,
      required this.preficon,
      required this.onChange,
      this.secure,
      this.autocor,
      this.suffix});

  final String hint;
  final Widget? preficon;
  final Widget? suffix;
  late bool? secure = false;
  final bool? autocor;

  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: AppConsts.kwidth * 0.8,
      height: 50,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 184, 183, 183)
                  .withOpacity(0.3), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 2), // Offset
            ),
          ],
          color: Color.fromARGB(255, 222, 222, 223),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: TextField(
          onChanged: onChange,
          obscureText: secure!,
          decoration: InputDecoration(
              prefixIcon: GestureDetector(child: preficon),
              suffixIcon:
                  suffix == null ? null : GestureDetector(child: suffix),
              hintText: hint,
              hintStyle: appStyle(12, AppConsts.kBKDark, FontWeight.normal),
              hoverColor: AppConsts.kBKDark,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 230, 243, 237)), //<-- SEE HERE
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 198, 207, 203)), //<-- SEE HERE

                borderRadius: BorderRadius.circular(10.0),
              ))),
    );
  }
}
