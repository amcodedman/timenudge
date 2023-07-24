import 'package:flutter/src/widgets/framework.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:intl/intl.dart';
import 'package:timenudge/features/todo/pages/homepage.dart';

class ViewNotification extends ConsumerStatefulWidget {
  ViewNotification({super.key, this.payload});
  String? payload;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ViewNotification();
  }
}

class _ViewNotification extends ConsumerState<ViewNotification> {
  CountDownController _controller = CountDownController();
  String dateconvertor(dateString, int type) {
    String formattedDate = "";
    if (type == 0) {
      DateTime date = DateTime.parse(dateString);
      formattedDate = DateFormat('E MMMM d h:mm a').format(date);
    }
    if (type == 1) {
      formattedDate = dateString;
    }

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                    width: AppConsts.kwidth * 0.9,
                    height: AppConsts.kheight * 0.8,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Reusables(
                                  text: "Reminder",
                                  style: appStyle(
                                      30, AppConsts.kBKDark, FontWeight.bold)),
                              const Heightspacer(value: 10),
                              Container(
                                  width: AppConsts.kwidth * 0.9,
                                  height: 28,
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 94, 94, 94),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Heightspacer(value: 20),
                                      Reusables(
                                          text:
                                              "From ${dateconvertor(widget.payload!.split('|')[1], int.parse(widget.payload!.split('|')[4]))} ",
                                          style: appStyle(
                                              10,
                                              const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              FontWeight.bold)),
                                      Reusables(
                                          text:
                                              "To ${dateconvertor(widget.payload!.split('|')[2], int.parse(widget.payload!.split('|')[4]))}",
                                          style: appStyle(
                                              10,
                                              const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              FontWeight.bold)),
                                    ],
                                  )),
                              const Heightspacer(value: 20),
                              Reusables(
                                  text: "Event on going nows",
                                  style: appStyle(
                                      15, AppConsts.kBKDark, FontWeight.bold)),
                              Reusables(
                                  text: "${widget.payload!.split('|')[0]}",
                                  style: appStyle(
                                      15, AppConsts.kBKDark, FontWeight.bold)),
                              CircularCountDownTimer(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  duration:
                                      int.parse(widget.payload!.split('|')[3]),
                                  fillColor: Colors.amber,
                                  ringColor: Colors.white,
                                  controller: _controller,
                                  backgroundColor: Colors.white54,
                                  strokeWidth: 10.0,
                                  strokeCap: StrokeCap.round,
                                  isTimerTextShown: true,
                                  isReverse: true,
                                  onComplete: () {}),
                            ],
                          ),
                        ),
                        Positioned(
                            left: -20.w,
                            top: -30,
                            child: Image.asset("assets/images/bell.png",
                                width: 70, height: 70)),
                        Positioned(
                            right: -20.w,
                            top: -26,
                            child: IconButton(
                              icon: const Icon(
                                Icons.cancel_rounded,
                                color: Color.fromARGB(255, 177, 160, 10),
                                size: 25,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const HomePage())));
                              },
                            )),
                        const Heightspacer(value: 10),
                      ],
                    )),
              ))),
    );
  }
}
