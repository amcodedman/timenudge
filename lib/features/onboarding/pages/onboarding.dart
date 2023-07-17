import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/onboarding/widgets/pageone.dart';
import 'package:timenudge/features/onboarding/widgets/pagetwo.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key? key});

  @override
  State<StatefulWidget> createState() {
    return _Onboarding();
  }
}

class _Onboarding extends State<Onboarding> {
  final PageController pcontroller = PageController();

  @override
  void dispose() {
    pcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: pcontroller,
            children: [PageOne(), PageTwo()],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("object");
                            pcontroller.nextPage(
                                duration: const Duration(milliseconds: 600),
                                curve: Curves.ease);
                          },
                          child: const Icon(
                            Ionicons.chevron_forward_circle,
                            color: AppConsts.klight,
                            size: 25,
                          ),
                        ),
                        const WidthSpacer(value: 5),
                        Reusables(
                            text: "Skip",
                            style:
                                appStyle(16, AppConsts.klight, FontWeight.bold))
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        pcontroller.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease);
                      },
                      child: SmoothPageIndicator(
                        controller: pcontroller,
                        count: 2,
                        effect: const WormEffect(
                            dotColor: AppConsts.kgreylIght,
                            dotHeight: 12,
                            dotWidth: 10),
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
