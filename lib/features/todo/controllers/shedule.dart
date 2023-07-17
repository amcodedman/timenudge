import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'shedule.g.dart';

@riverpod
class Shedule extends _$Shedule {
  final Dio _dio = Dio();
  late bool loaded = false;
  late List<dynamic> datalist = [];
  late List<dynamic>? mydays = [];
  late Map<String, dynamic>? myData = {};
  late Map<String, dynamic>? timetable = {};
  late Map<String, dynamic>? institutetable = {};
  late List<dynamic>? shedule = [];
  late List<dynamic> mondayline = [];
  late List<dynamic> tuedayline = [];
  late List<dynamic> wednesdayline = [];
  late List<dynamic> thursdayline = [];
  late List<dynamic> fridayline = [];
  late List<dynamic> saturdayline = [];
  late List<dynamic> sundayline = [];
  late bool loading = false;
  late String mondayid = "";
  late String tuedayid = "";
  late String addmessage = "";
  late String wednesdayid = "";
  late String thursdayid = "";
  late String fridayid = "";
  late String saturdayid = "";
  late String sundayid = "";
  late String imondayid = "";
  late String ituedayid = "";
  late String iwednesdayid = "";
  late String ithursdayid = "";
  late String ifridayid = "";
  late String isaturdayid = "";
  late String isundayid = "";
  late List<dynamic> AllTasks = [];

  late List<dynamic> imondayline = [];
  late List<dynamic> ituedayline = [];
  late List<dynamic> iwednesdayline = [];
  late List<dynamic> ithursdayline = [];
  late List<dynamic> ifridayline = [];
  late List<dynamic> isaturdayline = [];
  late List<dynamic> isundayline = [];
  late List<dynamic>? instituteday = [];
  late List<dynamic>? OnetimeShedule = [];
  late Map<String, dynamic>? datas = {};
  SharedPreferences? prefs;
  @override
  bool build() {
    _init();
    return false;
  }

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  List<dynamic> mondaytask() {
    return mondayline.isEmpty ? [] : mondayline;
  }

  List<dynamic> tuedaytask() {
    return tuedayline.isEmpty ? [] : tuedayline;
  }

  List<dynamic> wednesdaytask() {
    return wednesdayline.isEmpty ? [] : wednesdayline;
  }

  List<dynamic> thurdaytask() {
    return thursdayline.isEmpty ? [] : thursdayline;
  }

  List<dynamic> fridaytask() {
    return fridayline.isEmpty ? [] : fridayline;
  }

  List<dynamic> saturdaytask() {
    return saturdayline.isEmpty ? [] : saturdayline;
  }

  List<dynamic> sundaytask() {
    return sundayline.isEmpty ? [] : sundayline;
  }

  List<dynamic> imondaytask() {
    return imondayline.isEmpty ? [] : imondayline;
  }

  List<dynamic> ituedaytask() {
    return ituedayline.isEmpty ? [] : ituedayline;
  }

  List<dynamic> iwednesdaytask() {
    return iwednesdayline.isEmpty ? [] : iwednesdayline;
  }

  List<dynamic> ithurdaytask() {
    return ithursdayline.isEmpty ? [] : ithursdayline;
  }

  List<dynamic> ifridaytask() {
    return ifridayline.isEmpty ? [] : ifridayline;
  }

  List<dynamic> isaturdaytask() {
    return isaturdayline.isEmpty ? [] : isaturdayline;
  }

  List<dynamic> isundaytask() {
    return isundayline.isEmpty ? [] : isundayline;
  }

  Map<String, dynamic> myDataR() {
    return myData!;
  }

  String getdate(String name) {
    return myData![name];
  }

  String datafromtimetable(String s) {
    return timetable![s];
  }

  List<dynamic> dayfromtimetable() {
    return mydays!;
  }

  Map<String, dynamic> dataaa() {
    return datas!;
  }

  Map<String, dynamic> instituteT() {
    return institutetable!;
  }

  String fromI(String data) {
    return institutetable![data];
  }

  List<dynamic> institutedays(String data) {
    return institutetable![data];
  }

  List<dynamic> sheduleT() {
    return shedule!;
  }

  Map<String, dynamic> toTalToDocompleted() {
    int count = 0;
    int total = 0;
    double rate = 0.01;
    AllTasks.clear();
    OnetimeShedule!.forEach((element) {
      AllTasks.add(element);
      total = total + 1;
      if (element["count"] == 1) {
        count = count + 1;
      }
    });

    List<dynamic> myDays = [
      mondayline,
      tuedayline,
      wednesdayline,
      thursdayline,
      fridayline,
      saturdayline,
      sundayline,
      imondayline,
      ituedayline,
      iwednesdayline,
      ithursdayline,
      ifridayline,
      isaturdayline,
      isundayline
    ];

    myDays.forEach((days) {
      days.forEach((element) {
        AllTasks.add(element);
        int number = element["count"];
        count = count + number;

        String dates = element["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateFormat formatter = DateFormat("EEEE, d 'of' MMMM y, h:mm a");

        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    });

    double percentage = (count / total) * 100;
    double number = double.parse(percentage.toStringAsFixed(2));
    if (number.isNaN) {
      print("Invalid");
    } else {
      rate = number / 100;
    }
    return {"success": count, "total": total, "rate": number / 100};
  }

  Map<String, dynamic> toDocompletedmonth(String month) {
    int count = 0;
    int total = 0;
    double rate = 0.01;
    int monthnumber = 1;
    if (month == "January") {
      monthnumber = 1;
    }
    if (month == "February") {
      monthnumber = 2;
    }
    if (month == "March") {
      monthnumber = 3;
    }
    if (month == "April") {
      monthnumber = 4;
    }
    if (month == "May") {
      monthnumber = 5;
    }
    if (month == "June") {
      monthnumber = 6;
    }
    if (month == "July") {
      monthnumber = 7;
    }
    if (month == "August") {
      monthnumber = 8;
    }
    if (month == "September") {
      monthnumber = 9;
    }
    if (month == "October") {
      monthnumber = 10;
    }
    if (month == "November") {
      monthnumber = 11;
    }
    if (month == "December") {
      monthnumber = 12;
    }

    OnetimeShedule!.forEach((element) {
      DateTime dateTime = DateTime.parse(element["from"]);
      if (dateTime.month == monthnumber) {
        total = total + 1;
        if (element["count"] == 1) {
          count = count + 1;
        }
      }
    });

    double percentage = (count / total) * 100;
    double number = double.parse(percentage.toStringAsFixed(2));
    if (number.isNaN) {
      print("Invalid");
    } else {
      rate = number / 100;
      print("Percent $rate");
    }
    return {"success": count, "total": total, "rate": rate};
  }

  Map<String, dynamic> toDocompletedweek(String dayn) {
    int count = 0;
    int total = 0;
    double rate = 0.01;

    if (dayn == "Monday") {
      print("sssssssssssssssssssssssssssssss");
      mondayline.forEach((days) {
        int number = days["count"];
        count = count + number;
        String dates = days["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });

      imondayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    }
    if (dayn == "Tuesday") {
      tuedayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });

      ituedayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    }
    if (dayn == "Wednesday") {
      wednesdayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });

      iwednesdayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    }
    if (dayn == "Thursday") {
      thursdayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });

      ithursdayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    }
    if (dayn == "Friday") {
      fridayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });

      ifridayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    }
    if (dayn == "Saturday") {
      saturdayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });

      isaturdayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    }
    if (dayn == "Sunday") {
      sundayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });

      isundayline.forEach((item) {
        int number = item["count"];
        count = count + number;
        String dates = item["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    }

    double percentage = (count / total) * 100;
    double number = double.parse(percentage.toStringAsFixed(2));
    if (number.isNaN) {
      print("Invalid");
    } else {
      rate = number / 100;
      print("Percent $rate");
    }
    return {"success": count, "total": total, "rate": rate};
  }

  Map<String, dynamic> toDocompleted() {
    double rate = 0.01;
    int count = 0;
    int total = 0;

    AllTasks.clear();
    OnetimeShedule!.forEach((element) {
      AllTasks.add(element);
      total = total + 1;
      if (element["count"] == 1) {
        count = count + 1;
      }
    });

    double percentage = (count / total) * 100;
    double number = double.parse(percentage.toStringAsFixed(2));
    if (number.isNaN) {
      print("Invalid");
    } else {
      rate = number / 100;
    }
    return {"success": count, "total": total, "rate": rate};
  }

  Map<String, dynamic> totalweeklytoDocompleted() {
    int count = 0;
    int total = 0;
    double rate = 0.01;
    AllTasks.clear();

    List<dynamic> myDays = [
      mondayline,
      tuedayline,
      wednesdayline,
      thursdayline,
      fridayline,
      saturdayline,
      sundayline,
      imondayline,
      ituedayline,
      iwednesdayline,
      ithursdayline,
      ifridayline,
      isaturdayline,
      isundayline
    ];

    myDays.forEach((days) {
      days.forEach((element) {
        int number = element["count"];
        count = count + number;

        String dates = element["createdAt"];

        DateTime dateTime = DateTime.parse(dates);
        DateFormat formatter = DateFormat("EEEE, d 'of' MMMM y, h:mm a");

        DateTime now = DateTime.now();
        DateTime tomorrow = now.add(Duration(days: 1));
        Duration difference = tomorrow.difference(dateTime);
        int differenceInDays = difference.inDays;
        total = total + differenceInDays;
      });
    });

    double percentage = (count / total) * 100;
    double number = double.parse(percentage.toStringAsFixed(2));
    if (number.isNaN) {
      print("Invalid");
    } else {
      rate = number / 100;
    }
    return {"success": count, "total": total, "rate": rate};
  }

  Future<void> result() async {
    prefs = await SharedPreferences.getInstance();
    late String? _id = prefs!.getString("id");

    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    var _result = await _dio.get('user/getuser/$_id');

    if (_result.statusCode == 200) {
      datalist = _result.data;
      state = true;
      //   state = _result.data;

      myData = datalist[0];

      timetable = myData!["timetable"][0];
      institutetable = myData!["institution"][0];
      mydays = timetable!["days"];
      instituteday = institutetable!["days"];
      OnetimeShedule = myData!["task"];
      prefs!.setDouble("todo_success", toTalToDocompleted()["rate"]!);
      toDocompleted();
      toDocompletedmonth("July");
      toDocompletedweek("Monday");
      //    print(" timeline ${timetable}");

      mydays!.forEach((element) {
        if (element["day"] == "Monday") {
          mondayline = element["shedules"];
          mondayid = element["_id"];
        }
        if (element["day"] == "Tuesday") {
          tuedayline = element["shedules"];
          tuedayid = element["_id"];
        }
        if (element["day"] == "Wednesday") {
          wednesdayline = element["shedules"];
          wednesdayid = element["_id"];
        }
        if (element["day"] == "Thursday") {
          thursdayline = element["shedules"];
          thursdayid = element["_id"];
        }
        if (element["day"] == "Friday") {
          fridayline = element["shedules"];
          fridayid = element["_id"];
        }
        if (element["day"] == "Saturday") {
          saturdayline = element["shedules"];
          saturdayid = element["_id"];
        }
        if (element["day"] == "Sunday") {
          sundayline = element["shedules"];
          sundayid = element["_id"];
        }
      });

      instituteday!.forEach((element) {
        if (element["day"] == "Monday") {
          imondayline = element["shedules"];
          imondayid = element["_id"];
        }
        if (element["day"] == "Tuesday") {
          ituedayline = element["shedules"];
          ituedayid = element["_id"];
        }
        if (element["day"] == "Wednesday") {
          iwednesdayline = element["shedules"];
          iwednesdayid = element["_id"];
        }
        if (element["day"] == "Thursday") {
          ithursdayline = element["shedules"];
          ithursdayid = element["_id"];
        }
        if (element["day"] == "Friday") {
          ifridayline = element["shedules"];
          ifridayid = element["_id"];
        }
        if (element["day"] == "Saturday") {
          isaturdayline = element["shedules"];
          isaturdayid = element["_id"];
        }
        if (element["day"] == "Sunday") {
          isundayline = element["shedules"];
          isundayid = element["_id"];
        }
      });
    } else {
      print("NETWORK FAILED");
    }
  }

  Future<void> addSchedule(
      String type, String title, String day, String from, String to) async {
    state = false;
    late String? _dayid = "88";
    addmessage = "";
    loading = true;
    String urlbase = "";
    if (type == "Personal table") {
      urlbase = "createregularshedule";
      if (day == "Monday") {
        _dayid = mondayid;
      }
      if (day == "Tuesday") {
        _dayid = tuedayid;
      }
      if (day == "Wednesday") {
        _dayid = wednesdayid;
      }
      if (day == "Thursday") {
        _dayid = thursdayid;
      }
      if (day == "Friday") {
        _dayid = fridayid;
      }
      if (day == "Saturday") {
        _dayid = saturdayid;
      }
      if (day == "Sunday") {
        _dayid = sundayid;
      }
    }
    if (type == "Institution") {
      urlbase = "createinstituteshedule";
      if (day == "Monday") {
        _dayid = imondayid;
      }
      if (day == "Tuesday") {
        _dayid = ituedayid;
      }
      if (day == "Wednesday") {
        _dayid = iwednesdayid;
      }
      if (day == "Thursday") {
        _dayid = ithursdayid;
      }
      if (day == "Friday") {
        _dayid = ifridayid;
      }
      if (day == "Saturday") {
        _dayid = isaturdayid;
      }
      if (day == "Sunday") {
        _dayid = isundayid;
      }
    }

    if (type == "One time schedule") {
      urlbase = "createtask";
    }

    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    prefs = await SharedPreferences.getInstance();
    String id = prefs!.getString("id").toString();
    try {
      var _result = await _dio.post('data/$urlbase', data: {
        "user": id,
        "day": _dayid,
        "title": title,
        "from": from,
        "to": to
      });

      if (_result.statusCode == 200) {
        loading = false;
        state = true;
        datas = _result.data;
        addmessage = "Added successfully";
      }
      if (_result.statusCode == 400) {
        result();
        loading = false;
        state = true;

        print("error");
      }
    } catch (error) {
      print(error);
      loading = false;
      state = true;
    }
  }

  Future<void> DeleteSchedule(String type, String ids) async {
    state = false;
    loading = true;
    String urlbase = type;

    if (type == "Personal table") {
      urlbase = "deleteshedule";
    }
    if (type == "Institution") {
      urlbase = "deleteishedule";
    }

    if (type == "One time schedule") {
      urlbase = "deletetask";
    }

    print(urlbase);
    print(type);
    print(ids);
    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    prefs = await SharedPreferences.getInstance();

    try {
      var _result = await _dio.delete(
        'data/$urlbase/$ids',
      );
      if (_result.statusCode == 200) {
        result();
        loading = false;
        state = true;
        datas = _result.data;
        print(datas);
      }
      if (_result.statusCode == 400) {
        loading = false;
        state = true;

        print("error");
      }
    } catch (error) {
      print(error);
      loading = false;
      state = true;
    }
  }

  Future<void> CompeleteSchedule(String type, String _ids, int count) async {
    late String? _dayid;
    late int save_count;
    state = false;
    loading = true;
    String urlbase = "";
    if (type == "Personal table") {
      urlbase = "modifyshedule";
      save_count = count + 1;
    }
    if (type == "Institution") {
      urlbase = "modifyishedule";
      save_count = count + 1;
    }

    if (type == "One time schedule") {
      urlbase = "modifytask";
      save_count = 1;
    }

    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    prefs = await SharedPreferences.getInstance();

    try {
      var _result = await _dio.patch('data/$urlbase/$_ids',
          data: {"count": save_count, "complete": 1});
      if (_result.statusCode == 200) {
        state = false;
        result();
        loading = false;

        datas = _result.data;
      }
      if (_result.statusCode == 400) {
        loading = false;
        state = true;

        print("error");
      }
    } catch (error) {
      print(error);
      loading = false;
      state = true;
    }
  }

  Future<void> compeleteUndo(String type, String _ids, int count) async {
    late String? _dayid;
    late int save_count;
    state = false;
    loading = true;
    String urlbase = "";
    if (type == "Personal table") {
      urlbase = "modifyshedule";
      save_count = count - 1;
    }
    if (type == "Institution") {
      urlbase = "modifyishedule";
      save_count = count - 1;
    }

    if (type == "One time schedule") {
      urlbase = "modifytask";
      save_count = 0;
    }

    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    prefs = await SharedPreferences.getInstance();

    try {
      var _result = await _dio.patch('data/$urlbase/$_ids',
          data: {"count": save_count, "complete": 0});
      if (_result.statusCode == 200) {
        state = false;
        result();
        loading = false;

        datas = _result.data;
      }
      if (_result.statusCode == 400) {
        loading = false;
        state = true;

        print("error");
      }
    } catch (error) {
      print(error);
      loading = false;
      state = true;
    }
  }

  void setloading() {
    loading = false;
  }
}
