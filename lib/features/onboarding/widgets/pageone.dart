import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';

class PageOne extends StatelessWidget {
  PageOne({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConsts.kheight,
      width: AppConsts.kwidth,
      color: AppConsts.kBKDark,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: Image.asset(
                "assets/images/timen.png",
                height: 150.h,
                width: 150.w,
              ),
            ),
            const Heightspacer(value: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Reusables(
                    text: "Level Up with TimeNudge",
                    style: appStyle(25, AppConsts.klight, FontWeight.bold)),
                const Heightspacer(value: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Welcome to TimeNudge, the ultimate mobile app designed to revolutionize the way you manage your time.Whether you're a student striving for academic excellence or a busy professional juggling multiple responsibilities, Time Nudge is here to empower you with a personalized and efficient scheduling experience. Available on all platforms, Time Nudge brings together the best features and functionalities to streamline your daily routine..",
                    style:
                        appStyle(15, AppConsts.kgreylIght, FontWeight.normal),
                  ),
                )
              ],
            )
          ]),
    );
  }
}
