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
import '../controllers/users.dart';
import 'dart:async';

class Login extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends ConsumerState<Login> {
  final TextEditingController textcontroller = TextEditingController();
  late String email;
  late String password;
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
          return const HomePage();
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
                hint: "Type your mail",
                preficon: const Icon(Ionicons.mail_open_outline),
                onChange: (value) {
                  setState(() {
                    email = value;
                  });
                }),
            const Heightspacer(value: 10),
            CustomTextField(
                secure: true,
                hint: "Type your password",
                preficon: const Icon(Ionicons.lock_open_outline),
                onChange: (value) {
                  setState(() {
                    password = value;
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
                      ref.read(usersProvider.notifier).login(email, password);
                      ref.read(usersProvider.notifier).saveuser();
                    },
                    height: 40,
                    width: 50,
                    color2: AppConsts.kGreyBk,
                    color3: AppConsts.klight,
                    text1: "Sign In"),
            const Heightspacer(value: 20),
            Row(
              children: [
                Text(
                  "You dont have an account ?",
                  style: appStyle(13, AppConsts.kBluelight, FontWeight.normal),
                ),
                const WidthSpacer(value: 10),
                CustomBtn(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return CreateAccount();
                      }));
                    },
                    height: 30,
                    width: 130,
                    color2: AppConsts.klight,
                    color3: AppConsts.kBLight,
                    text1: "create account")
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return ResetPass();
                }));
              },
              child: Text(
                "forgot Password ?",
                style: appStyle(15, AppConsts.kred, FontWeight.normal),
              ),
            ),
            const Heightspacer(value: 30)
          ],
        ),
      )),
    );
  }
}
