import 'package:flutter/material.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/dateshort.dart';
import 'package:timenudge/common/widgets/Expansiontile.dart';
import 'package:timenudge/common/widgets/customerextfield.dart';

import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/todo/controllers/shedule.dart';
import 'package:timenudge/features/todo/widgets/todotail.dart';

import 'package:timenudge/features/todo/widgets/activities.dart';
import 'package:timenudge/features/todo/widgets/forum.dart';
import 'package:timenudge/features/todo/widgets/homep.dart';

import 'package:timenudge/features/todo/widgets/Account.dart';

import '../../../pages/notificateHelper.dart';
import '../controllers/expensions.dart';

class LandPage extends ConsumerStatefulWidget {
  const LandPage({Key? key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LandPage();
  }
}

class _LandPage extends ConsumerState<LandPage> with TickerProviderStateMixin {
  late String inputtext;

  String datas() {
    return inputtext;
  }

  String searchtext = "";

  String gettoday() {
    DateTime nowTime = DateTime.now();
    String dayName = DateFormat('EEEE').format(nowTime);
    return dayName;
  }

  String dateSh(String dateString) {
    String dat = "";
    if (dateString.isNotEmpty) {
      DateTime date = DateTime.parse(dateString);

      dat = DateFormat('E MMMM d hh:mm a ').format(date);
    }

    return dat;
  }

  String dateSho(String dateString) {
    String dat = "";
    if (dateString.isNotEmpty) {
      DateTime date = DateTime.parse(dateString);
      dat = DateFormat('hh:mm a ').format(date);
    }

    return dat;
  }

  List<dynamic> gettasks(List<dynamic> tasks) {
    return tasks;
  }

  late final TabController tabController =
      TabController(length: 2, vsync: this);
  late bool switchv = false;
  late bool checker = false;
  bool getStatus(Map<String, dynamic> mydata) {
    bool statuss = false;

    if (mydata["count"] == 0) {
      statuss = false;
    }

    if (mydata["count"] == 1) {
      statuss = true;
    }
    print("countttt ${mydata["count"]}");

    return statuss;
  }

  late NotificationHelper notifyhelper;
  late NotificationHelper notifycontroller;
  @override
  void initState() {
    // TODO: implement initState
    notifyhelper = NotificationHelper(ref: ref);
    Future.delayed(const Duration(seconds: 2), () {
      notifycontroller = NotificationHelper(ref: ref);
    });
    notifyhelper.initializeNotification();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.read(sheduleProvider.notifier).result();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ref.watch(sheduleProvider)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      const Heightspacer(value: 20),
                      const Heightspacer(value: 10),
                      CustomTextField(
                        hint: "Search",
                        preficon: const Icon(
                          Ionicons.search,
                          color: AppConsts.kBKDark,
                        ),
                        onChange: (value) {
                          print(searchtext);
                          setState(() {
                            searchtext = value;
                          });
                        },
                        secure: false,
                        autocor: true,
                        suffix: const Icon(
                          FontAwesome.sliders,
                          color: AppConsts.kBKDark,
                        ),
                      ),
                      const Heightspacer(value: 10),
                      Row(
                        children: [
                          const Icon(
                            FontAwesome.tasks,
                            size: 20,
                            color: AppConsts.kBKDark,
                          ),
                          const WidthSpacer(value: 10),
                          Reusables(
                              text: "Todays task",
                              style: appStyle(
                                  18, AppConsts.kBKDark, FontWeight.bold))
                        ],
                      ),
                      const Heightspacer(value: 10),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 85, 87, 94),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                            unselectedLabelColor:
                                Color.fromARGB(255, 115, 156, 211),
                            labelStyle: appStyle(
                                24, AppConsts.kBluelight, FontWeight.w700),
                            tabs: [
                              Tab(
                                  child: SizedBox(
                                width: AppConsts.kwidth * 0.7,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Reusables(
                                      text: "Pending",
                                      style: appStyle(16, AppConsts.kBKDark,
                                          FontWeight.bold),
                                    )),
                              )),
                              Tab(
                                  child: Container(
                                width: AppConsts.kwidth * 0.7,
                                padding: const EdgeInsets.only(left: 20),
                                child: Reusables(
                                  text: "Completed",
                                  style: appStyle(
                                      16, AppConsts.kBKDark, FontWeight.bold),
                                ),
                              ))
                            ]),
                      ),
                      const Heightspacer(value: 10),
                      searchtext != ""
                          ? SizedBox(
                              height: AppConsts.kheight * 0.3,
                              width: AppConsts.kwidth,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                    color: Color.fromARGB(255, 85, 87, 94),
                                    height: AppConsts.kheight * 0.3,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: ref
                                            .watch(sheduleProvider.notifier)
                                            .getshedulefilter(searchtext)
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Todotile(
                                                  text: "One Time shedule",
                                                  text1: ref
                                                          .watch(sheduleProvider
                                                              .notifier)
                                                          .getshedulefilter(searchtext)[index]
                                                      ["title"],
                                                  start: dateSh(ref
                                                          .watch(sheduleProvider
                                                              .notifier)
                                                          .getshedulefilter(
                                                              searchtext)[index]
                                                      ["from"]),
                                                  end: dateSh(ref
                                                      .watch(sheduleProvider.notifier)
                                                      .getshedulefilter(searchtext)[index]["to"]),
                                                  switcher: Transform.scale(
                                                    scale:
                                                        0.7, // Adjust the scale factor as needed
                                                    child: Switch(
                                                      value: getStatus(ref
                                                              .watch(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .getshedulefilter(
                                                                  searchtext)[
                                                          index]),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          ref
                                                              .read(
                                                                  sheduleProvider
                                                                      .notifier)
                                                              .CompeleteSchedule(
                                                                  "One time schedule",
                                                                  ref
                                                                      .watch(sheduleProvider
                                                                          .notifier)
                                                                      .getshedulefilter(
                                                                          searchtext)[index]["_id"],
                                                                  1);
                                                        });
                                                      },
                                                    ),
                                                  )));
                                        })),
                              ))
                          : SizedBox(
                              height: AppConsts.kheight * 0.3,
                              width: AppConsts.kwidth,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      Container(
                                          color:
                                              Color.fromARGB(255, 85, 87, 94),
                                          height: AppConsts.kheight * 0.3,
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: ref
                                                  .watch(
                                                      sheduleProvider.notifier)
                                                  .getshedulepending()
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Todotile(
                                                        text:
                                                            "One Time shedule",
                                                        text1: ref
                                                                .watch(sheduleProvider
                                                                    .notifier)
                                                                .getshedulepending()[index]
                                                            ["title"],
                                                        start: dateSh(ref
                                                                .watch(
                                                                    sheduleProvider
                                                                        .notifier)
                                                                .getshedulepending()[index]
                                                            ["from"]),
                                                        end: dateSh(ref
                                                            .watch(
                                                                sheduleProvider
                                                                    .notifier)
                                                            .getshedulepending()[index]["to"]),
                                                        switcher: Transform.scale(
                                                          scale:
                                                              0.7, // Adjust the scale factor as needed
                                                          child: Switch(
                                                            value: getStatus(ref
                                                                .watch(
                                                                    sheduleProvider
                                                                        .notifier)
                                                                .getshedulepending()[index]),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                ref
                                                                    .read(sheduleProvider
                                                                        .notifier)
                                                                    .CompeleteSchedule(
                                                                        "One time schedule",
                                                                        ref.watch(sheduleProvider.notifier).getshedulepending()[index]
                                                                            [
                                                                            "_id"],
                                                                        1);
                                                              });
                                                            },
                                                          ),
                                                        )));
                                              })),
                                      Container(
                                          color:
                                              Color.fromARGB(255, 85, 87, 94),
                                          height: AppConsts.kheight * 0.3,
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: ref
                                                  .watch(
                                                      sheduleProvider.notifier)
                                                  .getshedulecompleted()
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ref
                                                        .watch(sheduleProvider
                                                            .notifier)
                                                        .getshedulecompleted()
                                                        .isNotEmpty
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Todotile(
                                                            text:
                                                                "One Time shedule",
                                                            text1: ref.watch(sheduleProvider.notifier).getshedulecompleted()[
                                                                index]["title"],
                                                            start: ref
                                                                    .watch(sheduleProvider
                                                                        .notifier)
                                                                    .getshedulecompleted()
                                                                    .isNotEmpty
                                                                ? DateShort(dateString: ref.watch(sheduleProvider.notifier).getshedulecompleted()[index]["from"])
                                                                    .dateSh()
                                                                : "",
                                                            end: DateShort(
                                                                    dateString: ref
                                                                        .watch(sheduleProvider.notifier)
                                                                        .getshedulecompleted()[index]["to"])
                                                                .dateSh(),
                                                            switcher: Transform.scale(
                                                              scale:
                                                                  0.7, // Adjust the scale factor as needed
                                                              child: Switch(
                                                                value: getStatus(ref
                                                                    .watch(sheduleProvider
                                                                        .notifier)
                                                                    .getshedulecompleted()[index]),
                                                                onChanged:
                                                                    (value) {
                                                                  print(getStatus(ref
                                                                      .watch(sheduleProvider
                                                                          .notifier)
                                                                      .getshedulecompleted()[index]));
                                                                  setState(() {
                                                                    switchv =
                                                                        !switchv;
                                                                  });
                                                                },
                                                              ),
                                                            )))
                                                    : Text("");
                                              })),
                                    ]),
                              ),
                            ),
                      const Heightspacer(value: 10),
                      Expensiontile(
                        text1: "Tomorrow tasks",
                        text2: "tomorrow tasks are how here",
                        onExpensionchange: (bool epend) {
                          ref
                              .read(pageExpensionProvider.notifier)
                              .setStart(!epend);
                        },
                        trailing: ref.watch(pageExpensionProvider)
                            ? const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(AntDesign.circledown,
                                    color: AppConsts.kBluelight),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  AntDesign.closecircleo,
                                  color: AppConsts.klight,
                                ),
                              ),
                        children: [
                          gettasks(ref
                                          .watch(sheduleProvider.notifier)
                                          .getshedulepending())
                                      .length >
                                  0
                              ? Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Todotile(
                                      text: "One Time shedule",
                                      text1: ref
                                              .watch(sheduleProvider.notifier)
                                              .getshedulependingtomorrow()[0]
                                          ["title"],
                                      start: dateSh(ref
                                              .watch(sheduleProvider.notifier)
                                              .getshedulependingtomorrow()[0]
                                          ["from"]),
                                      end: dateSh(ref
                                              .watch(sheduleProvider.notifier)
                                              .getshedulependingtomorrow()[0]
                                          ["to"]),
                                      switcher: SizedBox(
                                        width: 65,
                                        child: Text(""),
                                      )),
                                )
                              : Text(""),
                          gettasks(ref.watch(sheduleProvider.notifier).getshedulepending())
                                      .length >
                                  1
                              ? Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Todotile(
                                      text: "One Time shedule",
                                      text1: ref
                                          .watch(sheduleProvider.notifier)
                                          .getshedulepending()[1]["title"],
                                      start: dateSh(ref
                                          .watch(sheduleProvider.notifier)
                                          .getshedulepending()[1]["from"]),
                                      end: dateSh(ref
                                          .watch(sheduleProvider.notifier)
                                          .getshedulepending()[1]["to"]),
                                      switcher: const SizedBox(
                                          width: 65, child: Text(""))))
                              : Text(""),
                          gettasks(ref.watch(sheduleProvider.notifier).getshedulepending())
                                      .length >
                                  2
                              ? Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Todotile(
                                      text: "One Time shedule",
                                      text1: ref
                                          .watch(sheduleProvider.notifier)
                                          .getshedulepending()[2]["title"],
                                      start: dateSh(ref
                                          .watch(sheduleProvider.notifier)
                                          .getshedulepending()[2]["from"]),
                                      end: dateSh(ref
                                          .watch(sheduleProvider.notifier)
                                          .getshedulepending()[2]["to"]),
                                      switcher: const SizedBox(
                                          width: 65, child: Text(""))))
                              : const Text(""),
                        ],
                      ),
                      const Heightspacer(value: 10),
                      Expensiontile(
                        text1: "Daily Task today",
                        text2: "Normal routine",
                        onExpensionchange: (bool epend) {
                          ref
                              .read(pageExpensionSzeroProvider.notifier)
                              .setStart(!epend);
                        },
                        trailing: ref.watch(pageExpensionSzeroProvider)
                            ? const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(AntDesign.circledown,
                                    color: AppConsts.kBluelight),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  AntDesign.closecircleo,
                                  color: AppConsts.klight,
                                ),
                              ),
                        children: [
                          gettasks(ref.watch(sheduleProvider.notifier).weekdays(gettoday()))
                                      .length >
                                  0
                              ? Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Todotile(
                                      text: "Weekday",
                                      text1: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[0]["title"],
                                      start: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[0]["from"],
                                      end: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[0]["to"],
                                      switcher: const SizedBox(
                                          width: 65, child: Text(""))))
                              : const Text(""),
                          gettasks(ref.watch(sheduleProvider.notifier).weekdays(gettoday()))
                                      .length >
                                  2
                              ? Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Todotile(
                                      text: "Weekday",
                                      text1: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[1]["title"],
                                      start: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[1]["from"],
                                      end: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[1]["to"],
                                      switcher: const SizedBox(
                                          width: 65, child: Text(""))))
                              : const Text(""),
                          gettasks(ref.watch(sheduleProvider.notifier).weekdays(gettoday()))
                                      .length >
                                  3
                              ? Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Todotile(
                                      text: "Weekday",
                                      text1: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[2]["title"],
                                      start: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[2]["from"],
                                      end: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[2]["to"],
                                      switcher: const SizedBox(
                                          width: 65, child: Text(""))))
                              : const Text(""),
                          gettasks(ref.watch(sheduleProvider.notifier).weekdays(gettoday()))
                                      .length >
                                  4
                              ? Padding(
                                  padding: EdgeInsets.all(7),
                                  child: Todotile(
                                      text: "Weekday",
                                      text1: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[3]["title"],
                                      start: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[3]["from"],
                                      end: ref
                                          .watch(sheduleProvider.notifier)
                                          .weekdays(gettoday())[3]["to"],
                                      switcher: const SizedBox(
                                          width: 65, child: Text(""))))
                              : const Text(""),
                        ],
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
