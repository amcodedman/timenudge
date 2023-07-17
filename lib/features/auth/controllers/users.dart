import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
part 'users.g.dart';

@riverpod
class Users extends _$Users {
  final Dio _dio = Dio();
  late bool loaded = false;
  late bool loading = false;
  late bool success = false;
  late String errormessage = "";
  late Map<String, dynamic> account = {};
  SharedPreferences? prefs;

  @override
  bool build() {
    _init();
    return false;
  }

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> getSuccess() async {
    return success;
  }

  Future<void> result(String firstname, String lastname, String username,
      String email, String password, String company, department) async {
    errormessage = "";
    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    state = true;
    try {
      var _result = await _dio.post(
        'user/preregister',
        data: {
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "password": password,
          "username": username,
          "company": company,
          "department": department,
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
      }
    } catch (e) {
      if (e is DioError) {
        state = false;
        if (e.response != null) {
          print('Error: ${e.response!.data["msg"].toString()}');
          errormessage = e.response!.data["msg"].toString();
        } else {
          print('Error: ${e.message}');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  Future<Map> saveuser() async {
    return account;
  }

  Future<void> login(String email, String password) async {
    errormessage = "";
    prefs = await SharedPreferences.getInstance();
    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    state = true;
    try {
      var _result = await _dio.post(
        'user/signin',
        data: {
          "email": email,
          "password": password,
        },
      );
      if (_result.statusCode == 200) {
        account = _result.data;
        prefs!.setString("id", account["_id"]);
        prefs!.setString("firstname", account["firstname"]);
        prefs!.setString("lastname", account["lastname"]);
        prefs!.setString("username", account["username"]);
        prefs!.setString("email", account["email"]);
        prefs!.setString("institution", account["company"]);
        prefs!.setString("department", account["department"]);
        print(prefs!.getString("email"));

        state = false;

        // Do something with the account data
        // For example, you can access specific properties like account['name'], account['email'], etc.
      } else {
        // Handle non-200 status code
        print('Login request failed with status code: ${_result}');
        state = false;
      }
    } catch (e) {
      if (e is DioError) {
        state = false;
        if (e.response != null) {
          print('Error: ${e.response!.data["msg"].toString()}');
          errormessage = e.response!.data["msg"].toString();
        } else {
          print('Error: ${e.message}');
        }
      } else {
        print('Error: $e');
      }
      state = false;
    }
  }

  Future<void> forgotpassword(String email) async {
    errormessage = "";
    print(email);
    prefs = await SharedPreferences.getInstance();
    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    state = true;
    try {
      var _result = await _dio.post(
        'user/userforgotpass',
        data: {
          "email": email,
        },
      );
      if (_result.statusCode == 200) {
        errormessage =
            "Please check your email inbox ,a link has need sent your email to reset your password";
        state = false;
        print(_result);

        // Do something with the account data
        // For example, you can access specific properties like account['name'], account['email'], etc.
      }
    } catch (e) {
      print("error");
      if (e is DioError) {
        state = false;
        if (e.response != null) {
          print('Error: ${e.response!.data["msg"].toString()}');
          errormessage = e.response!.data["msg"].toString();
        } else {
          print('Error: ${e.message}');
        }
      } else {
        print('Error: $e');
      }
      state = false;
    }
  }

  bool getStatus() {
    return success;
  }
}
