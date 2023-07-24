import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/features/onboarding/pages/onboarding.dart';
import 'package:timenudge/model/appconfig.dart';
import 'package:timenudge/model/http.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timenudge/features/todo/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timenudge/pages/view_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: Launch()));
}

class Launch extends StatefulWidget {
  const Launch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Launch();
  }
}

class _Launch extends State<Launch> {
  late bool islogged = false;
  @override
  void initState() {
    super.initState();
    initialPref();
  }

  Future<void> initialPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var mail = prefs.getString("email");

    if (mail != null) {
      print("mail $mail");
      setState(() {
        islogged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 825),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: "Timenudge",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppConsts.kBKDark,
              primaryColor: Color.fromARGB(255, 201, 201, 201),
              appBarTheme: AppBarTheme(
                toolbarHeight: 30,
              ),
            ),
            themeMode: ThemeMode.dark,
            home: islogged ? const HomePage() : Onboarding(),
            // home: TextPage(),
            //  home: Onboarding(),
          );
        });
  }
}
