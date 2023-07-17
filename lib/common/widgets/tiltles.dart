import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';

class Titles extends StatelessWidget {
  Titles({Key? key, this.text1, this.text2, this.color});
  final String? text1;
  final String? text2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: AppConsts.kwidth,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Consumer(builder: (context, ref, child) {
                return Container(
                  height: 80,
                  width: 5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppConsts.kGreen),
                );
              }),
              const WidthSpacer(value: 15),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Reusables(
                        text: text1!,
                        style: appStyle(16, AppConsts.klight, FontWeight.bold)),
                    const Heightspacer(value: 15),
                    Reusables(
                        text: text2!,
                        style: appStyle(14, AppConsts.klight, FontWeight.bold))
                  ],
                ),
              )
            ])));
  }
}
