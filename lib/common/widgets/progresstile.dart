import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/widgets/tiltles.dart';

class ProgressTile extends StatelessWidget {
  ProgressTile(
      {Key? key,
      this.text1,
      this.text2,
      this.color,
      this.progressb,
      required this.children,
      this.trailing,
      this.onExpensionchange});
  final String? text1;
  final Widget? progressb;
  final String? text2;
  final Color? color;
  final Widget? trailing;
  final List<Widget> children;
  final void Function(bool)? onExpensionchange;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppConsts.kwidth * 0.99.w,
        padding: EdgeInsets.only(left: 10, right: 2),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 202, 203, 205),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpansionTile(
                  title: progressb!,
                  subtitle: Text(
                    text2!,
                    style: TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 48, 39, 53),
                        fontWeight: FontWeight.bold),
                  ),
                  tilePadding: EdgeInsets.zero,
                  onExpansionChanged: onExpensionchange,
                  controlAffinity: ListTileControlAffinity.trailing,
                  trailing: trailing,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: children,
                    ),
                  ]),
            ]));
  }
}
