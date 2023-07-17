import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';

class Todotile extends StatelessWidget {
  final Color? color;
  final String? text;
  final String? text1;
  final String? start;
  final String? end;
  final Widget? editwidget;
  final Widget? switcher;
  final void Function()? deletef;
  const Todotile(
      {Key? key,
      this.color,
      this.text,
      this.text1,
      this.start,
      this.end,
      this.editwidget,
      this.deletef,
      this.switcher});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConsts.kwidth,
            decoration: BoxDecoration(
              color: AppConsts.kgreylIght,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 5,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppConsts.kGreen,
                    ),
                  ),
                  const WidthSpacer(value: 15),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: AppConsts.kwidth * 0.57,
                      child: Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Reusables(
                              text: text ?? "Todo list",
                              style: appStyle(
                                  16, AppConsts.klight, FontWeight.bold)),
                        ),
                        const Heightspacer(value: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Reusables(
                              text: text1 ?? "Descriptions on todo",
                              style: appStyle(
                                  12, AppConsts.klight, FontWeight.bold)),
                        ),
                        const Heightspacer(value: 10),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                    width: AppConsts.kwidth * 0.3,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        color: AppConsts.kBKDark,
                                        border: Border.all(
                                            width: 0.3,
                                            color: AppConsts.kBKDark),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                        child: Reusables(
                                            text: "$start | $end",
                                            style: appStyle(
                                                12,
                                                AppConsts.klight,
                                                FontWeight.bold)))),
                                const WidthSpacer(value: 10),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: editwidget,
                                    ),
                                    const WidthSpacer(value: 15),
                                    GestureDetector(
                                      onTap: deletef,
                                      child: const Icon(
                                          MaterialCommunityIcons.delete),
                                    )
                                  ],
                                )
                              ],
                            ))
                      ]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 0.h),
                    child: switcher,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
