import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/customebtn.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/features/auth/pages/login.dart';

class PageTwo extends StatelessWidget {
  PageTwo({super.key});
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
            CustomBtn(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                height: 40,
                width: AppConsts.kwidth * 0.7,
                color2: AppConsts.kBLight,
                color3: Color.fromARGB(255, 189, 185, 185),
                text1: "Join Us now")
          ]),
    );
  }
}
