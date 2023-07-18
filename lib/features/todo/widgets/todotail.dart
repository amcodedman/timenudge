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
              color: Color.fromARGB(255, 233, 248, 248),
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
                  const WidthSpacer(value: 10),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Reusables(
                                  text: text ?? "one time shedule",
                                  style: appStyle(
                                      16, AppConsts.kGreyBk, FontWeight.bold)),
                            ),
                            const Heightspacer(value: 15),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Reusables(
                                  text: text1 ?? "Descriptions on todo",
                                  style: appStyle(
                                      12, AppConsts.kGreyBk, FontWeight.bold)),
                            ),
                            const Heightspacer(value: 10),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 25.h,
                                        width: AppConsts.kwidth * 0.55.w,
                                        decoration: BoxDecoration(
                                            color: AppConsts.kBKDark,
                                            border: Border.all(
                                                width: 0.8,
                                                color: AppConsts.kBKDark),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Center(
                                            child: Reusables(
                                                text: "$start | $end",
                                                style: appStyle(
                                                    11,
                                                    AppConsts.klight,
                                                    FontWeight.bold)))),
                                    const WidthSpacer(value: 5),
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
