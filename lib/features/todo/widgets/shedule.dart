import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/todo/widgets/addshedule.dart';
import 'package:timenudge/features/todo/widgets/todotail.dart';

import '../controllers/shedule.dart';
import 'package:intl/intl.dart';

class Shedule extends ConsumerStatefulWidget {
  Shedule({Key? key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _Shedule();
  }
}

class _Shedule extends ConsumerState<Shedule> with TickerProviderStateMixin {
  void showOutputDialog(
      BuildContext context, String output, String id, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Reusables(
              text: "Delete Shedule",
              style: appStyle(18, AppConsts.kred, FontWeight.bold)),
          content: Text(
            output,
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(sheduleProvider.notifier).DeleteSchedule(type, id);

                Navigator.of(context).pop();
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: AppConsts.kred,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text('Delete')])),
            ),
          ],
        );
      },
    );
  }

  String dateconvertor(dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('E MMMM d h:mm a').format(date);
    return formattedDate;
  }

  bool sheduleWithin12Hours(String duetimei) {
    DateTime dueTime = DateTime.parse(duetimei);
    DateTime dueTimePlus12Hours = dueTime.add(const Duration(hours: 12));
    DateTime now = DateTime.now();
  ;

    return now.isAfter(dueTime) && now.isBefore(dueTimePlus12Hours);
  }

  String mydelete = "Personal table";
  String myinstitutedelete = "Institution";
  String mysheduledelete = "One time schedule";
  String timeconvertor(dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('hh:mm a ').format(date);
    return formattedDate;
  }

  bool isTimeWithin12Hours(String duetime, String day) {
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE').format(now);
    bool checker = false;
    if (dayName == day) {
      DateTime dueTime = DateFormat('hh:mm a').parse(duetime);
      DateTime dueTimePlus12Hours = dueTime.add(const Duration(hours: 12));
      String formattedTime = DateFormat('hh:mm a').format(now);
      DateTime datenow = DateFormat('hh:mm a').parse(formattedTime);
      checker =
          datenow.isAfter(dueTime) && datenow.isBefore(dueTimePlus12Hours);
    }
    return checker;
  }

  Icon getTimeStatus(String duetime, String day) {
    Icon checkicon = const Icon(
      FontAwesome.check_circle,
      size: 12,
      color: Color.fromARGB(255, 147, 198, 4),
    );
    Icon timeicon = const Icon(FontAwesome.clock_o,
        size: 12, color: Color.fromARGB(255, 239, 239, 239));
    Icon? iconstatus = timeicon;
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE').format(now);
    bool checker = false;
    if (dayName == day) {
      DateTime dueTime = DateFormat('hh:mm a').parse(duetime);
      DateTime dueTimePlus12Hours = dueTime.add(const Duration(hours: 12));
      String formattedTime = DateFormat('hh:mm a').format(now);
      DateTime datenow = DateFormat('hh:mm a').parse(formattedTime);
      checker =
          datenow.isAfter(dueTime) && datenow.isBefore(dueTimePlus12Hours);
    
      if (checker) {
        iconstatus != checkicon;
      } else {
        iconstatus != timeicon;
      }
    }

    return iconstatus!;
  }

  bool getDue(String time) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime dateTime1 = format.parse(time);

    DateTime now = DateTime.now();
    bool timei = false;

    if (dateTime1.isBefore(now)) {
      timei = true;
    } else if (dateTime1.isAfter(now)) {
      timei = false;
    } else {
      timei = true;
    }
    return timei;
  }

  bool checkComfirm(int number) {
    bool result = false;
    if (number > 0) {
      result = true;
    }
    return result;
  }

  late final TabController tabController =
      TabController(length: 3, vsync: this);
  late final TabController personalController =
      TabController(length: 7, vsync: this);
  late final TabController instituteController =
      TabController(length: 7, vsync: this);

  var thumpColor = Color.fromARGB(255, 20, 1, 63);
  @override
  Widget build(BuildContext context) {
    ref.read(sheduleProvider.notifier).result();
    ref.read(sheduleProvider.notifier).dayfromtimetable();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline,
                color: Color.fromARGB(255, 181, 194, 0)),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return AddShedule();
              }));
            },
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: ref.watch(sheduleProvider)
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      child: ListView(children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                            height: 40,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                Text(
                                  (ref
                                          .watch(sheduleProvider.notifier)
                                          .datafromtimetable("name"))
                                      .toUpperCase(),
                                  style: appStyle(
                                      12,
                                      Color.fromARGB(255, 85, 87, 94),
                                      FontWeight.bold),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (ref
                                              .watch(sheduleProvider.notifier)
                                              .getdate("company"))
                                          .toUpperCase(),
                                      style: appStyle(
                                          12,
                                          Color.fromARGB(255, 85, 87, 94),
                                          FontWeight.bold),
                                    ),
                                    Text(
                                      (ref
                                              .watch(sheduleProvider.notifier)
                                              .getdate("department"))
                                          .toUpperCase(),
                                      style: appStyle(
                                          9,
                                          Color.fromARGB(255, 85, 87, 94),
                                          FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  "My Shedules",
                                  style: appStyle(
                                      13,
                                      Color.fromARGB(255, 85, 87, 94),
                                      FontWeight.bold),
                                )
                              ],
                            )),
                      ),
                      const Heightspacer(value: 30),
                      SizedBox(
                        child: TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: const BoxDecoration(
                              color: Color.fromARGB(255, 139, 144, 148),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            controller: tabController,
                            labelPadding: EdgeInsets.zero,
                            labelColor: AppConsts.kBluelight,
                            isScrollable: false,
                            unselectedLabelColor: AppConsts.klight,
                            labelStyle: appStyle(
                                24, AppConsts.kBluelight, FontWeight.w700),
                            tabs: [
                              Tab(
                                  child: SizedBox(
                                width: AppConsts.kwidth * 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Reusables(
                                    text: "Everyday Task",
                                    style: appStyle(
                                        12, AppConsts.kBKDark, FontWeight.bold),
                                  ),
                                ),
                              )),
                              Tab(
                                  child: Container(
                                width: AppConsts.kwidth * 0.5,
                                padding: const EdgeInsets.only(left: 5),
                                child: Reusables(
                                  text: "Institution Table",
                                  style: appStyle(
                                      12, AppConsts.kBKDark, FontWeight.bold),
                                ),
                              )),
                              Tab(
                                  child: Container(
                                width: AppConsts.kwidth * 0.5,
                                padding: const EdgeInsets.only(left: 5),
                                child: Reusables(
                                  text: "One Time task",
                                  style: appStyle(
                                      12, AppConsts.kBKDark, FontWeight.bold),
                                ),
                              )),
                            ]),
                        height: 30,
                        width: AppConsts.kwidth.w,
                      ),
                      const Heightspacer(value: 10),
                      SizedBox(
                        height: 30,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child:
                              TabBarView(controller: tabController, children: [
                            TabBar(
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: const BoxDecoration(
                                  color: Color.fromARGB(255, 139, 144, 148),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                controller: personalController,
                                labelPadding: EdgeInsets.zero,
                                labelColor: AppConsts.kBluelight,
                                isScrollable: false,
                                unselectedLabelColor: AppConsts.kBKDark,
                                labelStyle: appStyle(
                                    20, AppConsts.kBluelight, FontWeight.w700),
                                tabs: [
                                  Tab(
                                      child: Container(
                                    width: AppConsts.kwidth * 0.5,
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Reusables(
                                      text: "Monday",
                                      style: appStyle(9, AppConsts.kBKDark,
                                          FontWeight.bold),
                                    ),
                                  )),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Tuesday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Wednesday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Thursday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Friday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                    width: AppConsts.kwidth * 0.5,
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Reusables(
                                      text: "Saturday",
                                      style: appStyle(9, AppConsts.kBKDark,
                                          FontWeight.bold),
                                    ),
                                  )),
                                  Tab(
                                    child: Container(
                                        width: AppConsts.kwidth * 0.5,
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Reusables(
                                          text: "Sunday",
                                          style: appStyle(9, AppConsts.kBKDark,
                                              FontWeight.bold),
                                        )),
                                  )
                                ]),
                            TabBar(
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: const BoxDecoration(
                                  color: Color.fromARGB(255, 139, 144, 148),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                controller: instituteController,
                                labelPadding: EdgeInsets.zero,
                                labelColor: AppConsts.kBluelight,
                                isScrollable: false,
                                unselectedLabelColor: AppConsts.klight,
                                labelStyle: appStyle(
                                    24, AppConsts.kBluelight, FontWeight.w700),
                                tabs: [
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Monday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Tuesday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Wednesday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Thursday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Friday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Reusables(
                                            text: "Saturday",
                                            style: appStyle(
                                                9,
                                                AppConsts.kBKDark,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                    child: Container(
                                        width: AppConsts.kwidth * 0.5,
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Reusables(
                                          text: "Sunday",
                                          style: appStyle(9, AppConsts.kBKDark,
                                              FontWeight.bold),
                                        )),
                                  )
                                ]),
                            Container(
                                width: AppConsts.kwidth.w,
                                height: AppConsts.kheight,
                                alignment: Alignment.center,
                                child: Text(
                                  "My one time shedules",
                                  style: appStyle(
                                      13,
                                      Color.fromARGB(255, 9, 47, 97),
                                      FontWeight.bold),
                                )),
                          ]),
                        ),
                      ),
                      const Heightspacer(value: 20),
                      SizedBox(
                        width: AppConsts.kwidth.w,
                        height: AppConsts.kheight * 0.8,
                        child: TabBarView(controller: tabController, children: [
                          SizedBox(
                            child: TabBarView(
                                controller: personalController,
                                children: [
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .mondaytask(),
                                      mydelete,
                                      "Monday"),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .tuedaytask(),
                                      mydelete,
                                      "Tuesday"),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .wednesdaytask(),
                                      mydelete,
                                      "Wednesday"),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .thurdaytask(),
                                      mydelete,
                                      "Thursday"),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .fridaytask(),
                                      mydelete,
                                      "Friday"),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .saturdaytask(),
                                      mydelete,
                                      "Saturday"),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .sundaytask(),
                                      mydelete,
                                      "Sunday"),
                                ]),
                          ),
                          SizedBox(
                              child: TabBarView(
                                  controller: instituteController,
                                  children: [
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .imondaytask(),
                                    myinstitutedelete,
                                    "Monday"),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .ituedaytask(),
                                    myinstitutedelete,
                                    "Tuesday"),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .iwednesdaytask(),
                                    myinstitutedelete,
                                    "Wednesday"),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .ithurdaytask(),
                                    myinstitutedelete,
                                    "Thursday"),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .ifridaytask(),
                                    myinstitutedelete,
                                    "Friday"),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .isaturdaytask(),
                                    myinstitutedelete,
                                    "Saturday"),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .isundaytask(),
                                    myinstitutedelete,
                                    "Sunday"),
                              ])),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: ref
                                  .watch(sheduleProvider.notifier)
                                  .OnetimeShedule!
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                                  255, 206, 206, 206)
                                              .withOpacity(0.3), // Shadow color
                                          spreadRadius: 5, // Spread radius
                                          blurRadius: 5, // Blur radius
                                          offset: Offset(0, 2), // Offset
                                        ),
                                      ],
                                      color: AppConsts.kBKDark,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Reusables(
                                                text: ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .OnetimeShedule![index]
                                                    ["title"],
                                                style: appStyle(
                                                    8,
                                                    AppConsts.klight,
                                                    FontWeight.bold)),
                                            Row(
                                              children: [
                                                Reusables(
                                                    text: (dateconvertor(ref
                                                            .watch(
                                                                sheduleProvider
                                                                    .notifier)
                                                            .OnetimeShedule![
                                                        index]["from"])),
                                                    style: appStyle(
                                                        8,
                                                        AppConsts.klight,
                                                        FontWeight.bold)),
                                                Reusables(
                                                    text: " To ",
                                                    style: appStyle(
                                                        9,
                                                        Color.fromARGB(
                                                            255, 77, 157, 242),
                                                        FontWeight.bold)),
                                                Reusables(
                                                    text: (dateconvertor(ref
                                                            .watch(
                                                                sheduleProvider
                                                                    .notifier)
                                                            .OnetimeShedule![
                                                        index]["to"])),
                                                    style: appStyle(
                                                        8,
                                                        AppConsts.klight,
                                                        FontWeight.bold)),
                                              ],
                                            ),
                                            getTimeStatusOnetime(
                                                (ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .OnetimeShedule![index]
                                                    ["from"])),
                                            const Heightspacer(value: 5),
                                          ],
                                        )),
                                        const WidthSpacer(value: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const WidthSpacer(value: 20),
                                            GestureDetector(
                                                child: const Icon(Icons.delete,
                                                    color: AppConsts.klight,
                                                    size: 15),
                                                onTap: () {
                                                  showOutputDialog(
                                                      context,
                                                      "Click on delete button to remove Shedule",
                                                      ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .OnetimeShedule![
                                                          index]["_id"],
                                                      mysheduledelete);
                                                }),
                                            const WidthSpacer(value: 15),
                                            statusOnetime(
                                                    ref.watch(sheduleProvider.notifier).OnetimeShedule![index]
                                                        ["from"])
                                                ? Center(
                                                    child: ref.watch(sheduleProvider.notifier).OnetimeShedule![index]
                                                                ["count"] ==
                                                            0
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              ref.read(sheduleProvider.notifier).CompeleteSchedule(
                                                                  mysheduledelete,
                                                                  ref.watch(sheduleProvider.notifier).OnetimeShedule![
                                                                          index]
                                                                      ["_id"],
                                                                  ref.watch(sheduleProvider.notifier).OnetimeShedule![
                                                                          index]
                                                                      [
                                                                      "count"]);
                                                            },
                                                            child: const Icon(FontAwesome.thumbs_up,
                                                                color: Color.fromARGB(
                                                                    255, 223, 226, 236),
                                                                size: 15))
                                                        : GestureDetector(
                                                            onTap: () {
                                                              ref.read(sheduleProvider.notifier).compeleteUndo(
                                                                  mysheduledelete,
                                                                  ref.watch(sheduleProvider.notifier).OnetimeShedule![
                                                                          index]
                                                                      ["_id"],
                                                                  ref.watch(sheduleProvider.notifier).OnetimeShedule![
                                                                          index]
                                                                      [
                                                                      "count"]);
                                                            },
                                                            child: const Icon(
                                                                FontAwesome
                                                                    .thumbs_up,
                                                                color: Color.fromARGB(
                                                                    255, 227, 245, 70),
                                                                size: 18)))
                                                : const Icon(Icons.timer,
                                                    color: Color.fromARGB(255, 247, 247, 247),
                                                    size: 15),
                                            const WidthSpacer(value: 15),
                                          ],
                                        )
                                      ]),
                                );
                              })
                        ]),
                      ),
                      const Heightspacer(value: 10),
                    ])
                  ])))
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Widget TaskDisplay(List<dynamic> tasks, String deletetype, String day) {
    return Container(
        height: AppConsts.kheight * 0.7,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 10, top: 10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppConsts.kBKDark,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 206, 206, 206)
                          .withOpacity(0.3), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: const Offset(0, 2), // Offset
                    ),
                  ],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tasks[index]["title"],
                            style: appStyle(9, Color.fromARGB(255, 215, 219, 0),
                                FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Reusables(
                                  text: (tasks[index]["from"]),
                                  style: appStyle(
                                      8, AppConsts.klight, FontWeight.bold)),
                              const WidthSpacer(value: 10),
                              Reusables(
                                  text: " To ",
                                  style: appStyle(
                                      8, AppConsts.klight, FontWeight.bold)),
                              Reusables(
                                  text: (tasks[index]["to"]),
                                  style: appStyle(
                                      8, AppConsts.klight, FontWeight.bold)),
                            ],
                          ),
                          getTimeStatus(tasks[index]["from"], day),
                          const Heightspacer(value: 5),
                        ],
                      )),
                      const WidthSpacer(value: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const WidthSpacer(value: 30),
                          GestureDetector(
                              child: const Icon(Icons.delete,
                                  color: AppConsts.klight, size: 20),
                              onTap: () {
                                showOutputDialog(
                                    context,
                                    "Click on delete button to remove Shedule",
                                    tasks[index]["_id"],
                                    deletetype);
                              }),
                          const WidthSpacer(value: 15),
                          isTimeWithin12Hours(tasks[index]["from"], day)
                              ? Center(
                                  child: tasks[index]["complete"] == 0
                                      ? GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(sheduleProvider.notifier)
                                                .CompeleteSchedule(
                                                    deletetype,
                                                    tasks[index]["_id"],
                                                    tasks[index]["count"]);

                                            ref
                                                .read(sheduleProvider.notifier)
                                                .result();
                                          },
                                          child: const Icon(
                                              FontAwesome.thumbs_up,
                                              color: Color.fromARGB(
                                                  255, 194, 196, 199),
                                              size: 15))
                                      : GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(sheduleProvider.notifier)
                                                .compeleteUndo(
                                                    deletetype,
                                                    tasks[index]["_id"],
                                                    tasks[index]["count"]);
                                            ref
                                                .read(sheduleProvider.notifier)
                                                .result();
                                          },
                                          child: const Icon(
                                              FontAwesome.thumbs_up,
                                              color: Color.fromARGB(
                                                  255, 227, 245, 70),
                                              size: 18)))
                              : const Icon(Icons.timer,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 15),
                          const WidthSpacer(value: 15),
                        ],
                      )
                    ]),
              );
            }));
  }

  bool getDueOnetime(String time) {
    DateTime dateTime1 = DateTime.parse(time);

    DateTime now = DateTime.now();
    bool timei = false;

    if (dateTime1.isBefore(now)) {
      timei = true;
    } else if (dateTime1.isAfter(now)) {
      timei = false;
    } else {
      timei = true;
    }
    return timei;
  }

  bool statusOnetime(String time) {
    DateTime dateTime1 = DateTime.parse(time);

    DateTime now = DateTime.now();
    return dateTime1.isBefore(now);
  }

  Icon getTimeStatusOnetime(String time) {
    DateTime dateTime1 = DateTime.parse(time);

    DateTime now = DateTime.now();
    Icon timeicon = const Icon(
      FontAwesome.check_circle,
      size: 12,
      color: Color.fromARGB(255, 1, 91, 114),
    );
    if (dateTime1.isBefore(now)) {
      timeicon = const Icon(
        FontAwesome.check_circle,
        size: 12,
        color: Color.fromARGB(255, 1, 91, 114),
      );
    } else if (dateTime1.isAfter(now)) {
      timeicon = const Icon(
        FontAwesome.clock_o,
        size: 12,
        color: Color.fromARGB(255, 35, 14, 110),
      );
    } else {
      timeicon = const Icon(
        FontAwesome.bolt,
        size: 12,
        color: Color.fromARGB(255, 35, 14, 73),
      );
    }
    return timeicon;
  }
}
