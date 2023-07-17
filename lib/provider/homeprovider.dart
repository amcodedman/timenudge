import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class HomeProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  int index = 0;

  double difficulty = 0;
  BuildContext context;
  List<dynamic>? datalist;

  HomeProvider({required this.context}) {
    _dio.options.baseUrl = "https://timenudgeservice.onrender.com/";
    print("Results");
    result();
  }
  Future<void> result() async {
    var _result = await _dio.get('user/getuser/649fe94c6e5f48d9d006d15c');
    if (_result.statusCode == 200) {
      datalist = _result.data as List<dynamic>?;
    }

    notifyListeners();
    print(datalist);
  }

  String getQuestion() {
    return datalist![0];
  }

  void nextQuestion() {
    if (index >= datalist!.length - 1) {
      showDialog(
          context: context,
          builder: (BuildContext _context) {
            return AlertDialog(
              actions: [],
              content: Column(
                children: [
                  Text("Back to beginning"),
                  Slider(
                      value: difficulty,
                      min: 0,
                      max: 2,
                      divisions: 2,
                      onChanged: (_value) {
                        difficulty = _value;
                      })
                ],
              ),
              title: Text("Next Page"),
            );
          });
      index = 0;
    }
    {
      index++;
    }

    notifyListeners();
  }
}
