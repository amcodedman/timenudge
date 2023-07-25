import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timenudge/common/ultils/appstyle.dart';
import 'package:timenudge/common/ultils/constants.dart';
import 'package:timenudge/common/ultils/resuables.dart';
import 'package:timenudge/common/widgets/customebtn.dart';
import 'package:timenudge/common/widgets/customerextfield.dart';
import 'package:timenudge/common/widgets/heightspacer.dart';
import 'package:timenudge/common/widgets/widthspacer.dart';
import 'package:timenudge/features/auth/pages/createaccount.dart';
import 'package:timenudge/features/auth/pages/resetpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timenudge/features/todo/pages/homepage.dart';
import '../../todo/widgets/parentcare.dart';
import '../controllers/users.dart';
import 'dart:async';

import 'login.dart';

class Monitorlog extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Monitorlog();
  }
}

class _Monitorlog extends ConsumerState<Monitorlog> {
  final TextEditingController textcontroller = TextEditingController();
  late String mykey;

  late bool success = false;
  late SharedPreferences prefs;
  late Map account = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    success = ref.watch(usersProvider);

    account = ref.watch(usersProvider.notifier).account;
    if (account.isNotEmpty) {
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ParentCare();
        }));
      });
    }
    return Scaffold(
      backgroundColor: AppConsts.klight,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset("assets/images/task.jpg"),
            ),
            const Heightspacer(value: 10),
            Container(
              alignment: Alignment.center,
              child: Reusables(
                text: "Please enter your details",
                style: appStyle(20, AppConsts.klight, FontWeight.bold),
              ),
            ),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: false,
                hint: "Type your Support care Key",
                preficon: const Icon(Ionicons.key_outline),
                onChange: (value) {
                  setState(() {
                    mykey = value;
                  });
                }),
            const Heightspacer(value: 10),
            ref.watch(usersProvider)
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ))
                : CustomBtn(
                    onTap: () {
                      ref.read(usersProvider.notifier).loginmonitor(mykey);
                      ref.read(usersProvider.notifier).saveuser();
                    },
                    height: 40,
                    width: 50,
                    color2: AppConsts.kGreyBk,
                    color3: AppConsts.klight,
                    text1: "Continue"),
            const Heightspacer(value: 20),
            Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  ref.read(usersProvider.notifier).errormessage,
                  style: appStyle(13, AppConsts.kred, FontWeight.bold),
                )),
            const Heightspacer(value: 10),
            Row(
              children: [
                Text(
                  "Login in personal account ?",
                  style: appStyle(10, AppConsts.kBluelight, FontWeight.normal),
                ),
                const WidthSpacer(value: 10),
                CustomBtn(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return Login();
                      }));
                    },
                    height: 30,
                    width: 130,
                    color2: AppConsts.klight,
                    color3: Color.fromARGB(87, 14, 3, 51),
                    text1: "login")
              ],
            ),
            Heightspacer(value: 20),
          ],
        ),
      )),
    );
  }
}
