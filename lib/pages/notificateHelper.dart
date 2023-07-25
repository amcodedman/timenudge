import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timenudge/features/todo/pages/homepage.dart';
import 'package:timenudge/pages/view_notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  final WidgetRef ref;

  NotificationHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutternotifyplugin =
      FlutterLocalNotificationsPlugin();

  String? selectnotifypayload;
  final BehaviorSubject<String?> selectnotificationsubject =
      BehaviorSubject<String?>();

  initializeNotification() async {
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      //      onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    final AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("timen");
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: initializationSettingsIOS);
    await flutternotifyplugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    BuildContext context;
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    } else {
      debugPrint('notification done');
    }
    String tod = payload!.split('|')[2];
    if (tod == "end") {
      Get.to(() => HomePage());
    } else {
      Get.to(() => ViewNotification(
            payload: payload,
          ));
    }
  }

  void requestIOSpermissions() {
    flutternotifyplugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    const String? timezone = "Europe/London";
    tz.setLocalLocation(tz.getLocation(timezone));
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
        context: ref.context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title ?? "title"),
              actions: [
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close")),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("View"))
              ],
            ));
  }

  scheduledNotification(int days, int hour, int minutes, int seconds, int id,
      String task, String from, String to, int timetaken) async {
    await flutternotifyplugin.zonedSchedule(
      id,
      "My task",
      task,
      _convertT(days, hour, minutes, seconds),
      // tz.TZDateTime.now(tz.local).add(Duration(seconds: minutes)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "${task}|${from}|${to}|${timetaken}|${0}",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  scheduledNotificationend(int days, int hour, int minutes, int seconds, int id,
      String task, String from, String to, int timetaken) async {
    await flutternotifyplugin.zonedSchedule(
      id,
      "My task",
      task,
      _convertT(days, hour, minutes, seconds),
      // tz.TZDateTime.now(tz.local).add(Duration(seconds: minutes)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "${task}|${from}|${"end"}|${timetaken}|${0}",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  scheduledNotificationRepeat(int hour, int minutes, int id, String task,
      String from, String to, int timetaken, int dayweek) async {
    await flutternotifyplugin.zonedSchedule(
      id,
      "My task",
      task,
      _convertTimeday(hour, minutes, dayweek),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "${task}|${from}|${to}|${timetaken}|${1}|",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  scheduledNotificationRepeatend(int hour, int minutes, int id, String task,
      String from, String to, int timetaken, int dayweek) async {
    await flutternotifyplugin.zonedSchedule(
      id,
      "My task",
      task,
      _convertTimeday(hour, minutes, dayweek),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "${task}|${from}|${"end"}|${timetaken}|${1}|",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _convertT(int days, int hour, int minutes, int seconds) {
    late tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime nowdue = now.add(
        Duration(days: days, hours: hour, minutes: minutes, seconds: seconds));

    return nowdue;
  }

  tz.TZDateTime _convertTimeday(int hour, int minutes, int dayOfWeek) {
    late tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduleDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, hour + 1, minutes);
    // Calculate the next occurrence of the specified day of the week
    while (scheduleDate.weekday != dayOfWeek) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  void _configureSelectNotificationSubject() {
    selectnotificationsubject.stream.listen((String? payload) async {
      var title = payload!.split('|')[0];

      showDialog(
          context: ref.context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text("Event Happening Now"),
                content: Text(title, textAlign: TextAlign.justify),
                actions: [
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Close")),
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    ViewNotification(payload: payload))));
                      },
                      child: const Text("View"))
                ],
              ));
    });
  }
}
