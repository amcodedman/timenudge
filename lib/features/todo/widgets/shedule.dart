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
    String formattedDate = DateFormat('EEEE MMMM d, h:mm a').format(date);
    return formattedDate;
  }

  bool sheduleWithin12Hours(String duetimei) {
    DateTime dueTime = DateTime.parse(duetimei);
    DateTime dueTimePlus12Hours = dueTime.add(const Duration(hours: 12));
    DateTime now = DateTime.now();
    print(now);
    print(dueTime);

    return now.isAfter(dueTime) && now.isBefore(dueTimePlus12Hours);
  }

  String mydelete = "Personal table";
  String myinstitutedelete = "Institution";
  String mysheduledelete = "One time schedule";

  bool isTimeWithin12Hours(String duetime) {
    DateTime dueTime = DateFormat('hh:mm a').parse(duetime);
    DateTime dueTimePlus12Hours = dueTime.add(const Duration(hours: 12));
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm a').format(now);
    DateTime datenow = DateFormat('hh:mm a').parse(formattedTime);

    return datenow.isAfter(dueTime) && datenow.isBefore(dueTimePlus12Hours);
  }

  String timeconvertor(dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('hh:mm a ').format(date);
    return formattedDate;
  }

  Icon getTimeStatus(String time) {
    DateFormat format = DateFormat('hh:mm a');
    DateTime dateTime1 = format.parse(time);

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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppConsts.kBKDark,
         title: Text(
          'Shedules Daskboard'),

     
      ),
      bottomNavigationBar: Container(
          alignment: Alignment.bottomRight,
          height: 70.w,
          width: 50,
          padding: const EdgeInsets.all(30),
          child: GestureDetector(
            child: const Icon(
              FontAwesome.plus,
              color: Colors.white,
              size: 13,
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return AddShedule();
              }));
            },
          )),
      body: SafeArea(
          child: ref.watch(sheduleProvider)
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      child: ListView(children: [
                    Column(children: [
                      Padding(
                        padding: EdgeInsets.all(10),
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
                                      20, AppConsts.klight, FontWeight.bold),
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
                                      style: appStyle(20, AppConsts.klight,
                                          FontWeight.bold),
                                    ),
                                    Text(
                                      (ref
                                              .watch(sheduleProvider.notifier)
                                              .getdate("department"))
                                          .toUpperCase(),
                                      style: appStyle(
                                          15,
                                          Color.fromARGB(255, 236, 233, 233),
                                          FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  "My Shedules",
                                  style: appStyle(
                                      20, AppConsts.klight, FontWeight.bold),
                                )
                              ],
                            )),
                      ),
                      const Heightspacer(value: 20),
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
                                    padding: const EdgeInsets.only(left: 10),
                                    child: GestureDetector(
                                      child: Reusables(
                                        text: "Everyday Task",
                                        style: appStyle(13, AppConsts.klight,
                                            FontWeight.bold),
                                      ),
                                      onTap: () {},
                                    )),
                              )),
                              Tab(
                                  child: Container(
                                      width: AppConsts.kwidth * 0.5,
                                      padding: const EdgeInsets.only(left: 20),
                                      child: GestureDetector(
                                        child: Reusables(
                                          text: "Institution Timeline",
                                          style: appStyle(13, AppConsts.klight,
                                              FontWeight.bold),
                                        ),
                                        onTap: () {},
                                      ))),
                              Tab(
                                  child: Container(
                                      width: AppConsts.kwidth * 0.5,
                                      padding: const EdgeInsets.only(left: 20),
                                      child: GestureDetector(
                                        child: Reusables(
                                          text: "One Time task",
                                          style: appStyle(13, AppConsts.klight,
                                              FontWeight.bold),
                                        ),
                                        onTap: () {},
                                      ))),
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
                                unselectedLabelColor: AppConsts.klight,
                                labelStyle: appStyle(
                                    24, AppConsts.kBluelight, FontWeight.w700),
                                tabs: [
                                  Tab(
                                      child: Container(
                                    width: AppConsts.kwidth * 0.5,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Reusables(
                                      text: "Monday",
                                      style: appStyle(13, AppConsts.klight,
                                          FontWeight.bold),
                                    ),
                                  )),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Tuesday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Wednesday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Thursday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Friday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: AppConsts.kwidth * 0.5,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Reusables(
                                              text: "Saturday",
                                              style: appStyle(
                                                  13,
                                                  AppConsts.klight,
                                                  FontWeight.bold),
                                            ),
                                          ))),
                                  Tab(
                                    child: Container(
                                        width: AppConsts.kwidth * 0.5,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Reusables(
                                          text: "Sunday",
                                          style: appStyle(13, AppConsts.klight,
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
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Monday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Tuesday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Wednesday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Thursday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Friday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                      child: Container(
                                          width: AppConsts.kwidth * 0.5,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Reusables(
                                            text: "Saturday",
                                            style: appStyle(
                                                13,
                                                AppConsts.klight,
                                                FontWeight.bold),
                                          ))),
                                  Tab(
                                    child: Container(
                                        width: AppConsts.kwidth * 0.5,
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Reusables(
                                          text: "Sunday",
                                          style: appStyle(13, AppConsts.klight,
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
                                      13, AppConsts.klight, FontWeight.bold),
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
                                  ),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .tuedaytask(),
                                      mydelete),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .wednesdaytask(),
                                      mydelete),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .thurdaytask(),
                                      mydelete),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .fridaytask(),
                                      mydelete),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .saturdaytask(),
                                      mydelete),
                                  TaskDisplay(
                                      ref
                                          .watch(sheduleProvider.notifier)
                                          .sundaytask(),
                                      mydelete),
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
                                    myinstitutedelete),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .ituedaytask(),
                                    myinstitutedelete),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .iwednesdaytask(),
                                    myinstitutedelete),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .ithurdaytask(),
                                    myinstitutedelete),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .ifridaytask(),
                                    myinstitutedelete),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .isaturdaytask(),
                                    myinstitutedelete),
                                TaskDisplay(
                                    ref
                                        .watch(sheduleProvider.notifier)
                                        .isundaytask(),
                                    myinstitutedelete),
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
                                  decoration: const BoxDecoration(
                                      color: AppConsts.klight,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            child: Column(
                                          children: [
                                            Reusables(
                                                text: (dateconvertor(ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .OnetimeShedule![index]
                                                    ["from"])),
                                                style: appStyle(
                                                    12,
                                                    const Color.fromARGB(
                                                        255, 144, 34, 235),
                                                    FontWeight.bold)),
                                            getTimeStatusOnetime(
                                                (ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .OnetimeShedule![index]
                                                    ["from"])),
                                            const Heightspacer(value: 5),
                                            Reusables(
                                                text: (dateconvertor(ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .OnetimeShedule![index]
                                                    ["to"])),
                                                style: appStyle(
                                                    12,
                                                    const Color.fromARGB(
                                                        255, 144, 34, 235),
                                                    FontWeight.bold)),
                                          ],
                                        )),
                                        const WidthSpacer(value: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Reusables(
                                                text: ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .OnetimeShedule![index]
                                                    ["title"],
                                                style: appStyle(
                                                    10,
                                                    const Color.fromARGB(
                                                        255, 144, 34, 235),
                                                    FontWeight.bold)),
                                            const WidthSpacer(value: 20),
                                            GestureDetector(
                                                child: const Icon(
                                                    FontAwesome.pencil_square_o,
                                                    color: Color.fromARGB(
                                                        255, 20, 1, 63),
                                                    size: 15),
                                                onTap: () {}),
                                            const WidthSpacer(value: 20),
                                            GestureDetector(
                                                child: const Icon(
                                                    FontAwesome.remove,
                                                    color: Color.fromARGB(
                                                        255, 20, 1, 63),
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
                                            statusOnetime(ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .OnetimeShedule![index]
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
                                                                color: AppConsts
                                                                    .kBKDark,
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
                                                            child: const Icon(FontAwesome.thumbs_up,
                                                                color: Color.fromARGB(
                                                                    255, 227, 245, 70),
                                                                size: 18)))
                                                : const Icon(Icons.timer,
                                                    color: Colors.blue,
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

  Widget TaskDisplay(List<dynamic> tasks, String deletetype) {
    return Container(
        height: AppConsts.kheight * 0.7,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: AppConsts.klight,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          child: Column(
                        children: [
                          Reusables(
                              text: (tasks[index]["from"]),
                              style: appStyle(
                                  12,
                                  const Color.fromARGB(255, 144, 34, 235),
                                  FontWeight.bold)),
                          getTimeStatus((tasks[index]["from"])),
                          const Heightspacer(value: 5),
                          Reusables(
                              text: (tasks[index]["to"]),
                              style: appStyle(
                                  12,
                                  const Color.fromARGB(255, 144, 34, 235),
                                  FontWeight.bold)),
                        ],
                      )),
                      const WidthSpacer(value: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Reusables(
                              text: tasks[index]["title"],
                              style: appStyle(
                                  10,
                                  const Color.fromARGB(255, 144, 34, 235),
                                  FontWeight.bold)),
                          const WidthSpacer(value: 20),
                          GestureDetector(
                              child: const Icon(FontAwesome.pencil_square_o,
                                  color: Color.fromARGB(255, 20, 1, 63),
                                  size: 15),
                              onTap: () {}),
                          const WidthSpacer(value: 20),
                          GestureDetector(
                              child: const Icon(FontAwesome.remove,
                                  color: Color.fromARGB(255, 20, 1, 63),
                                  size: 15),
                              onTap: () {
                                showOutputDialog(
                                    context,
                                    "Click on delete button to remove Shedule",
                                    tasks[index]["_id"],
                                    deletetype);
                              }),
                          const WidthSpacer(value: 15),
                          isTimeWithin12Hours(tasks[index]["from"])
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
                                          },
                                          child: const Icon(
                                              FontAwesome.thumbs_up,
                                              color: AppConsts.kBKDark,
                                              size: 15))
                                      : GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(sheduleProvider.notifier)
                                                .compeleteUndo(
                                                    deletetype,
                                                    tasks[index]["_id"],
                                                    tasks[index]["count"]);
                                          },
                                          child: const Icon(
                                              FontAwesome.thumbs_up,
                                              color: Color.fromARGB(
                                                  255, 227, 245, 70),
                                              size: 18)))
                              : const Icon(Icons.timer,
                                  color: Colors.blue, size: 15),
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
