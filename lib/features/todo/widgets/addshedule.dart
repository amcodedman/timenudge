import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/customerextfield.dart';
import 'package:timenudge/common/widgets/dateshort.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/auth/controllers/users.dart';
import 'package:timenudge/pages/notificateHelper.dart';

import '../controllers/shedule.dart';
import '../pages/homepage.dart';

class AddShedule extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddShedule();
  }
}

class _AddShedule extends ConsumerState<AddShedule> {
  void showOutputDialog(
    BuildContext context,
    String task,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Reusables(
              text: "Prompt: Select different time",
              style: appStyle(11, AppConsts.kred, FontWeight.bold)),
          content: Text(
            "Sorry, but sheduling Task may not be feasible since within this time range as '$task' lecture will  be onging by then.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  timeOfshedule = TimeOfDay.now();
                });

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
                      children: [Text('ok')])),
            ),
          ],
        );
      },
    );
  }

  late SharedPreferences prefs;
  Future<void> loadDetails() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs?.getString("firstname").toString());
    setState(() {
      notice = prefs.getInt("notice");
    });
  }

  late int? notice = 0;
  late bool success = false;
  late String sheduletitle;
  TimeOfDay timeOfshedule = TimeOfDay.now();
  TimeOfDay endshedule = TimeOfDay.now();
  var boxtext = "Personal table";
  void onChange(String selectedValue) {
    setState(() {
      boxtext = selectedValue;
    });
  }

  var boxtextD = "Monday";
  void onChangeD(String selectedValue) {
    setState(() {
      boxtextD = selectedValue;
    });
  }

  String getboxtext() {
    return boxtext;
  }

  int randonid() {
    var rnd = new Random();
    var next = rnd.nextDouble() * 1000000;
    return next.toInt();
  }

  DateTime? selectedDateTime;
  DateTime? selectedDateTimeTo;

  void _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _selectDateTimeTo() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTimeTo = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  late NotificationHelper notifyhelper;
  late NotificationHelper notifycontroller;

  @override
  void initState() {
    notifyhelper = NotificationHelper(ref: ref);
    Future.delayed(const Duration(seconds: 2), () {
      notifycontroller = NotificationHelper(ref: ref);
    });
    notifyhelper.initializeNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    success = ref.watch(sheduleProvider.notifier).loading;

    List<String> Lists = const [
      "Personal table",
      "Institution",
      "One time schedule"
    ];
    List<DropdownMenuItem<String>> items = Lists.map((String value) {
      return DropdownMenuItem<String>(
        child: Text(value),
        value: value,
      );
    }).toList();

    List<String> listsD = const [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    List<DropdownMenuItem<String>> itemsD = listsD.map((String value) {
      return DropdownMenuItem<String>(
        child: Text(value),
        value: value,
      );
    }).toList();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Color.fromARGB(255, 88, 123, 228),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext _contex) {
                    return HomePage();
                  }));
                },
                icon: const Icon(
                  FontAwesome.chevron_left,
                  size: 12,
                )),
          ),
          backgroundColor: AppConsts.klight,
          body: Container(
              child: ListView(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: AppConsts.kwidth.w,
                height: AppConsts.kheight * 0.3,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 88, 123, 228),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // Offset
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Heightspacer(value: 20),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Reusables(
                              text: "Add new Shedule",
                              style: appStyle(
                                  15, AppConsts.klight, FontWeight.bold))),
                      Row(children: [
                        const WidthSpacer(value: 20),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: AppConsts.kBluelight,
                                items: items,
                                style: Theme.of(context).textTheme.bodySmall,
                                onChanged: (String? selectedValue) {
                                  setState(() {
                                    onChange(selectedValue!);
                                  });
                                },
                                value: boxtext,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 82, 89, 150)
                                      .withOpacity(0.5), // Shadow color
                                  spreadRadius: 5, // Spread radius
                                  blurRadius: 7, // Blur radius
                                  offset: Offset(0, 3), // Offset
                                ),
                              ],
                              color: Color.fromARGB(255, 226, 226, 226),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        const WidthSpacer(value: 20),
                        boxtext == "One time schedule"
                            ? Text(" ")
                            : Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      dropdownColor: AppConsts.kBluelight,
                                      items: itemsD,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
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
                                        color: Color.fromARGB(255, 82, 89, 150)
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 5, // Spread radius
                                        blurRadius: 7, // Blur radius
                                        offset: Offset(0, 3), // Offset
                                      ),
                                    ],
                                    color: const Color.fromARGB(
                                        255, 226, 226, 226),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                              )
                      ])
                    ]),
              ),
              const Heightspacer(value: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomTextField(
                    hint: "Shedule title",
                    secure: false,
                    preficon: const Icon(FontAwesome.bolt),
                    onChange: (value) {
                      setState(() {
                        sheduletitle = value;
                      });
                    }),
              ),
              const Heightspacer(value: 10),
              boxtext == "One time schedule"
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Reusables(
                                  text: "From :",
                                  style: appStyle(20, AppConsts.kBluelight,
                                      FontWeight.bold)),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppConsts.klight,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 5, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: const Offset(0, 3), // Offset
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  onPressed: _selectDateTime,
                                  child: Row(children: [
                                    const Icon(FontAwesome.clock_o),
                                    const WidthSpacer(value: 10),
                                    const Text("Choose",
                                        style: TextStyle(fontSize: 12)),
                                    const WidthSpacer(value: 20),
                                    Reusables(
                                        text: selectedDateTime != null
                                            ? DateShort(
                                                    dateString: selectedDateTime
                                                        .toString())
                                                .dateSh()
                                            : "",
                                        style: appStyle(
                                            12,
                                            Color.fromARGB(255, 26, 22, 44),
                                            FontWeight.bold))
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Reusables(
                                  text: "To:",
                                  style: appStyle(20, AppConsts.kBluelight,
                                      FontWeight.bold)),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppConsts.klight,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 5, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: const Offset(0, 3), // Offset
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  onPressed: _selectDateTimeTo,
                                  child: Row(children: [
                                    const Icon(FontAwesome.clock_o),
                                    const WidthSpacer(value: 10),
                                    const Text("Choose",
                                        style: TextStyle(fontSize: 12)),
                                    const WidthSpacer(value: 20),
                                    Reusables(
                                        text: selectedDateTimeTo != null
                                            ? DateShort(
                                                    dateString:
                                                        selectedDateTimeTo
                                                            .toString())
                                                .dateSh()
                                            : "",
                                        style: appStyle(
                                            12,
                                            Color.fromARGB(255, 36, 30, 64),
                                            FontWeight.bold))
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Reusables(
                                  text: "From :",
                                  style: appStyle(20, AppConsts.kBluelight,
                                      FontWeight.bold)),
                              const WidthSpacer(value: 20),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppConsts.klight,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 5, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: const Offset(0, 3), // Offset
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  onPressed: _showDatePickerfrom,
                                  child: const Row(children: [
                                    Icon(FontAwesome.clock_o),
                                    WidthSpacer(value: 10),
                                    Text("Choose time"),
                                  ]),
                                ),
                              ),
                              const WidthSpacer(value: 10),
                              Reusables(
                                  text: timeOfshedule.format(context),
                                  style: appStyle(
                                      17, AppConsts.kGreen, FontWeight.bold)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Reusables(
                                  text: "To:",
                                  style: appStyle(20, AppConsts.kBluelight,
                                      FontWeight.bold)),
                              const WidthSpacer(value: 46),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppConsts.klight,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 5, // Spread radius
                                      blurRadius: 7, // Blur radius
                                      offset: const Offset(0, 3), // Offset
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  onPressed: _showDatePickerto,
                                  child: const Row(children: [
                                    Icon(
                                      Ionicons.time_outline,
                                      color: AppConsts.kred,
                                    ),
                                    WidthSpacer(value: 10),
                                    Text("Choose time"),
                                  ]),
                                ),
                              ),
                              const WidthSpacer(value: 10),
                              Reusables(
                                  text: endshedule.format(context),
                                  style: appStyle(
                                      17, AppConsts.kGreen, FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
              const Heightspacer(value: 90),
              Center(
                  child: !ref.watch(sheduleProvider)
                      ? const CircularProgressIndicator()
                      : Container(
                          child: boxtext == "One time schedule"
                              ? MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      ref
                                          .read(sheduleProvider.notifier)
                                          .setloading();
                                    });

                                    ref
                                        .read(sheduleProvider.notifier)
                                        .addSchedule(
                                            boxtext,
                                            sheduletitle,
                                            boxtextD,
                                            selectedDateTime!.toString(),
                                            selectedDateTimeTo.toString());

                                    notifyhelper.scheduledNotification(
                                        ref.read(sheduleProvider.notifier).dates(
                                            notice!,
                                            selectedDateTime!.toString(),
                                            selectedDateTimeTo.toString())[0],
                                        ref.read(sheduleProvider.notifier).dates(
                                            notice!,
                                            selectedDateTime!.toString(),
                                            selectedDateTimeTo.toString())[1],
                                        ref.read(sheduleProvider.notifier).dates(
                                            notice!,
                                            selectedDateTime!.toString(),
                                            selectedDateTimeTo.toString())[2],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .dates(
                                                notice!,
                                                selectedDateTime!.toString(),
                                                selectedDateTimeTo
                                                    .toString())[3],
                                        randonid(),
                                        "$sheduletitle start at ${selectedDateTime!.toString()}",
                                        selectedDateTime!.toString(),
                                        selectedDateTimeTo.toString(),
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .dates(
                                                notice!,
                                                selectedDateTime!.toString(),
                                                selectedDateTimeTo
                                                    .toString())[4]);

                                    notifyhelper.scheduledNotificationend(
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesend(
                                                selectedDateTime!.toString(),
                                                selectedDateTimeTo
                                                    .toString())[0],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesend(
                                                selectedDateTime!.toString(),
                                                selectedDateTimeTo
                                                    .toString())[1],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesend(
                                                selectedDateTime!.toString(),
                                                selectedDateTimeTo
                                                    .toString())[2],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesend(
                                                selectedDateTime!.toString(),
                                                selectedDateTimeTo
                                                    .toString())[3],
                                        randonid(),
                                        sheduletitle +
                                            " shedule just ended, You can take  a break. See u later,Enjoy!!",
                                        selectedDateTime!.toString(),
                                        selectedDateTimeTo.toString(),
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesend(
                                                selectedDateTime!.toString(),
                                                selectedDateTimeTo.toString())[4]);
                                  },
                                  child: Container(
                                      height: 40,
                                      width: AppConsts.kwidth * 0.4.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppConsts.klight,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Shadow color
                                              spreadRadius: 5, // Spread radius
                                              blurRadius: 7, // Blur radius
                                              offset:
                                                  const Offset(0, 3), // Offset
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          )),
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              const Icon(FontAwesome.folder_o),
                                              const WidthSpacer(value: 10),
                                              Reusables(
                                                  text: "Add Shedule",
                                                  style: appStyle(
                                                      13,
                                                      AppConsts.kBluelight,
                                                      FontWeight.bold))
                                            ],
                                          ))))
                              : MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      ref
                                          .read(sheduleProvider.notifier)
                                          .setloading();
                                    });

                                    ref
                                        .read(sheduleProvider.notifier)
                                        .addSchedule(
                                            boxtext,
                                            sheduletitle,
                                            boxtextD,
                                            timeOfshedule.format(context),
                                            endshedule.format(context));

                                    notifyhelper.scheduledNotificationRepeat(
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeat(
                                                notice!,
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[0],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeat(
                                                notice!,
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[1],
                                        randonid(),
                                        "$sheduletitle start at ${timeOfshedule.format(context)}",
                                        timeOfshedule.format(context),
                                        endshedule.format(context),
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeat(
                                                notice!,
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[2],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeat(
                                                notice!,
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[3]);

                                    notifyhelper.scheduledNotificationRepeatend(
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeatend(
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[0],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeatend(
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[1],
                                        randonid(),
                                        sheduletitle +
                                            " shedule just ended, You can take  a break. See u later,Enjoy!!",
                                        timeOfshedule.format(context),
                                        endshedule.format(context),
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeatend(
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[2],
                                        ref
                                            .read(sheduleProvider.notifier)
                                            .datesrepeatend(
                                                timeOfshedule.format(context),
                                                endshedule.format(context),
                                                boxtextD)[3]);
                                  },
                                  child: Container(
                                      height: 40,
                                      width: AppConsts.kwidth * 0.4.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppConsts.klight,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Shadow color
                                              spreadRadius: 5, // Spread radius
                                              blurRadius: 7, // Blur radius
                                              offset:
                                                  const Offset(0, 3), // Offset
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(30),
                                          )),
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Row(
                                            children: [
                                              const Icon(FontAwesome.folder_o),
                                              const WidthSpacer(value: 10),
                                              Reusables(
                                                  text: "Save",
                                                  style: appStyle(
                                                      18,
                                                      AppConsts.kBluelight,
                                                      FontWeight.bold)),
                                            ],
                                          )))))),
              const Heightspacer(value: 10),
              Center(
                child: Text(
                  ref.watch(sheduleProvider.notifier).addmessage,
                  style: appStyle(10, AppConsts.kGreen, FontWeight.bold),
                ),
              )
            ],
          ))),
    );
  }

  void _showDatePickerfrom() {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.blue, // Change the primary color

              colorScheme: const ColorScheme.dark(
                brightness: Brightness.dark,
                primary: Color.fromARGB(
                    255, 43, 148, 234), // Change the primary color
                onPrimary:
                    Colors.white, // Change the text color on the primary color
                surface: Color.fromARGB(
                    255, 42, 42, 42), // Change the background color
                onSurface: Color.fromARGB(255, 253, 253,
                    253), // Change the text color on the background color
              ),
              dialogBackgroundColor: const Color.fromARGB(
                  255, 0, 0, 0), // Change the dialog background color
            ),
            child: child!,
          );
        }).then((value) => setState(() {
          timeOfshedule = value!;
        }));
  }

  void _showDatePickerto() {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.blue, // Change the primary color

              colorScheme: const ColorScheme.dark(
                brightness: Brightness.dark,
                primary: Color.fromARGB(
                    255, 43, 148, 234), // Change the primary color
                onPrimary:
                    Colors.white, // Change the text color on the primary color
                surface: Color.fromARGB(
                    255, 61, 46, 46), // Change the background color
                onSurface: Color.fromARGB(255, 253, 253,
                    253), // Change the text color on the background color
              ),
              dialogBackgroundColor: const Color.fromARGB(
                  255, 0, 0, 0), // Change the dialog background color
            ),
            child: child!,
          );
        }).then((value) => setState(() {
          endshedule = value!;
          if (ref.read(sheduleProvider.notifier).weekdayschecker(
              timeOfshedule.format(context), boxtextD)["check"]) {
            showOutputDialog(
                context,
                ref.read(sheduleProvider.notifier).weekdayschecker(
                    timeOfshedule.format(context), boxtextD)["task"]);
          }
        }));
  }

  void _DatePickerto() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
  }

  void _DatePickerfrom() {}
}
