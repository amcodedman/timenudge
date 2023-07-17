import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/widgets/tiltles.dart';

class Expensiontile extends StatelessWidget {
  Expensiontile(
      {Key? key,
      this.text1,
      this.text2,
      this.color,
      required this.children,
      this.trailing,
      this.onExpensionchange});
  final String? text1;
  final String? text2;
  final Color? color;
  final Widget? trailing;
  final List<Widget> children;
  final void Function(bool)? onExpensionchange;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppConsts.kBLight,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Titles(
            text1: text1,
            text2: text2,
            color: color,
          ),
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: onExpensionchange,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
