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
          color: Color.fromARGB(255, 85, 87, 94),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
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
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: children,
                      ),
                    ]),
              ),
            ]));
  }
}
