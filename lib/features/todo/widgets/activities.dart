import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/auth/controllers/users.dart';
import 'package:timenudge/features/onboarding/pages/onboarding.dart';
import 'package:timenudge/features/todo/controllers/shedule.dart';
import 'package:timenudge/main.dart';

class Activities extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Activities();
  }
}

class _Activities extends ConsumerState<Activities>
    with TickerProviderStateMixin {
  late SharedPreferences prefs;
  late AnimationController _animationController;
  late AnimationController _animationControllertodo;
  late AnimationController _animationControllerweek;
  late Animation<double> _animation;
  late Animation<double> _animationtodo;
  late Animation<double> _animationweekly;
  late double? shedulerat = 0;
  bool loaded = false;
  late double myprogress = 0.01;
  late double mytodoprogress = 0.001;
  late double myweeklyprogress = 0.001;
  String mypercentage(int numerat, int denominat) {
    int numerator = numerat;
    int denominator = denominat;
    double percentage = (numerator / denominator) * 100;

    String formattedPercentage = '${percentage.toStringAsFixed(2)}%';
    return formattedPercentage;
  }

  var boxtextD = "January";
  var textD = "Monday";
  var displayevent = "";
  void onChangeD(String selectedValue) {
    setState(() {
      boxtextD = selectedValue;
      displayevent = boxtextD;
    });
  }

  void onChangeDay(String selectedValue) {
    setState(() {
      textD = selectedValue;
      displayevent = textD;
    });
  }

  Future<void> loadDetails() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      shedulerat = prefs.getDouble("todo_success")!;
      loaded = true;

      String? firstn = prefs.getString("firstname").toString();
      String? lastn = prefs.getString("lastname").toString();
      myname = firstn! + " " + lastn!;
      user_email = prefs.getString("email").toString();
      user_name = prefs.getString("username").toString();
      institution = prefs.getString("company").toString();
      department = prefs.getString("department").toString();
    });
  }

  Future<void> signout() async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString("email", "");
  }

  @override
  void initState() {
    // TODO: implement initState
    loadDetails();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3), // Set the duration of the animation
      vsync: this,
    );
    _animationController.repeat(reverse: false);
    _animationController.forward().whenComplete(() {
      _animationController
          .dispose(); // Dispose the animation controller after animation completion
    });

    _animationControllertodo = AnimationController(
      duration: const Duration(seconds: 4), // Set the duration of the animation
      vsync: this,
    );
    _animationControllertodo.repeat(reverse: false);
    _animationControllertodo.forward().whenComplete(() {
      _animationControllertodo
          .dispose(); // Dispose the animation controller after animation completion
    });

    _animationControllerweek = AnimationController(
      duration: const Duration(seconds: 2), // Set the duration of the animation
      vsync: this,
    );
    _animationControllerweek.repeat(reverse: false);
    _animationControllerweek.forward().whenComplete(() {
      _animationControllerweek
          .dispose(); // Dispose the animation controller after animation completion
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllertodo.dispose();
    _animationControllerweek.dispose();
    super.dispose();
  }

  late String? myname = "";
  late String? user_name = "";
  late String? user_email = "";
  late String? institution = "";
  late String? department = "";
  late final TabController tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dataall =
        ref.read(sheduleProvider.notifier).toTalToDocompleted();
    Map<String, dynamic> tododata =
        ref.read(sheduleProvider.notifier).toDocompleted();
    Map<String, dynamic> weekdata =
        ref.read(sheduleProvider.notifier).totalweeklytoDocompleted();

    if (tododata["rate"].isNaN) {
    } else {
      mytodoprogress = tododata["rate"];
    }

    if (weekdata["rate"].isNaN) {
    } else {
      myweeklyprogress = weekdata["rate"];
    }
    if (dataall["rate"].isNaN) {
    } else {
      myprogress = dataall["rate"];
    }
    _animationtodo = Tween(begin: 0.0, end: mytodoprogress)
        .animate(_animationControllertodo);
    _animation =
        Tween(begin: 0.0, end: myprogress).animate(_animationController);

    _animationweekly = Tween(begin: 0.0, end: myweeklyprogress)
        .animate(_animationControllerweek);
    ref.read(sheduleProvider.notifier).result();
    ref.read(sheduleProvider.notifier).dayfromtimetable();

    List<String> listsD = const [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    List<DropdownMenuItem<String>> itemsD = listsD.map((String value) {
      return DropdownMenuItem<String>(
        child: Text(value),
        value: value,
      );
    }).toList();

    List<String> dayslist = const [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    List<DropdownMenuItem<String>> mydays = dayslist.map((String value) {
      return DropdownMenuItem<String>(
        child: Text(value),
        value: value,
      );
    }).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'My Dashboard',
          style: appStyle(17, AppConsts.kGreyBk, FontWeight.bold),
        ),
        bottom: TabBar(
          //  indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
            color: Color.fromARGB(255, 220, 223, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          controller: tabController,
          labelPadding: EdgeInsets.zero,
          labelColor: Colors.blue, // Updated to a default blue color
          unselectedLabelColor: Colors.grey, // Updated to a default grey color
          isScrollable: false,
          tabs: [
            Tab(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Container(
                  alignment: Alignment.center,
                  width: AppConsts.kwidth * 0.3.w,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(77, 147, 240, 1),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 231, 230, 230)
                              .withOpacity(0.5), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: const Offset(0, 3), // Offset
                        ),
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesome.list,
                          color: Colors.white,
                          size: 40,
                        ),
                        Reusables(
                            text: " Tasks Summary",
                            style: appStyle(
                                13,
                                const Color.fromARGB(255, 241, 239, 239),
                                FontWeight.bold)),
                      ]),
                ),
              ),
            ),
            Tab(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Container(
                  alignment: Alignment.center,
                  width: AppConsts.kwidth * 0.3.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(242, 125, 116, 1),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 231, 230, 230)
                              .withOpacity(0.5), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: const Offset(0, 3), // Offset
                        ),
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesome.check_square,
                          color: Colors.white,
                          size: 40,
                        ),
                        Reusables(
                            text: "Todo Task",
                            style: appStyle(
                                13,
                                const Color.fromARGB(255, 241, 239, 239),
                                FontWeight.bold)),
                      ]),
                ),
              ),
            ),
            Tab(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Container(
                  alignment: Alignment.center,
                  width: AppConsts.kwidth * 0.3.w,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: const Color.fromRGBO(240, 105, 237, 1),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 231, 230, 230)
                              .withOpacity(0.5), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: const Offset(0, 3), // Offset
                        ),
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesome.calendar,
                          color: Colors.white,
                          size: 40,
                        ),
                        Reusables(
                            text: "Weekly Task",
                            style: appStyle(
                                13,
                                const Color.fromARGB(255, 241, 239, 239),
                                FontWeight.bold)),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: ref.watch(sheduleProvider)
              ? ListView(children: <Widget>[
                  SizedBox(
                    height: AppConsts.kheight * 0.7,
                    width: AppConsts.kwidth.w,
                    child: TabBarView(controller: tabController, children: [
                      Builder(builder: (BuildContext context) {
                        return ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Task Progress",
                                style: appStyle(
                                    20,
                                    const Color.fromRGBO(60, 56, 117, 1),
                                    FontWeight.bold),
                              ),
                            ),
                            const Heightspacer(value: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: AppConsts.kwidth * 0.4.w,
                                    height: AppConsts.kheight * 0.15.h,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(217, 234, 252, 1)),
                                    child: ListTile(
                                      // Leading widget (typically an icon)

                                      title: Text(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .toTalToDocompleted()["total"]
                                            .toString(),
                                        style: appStyle(
                                            25,
                                            const Color.fromRGBO(
                                                143, 19, 168, 1),
                                            FontWeight.bold),
                                      ), // Title text
                                      subtitle: Text(
                                        'Total Task',
                                        style: appStyle(
                                            14,
                                            Color.fromRGBO(106, 62, 115, 1),
                                            FontWeight.bold),
                                      ), // Subtitle text
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: AppConsts.kwidth * 0.4.w,
                                    height: AppConsts.kheight * 0.15.h,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(217, 234, 252, 1)),
                                    child: ListTile(
                                      // Leading widget (typically an icon)

                                      title: Text(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .toTalToDocompleted()["success"]
                                            .toString(),
                                        style: appStyle(
                                            25,
                                            Color.fromRGBO(143, 19, 168, 1),
                                            FontWeight.bold),
                                      ), // Title text
                                      subtitle: Text(
                                        'Completed Task',
                                        style: appStyle(
                                            14,
                                            Color.fromRGBO(106, 62, 115, 1),
                                            FontWeight.bold),
                                      ), // Subtitle text
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Everyday Task",
                                        style: appStyle(
                                            20,
                                            const Color.fromRGBO(
                                                60, 56, 117, 1),
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        width: AppConsts.kwidth * 0.9.w,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromRGBO(
                                                244, 245, 247, 1)),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width:
                                                      AppConsts.kwidth * 0.7.w,
                                                  height: 5,
                                                  child: AnimatedBuilder(
                                                    animation:
                                                        _animationController,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return LinearProgressIndicator(
                                                        value: _animation
                                                            .value, // Explicitly cast the animation value to double
                                                        backgroundColor:
                                                            Colors.grey,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.blue),
                                                      );
                                                    },
                                                  )),
                                              Container(
                                                  child: Text(mypercentage(
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .toTalToDocompleted()[
                                                          "success"]!,
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .toTalToDocompleted()[
                                                          "total"]!))),
                                            ])),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Todo Task",
                                        style: appStyle(
                                            20,
                                            const Color.fromRGBO(
                                                60, 56, 117, 1),
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        width: AppConsts.kwidth * 0.9.w,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromRGBO(
                                                244, 245, 247, 1)),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width:
                                                      AppConsts.kwidth * 0.7.w,
                                                  height: 5,
                                                  child: AnimatedBuilder(
                                                    animation:
                                                        _animationControllertodo,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return LinearProgressIndicator(
                                                        value: _animationtodo
                                                            .value, // Explicitly cast the animation value to double
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                70, 117, 172),
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Color.fromARGB(
                                                                    255,
                                                                    68,
                                                                    6,
                                                                    60)),
                                                      );
                                                    },
                                                  )),
                                              Container(
                                                  child: Text(mypercentage(
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .toDocompleted()[
                                                          "success"]!,
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .toDocompleted()[
                                                          "total"]!))),
                                            ])),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Weekly Tasks",
                                        style: appStyle(
                                            20,
                                            const Color.fromRGBO(
                                                60, 56, 117, 1),
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        width: AppConsts.kwidth * 0.9.w,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromRGBO(
                                                244, 245, 247, 1)),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width:
                                                      AppConsts.kwidth * 0.7.w,
                                                  height: 5,
                                                  child: AnimatedBuilder(
                                                    animation:
                                                        _animationControllerweek,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return LinearProgressIndicator(
                                                        value: _animationweekly
                                                            .value, // Explicitly cast the animation value to double
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                32,
                                                                25,
                                                                25),
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Color.fromARGB(
                                                                    255,
                                                                    175,
                                                                    187,
                                                                    13)),
                                                      );
                                                    },
                                                  )),
                                              Container(
                                                  child: Text(mypercentage(
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .totalweeklytoDocompleted()[
                                                          "success"]!,
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .totalweeklytoDocompleted()[
                                                          "total"]!))),
                                            ])),
                                  ]),
                            )
                          ],
                        );
                      }),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "My Shedules Progress",
                                style: appStyle(
                                    20,
                                    const Color.fromRGBO(60, 56, 117, 1),
                                    FontWeight.bold),
                              ),
                            ),
                            const Heightspacer(value: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: AppConsts.kwidth * 0.4.w,
                                    height: AppConsts.kheight * 0.15.h,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(217, 234, 252, 1)),
                                    child: ListTile(
                                      // Leading widget (typically an icon)

                                      title: Text(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .toDocompleted()["total"]
                                            .toString(),
                                        style: appStyle(
                                            25,
                                            const Color.fromRGBO(
                                                143, 19, 168, 1),
                                            FontWeight.bold),
                                      ), // Title text
                                      subtitle: Text(
                                        'Total Shedules',
                                        style: appStyle(
                                            14,
                                            Color.fromRGBO(106, 62, 115, 1),
                                            FontWeight.bold),
                                      ), // Subtitle text
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: AppConsts.kwidth * 0.4.w,
                                    height: AppConsts.kheight * 0.15.h,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(217, 234, 252, 1)),
                                    child: ListTile(
                                      // Leading widget (typically an icon)

                                      title: Text(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .toDocompleted()["success"]
                                            .toString(),
                                        style: appStyle(
                                            25,
                                            Color.fromRGBO(143, 19, 168, 1),
                                            FontWeight.bold),
                                      ), // Title text
                                      subtitle: Text(
                                        'Completed Shedules',
                                        style: appStyle(
                                            14,
                                            Color.fromRGBO(106, 62, 115, 1),
                                            FontWeight.bold),
                                      ), // Subtitle text
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "My Progress",
                                        style: appStyle(
                                            20,
                                            const Color.fromRGBO(
                                                60, 56, 117, 1),
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        width: AppConsts.kwidth.w,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromRGBO(
                                                244, 245, 247, 1)),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  width:
                                                      AppConsts.kwidth * 0.7.w,
                                                  height: 5,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: ref
                                                            .watch(
                                                                sheduleProvider
                                                                    .notifier)
                                                            .toDocompleted()[
                                                        "rate"], // Explicitly cast the animation value to double
                                                    backgroundColor:
                                                        Colors.grey,

                                                    valueColor:
                                                        const AlwaysStoppedAnimation<
                                                            Color>(Colors.blue),
                                                  )),
                                              Container(
                                                  child: Text(mypercentage(
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .toDocompleted()[
                                                          "success"]!,
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .toDocompleted()[
                                                          "total"]!))),
                                            ])),
                                    const Heightspacer(value: 15),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            dropdownColor: Color.fromARGB(
                                                255, 213, 231, 231),
                                            items: itemsD,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            onChanged: (String? selectedValue) {
                                              setState(() {
                                                onChangeD(selectedValue!);
                                              });
                                            },
                                            value: boxtextD,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      255, 82, 89, 150)
                                                  .withOpacity(
                                                      0.5), // Shadow color
                                              spreadRadius: 5, // Spread radius
                                              blurRadius: 7, // Blur radius
                                              offset: Offset(0, 3), // Offset
                                            ),
                                          ],
                                          color: const Color.fromARGB(
                                              255, 226, 226, 226),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    showProgressIndicator(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .toDocompletedmonth(boxtextD),
                                        boxtextD,
                                        boxtextD)
                                  ]),
                            )
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "My Weekly Task Progress",
                                style: appStyle(
                                    20,
                                    const Color.fromRGBO(60, 56, 117, 1),
                                    FontWeight.bold),
                              ),
                            ),
                            const Heightspacer(value: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: AppConsts.kwidth * 0.4.w,
                                    height: AppConsts.kheight * 0.15.h,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(217, 234, 252, 1)),
                                    child: ListTile(
                                      // Leading widget (typically an icon)

                                      title: Text(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .totalweeklytoDocompleted()["total"]
                                            .toString(),
                                        style: appStyle(
                                            25,
                                            const Color.fromRGBO(
                                                143, 19, 168, 1),
                                            FontWeight.bold),
                                      ), // Title text
                                      subtitle: Text(
                                        'Total Shedules',
                                        style: appStyle(
                                            14,
                                            Color.fromRGBO(106, 62, 115, 1),
                                            FontWeight.bold),
                                      ), // Subtitle text
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: AppConsts.kwidth * 0.4.w,
                                    height: AppConsts.kheight * 0.15.h,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color:
                                            Color.fromRGBO(217, 234, 252, 1)),
                                    child: ListTile(
                                      // Leading widget (typically an icon)

                                      title: Text(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .totalweeklytoDocompleted()[
                                                "success"]
                                            .toString(),
                                        style: appStyle(
                                            25,
                                            Color.fromRGBO(143, 19, 168, 1),
                                            FontWeight.bold),
                                      ), // Title text
                                      subtitle: Text(
                                        'Completed Shedules',
                                        style: appStyle(
                                            14,
                                            Color.fromRGBO(106, 62, 115, 1),
                                            FontWeight.bold),
                                      ), // Subtitle text
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "My Progress",
                                        style: appStyle(
                                            20,
                                            const Color.fromRGBO(
                                                60, 56, 117, 1),
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        width: AppConsts.kwidth.w,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromRGBO(
                                                244, 245, 247, 1)),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  width:
                                                      AppConsts.kwidth * 0.7.w,
                                                  height: 5,
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: ref
                                                            .watch(
                                                                sheduleProvider
                                                                    .notifier)
                                                            .totalweeklytoDocompleted()[
                                                        "rate"], // Explicitly cast the animation value to double
                                                    backgroundColor:
                                                        Colors.grey,

                                                    valueColor:
                                                        const AlwaysStoppedAnimation<
                                                            Color>(Colors.blue),
                                                  )),
                                              Container(
                                                  child: Text(mypercentage(
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .totalweeklytoDocompleted()[
                                                          "success"]!,
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .totalweeklytoDocompleted()[
                                                          "total"]!))),
                                            ])),
                                    const Heightspacer(value: 15),
                                    Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            dropdownColor: Color.fromARGB(
                                                255, 213, 231, 231),
                                            items: mydays,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            onChanged: (String? selectedValue) {
                                              setState(() {
                                                onChangeDay(selectedValue!);
                                              });
                                            },
                                            value: textD,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      255, 82, 89, 150)
                                                  .withOpacity(
                                                      0.5), // Shadow color
                                              spreadRadius: 5, // Spread radius
                                              blurRadius: 7, // Blur radius
                                              offset: Offset(0, 3), // Offset
                                            ),
                                          ],
                                          color: const Color.fromARGB(
                                              255, 226, 226, 226),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    showProgressIndicator(
                                        ref
                                            .watch(sheduleProvider.notifier)
                                            .toDocompletedweek(textD),
                                        textD,
                                        boxtextD)
                                  ]),
                            )
                          ]),
                    ]),
                  ),
                ])
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Widget showProgressIndicator(
      Map<String, dynamic> task, String header, String month) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heightspacer(value: 20),
        Text(
          header + " Progress",
          style: appStyle(19, AppConsts.kgreylIght, FontWeight.bold),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            width: AppConsts.kwidth.w,
            height: 35,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(244, 245, 247, 1)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: AppConsts.kwidth * 0.7.w,
                      height: 5,
                      child: LinearProgressIndicator(
                        value: task[
                            "rate"], // Explicitly cast the animation value to double
                        backgroundColor: Color.fromARGB(255, 149, 148, 167),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 211, 12, 211)),
                      )),
                  Container(
                      child:
                          Text(mypercentage(task["success"]!, task["total"]!))),
                ])),
        const Heightspacer(value: 10),
        Container(
          alignment: Alignment.bottomLeft,
          width: AppConsts.kwidth * 0.9.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" Total ${task["total"]!}",
                  style: appStyle(14, AppConsts.kgreylIght, FontWeight.bold)),
              Text("  ${task["success"]!} Completed",
                  style: appStyle(
                      15, Color.fromARGB(255, 39, 59, 42), FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }
}
