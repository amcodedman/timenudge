import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'queries.g.dart';

@riverpod
class Query extends _$Query {
  final Dio _dio = Dio();
  late bool loaded = false;
  late bool success = false;
  SharedPreferences? prefs;

  @override
  bool build() {
    _init();
    return false;
  }

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> result(String firstname, String lastname, String username,
      String email, String password, String company, department) async {
    prefs = await SharedPreferences.getInstance();

    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    state = true;
    var _result = await _dio.post(
      'user/preregister',
      data: {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "username": username,
        "company": company,
        "department": department
      },
    );
    if (_result.statusCode == 200) {
      //    account = _result.data;
      print(_result.data);
      success = true;
      //   state = _result.data;
      loaded = true;
      state = false;
      //    print(" timeline ${timetable}");
    } else if (_result.statusCode == 400) {
      state = false;
      print(_result.statusMessage);

      print(_result);
    }
  }
}
