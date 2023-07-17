import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
part 'expensions.g.dart';

@riverpod
class PageExpension extends _$PageExpension {
  @override
  bool build() {
    return false;
  }

  void setStart(bool newstate) {
    state = newstate;
  }
}

@riverpod
class PageExpensionSzero extends _$PageExpensionSzero {
  @override
  bool build() {
    return false;
  }

  void setStart(bool newstate) {
    state = newstate;
  }
}

@riverpod
class Homeload extends _$Homeload {
  final Dio _dio = Dio();
  late bool loaded = false;
  late List<dynamic> datalist;
  late Map<String, dynamic>? myData = {};
  late Map<String, dynamic>? timetable = {};
  late Map<String, dynamic>? institutetable = {};
  late List<dynamic>? shedule = [];

  @override
  bool build() {
    return false;
  }

  Map<String, dynamic> myDataR() {
    return myData!;
  }

  Future<void> result() async {
    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    var _result = await _dio.get('user/getuser/64a3fc6850db3d0b3e864cd4');
    if (_result.statusCode == 200) {
      datalist = _result.data;
      //   state = _result.data;
      loaded = true;

      state = true;
      myData = datalist[0];

      print(state);
    } else {
      print("NETWORK FAILED");
    }
  }
}
